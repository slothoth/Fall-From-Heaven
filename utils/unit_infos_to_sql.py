import xmltodict
import pandas as pd
import json


def small_dict(big_dict, four_to_six_map):
    smaller_dict = {}
    for j in big_dict:
        if j in four_to_six_map:
            smaller_dict[four_to_six_map[j]] = big_dict[j]
    for to_insert, default_value in four_to_six_map.items():
        if default_value not in smaller_dict:
            smaller_dict[to_insert] = default_value
    return smaller_dict


def build_sql_table(list_of_dicts, table_name):
    schema_string = '('
    for schema_key in [i for i in list_of_dicts[0]]:
        schema_string += f'{schema_key}, '
    schema_string = schema_string[:-2] + ') VALUES\n'
    table_string = f"INSERT INTO {table_name}" + schema_string

    for item in list_of_dicts:
        table_string += "("
        for item_attribute in item.values():
            table_string += f"'{item_attribute}', "
        table_string = table_string[:-2]
        table_string += "),\n"
    table_string = table_string[:-2]
    table_string += ";\n"
    return table_string

debug_string = ""
patch_string = ""

# conn = sqlite3.connect('DebugGameplay.sqlite')
# cursor = conn.cursor()
# cursor.execute(f"SELECT BuildingType FROM Buildings")
#  = [i[0] for i in cursor.fetchall()]
with open("data/kept.json", 'r') as json_file:
    kept = json.load(json_file)
with open("data/upgrade_tree_units.json", 'r') as json_file:
    upgrade_tree = json.load(json_file)
with open("data/prereq_nullify_techs.sql", 'r') as sql_file:
    native_prereqtechs = sql_file.read()
with open("data/prereq_nullify_civics.sql", 'r') as sql_file:
    native_prereq_civics = sql_file.read()
with open('data/CIV4UnitInfos.xml', 'r') as file:
    xml_dict = xmltodict.parse(file.read())
with open('data/CIV4TechInfos.xml', 'r') as file:
    xml_tech_dict = xmltodict.parse(file.read())
with open('data/CIV4BuildingInfos.xml', 'r') as file:
    xml_building_dict = xmltodict.parse(file.read())
with open('data/CIV4CivilizationInfos.xml', 'r') as file:
    xml_civ_dict = xmltodict.parse(file.read())['Civ4CivilizationInfos']['CivilizationInfos']['CivilizationInfo']
with open("data/unique_units.json", 'r') as json_file:
    uu = json.load(json_file)
with open("data/heroes_civs.json", 'r') as json_file:
    heroes = json.load(json_file)
with open("data/two_civ_units.json", 'r') as json_file:
    two_civs_units = json.load(json_file)
with open("data/religious_units.json", 'r') as json_file:
    religious = json.load(json_file)
with open("data/existing_buildings.json", 'r') as json_file:
    exist_dict = json.load(json_file)

kept_civics, kept_techs, kept_prereqs = kept['civics'], kept['techs'], kept['kept_tech_prerequisites']
excludes_from_four, to_keep_but_modify = kept['exclude_from_IV'], kept['units_but_modify_name']
kept_units, units_changed_tech, = kept['units_as_is'], kept['units_tech_change']
units_but_for_unique_civs, compat_units = kept['units_unique_civ'], kept['compat_for_VI']
existing_buildings = exist_dict['existing_buildings']
existing_buildings_gpp = exist_dict['existing_buildings_gpp']
existing_buildings_yields = exist_dict['existing_buildings_yields']

kept_units.extend(units_changed_tech)
kept_units.extend(units_but_for_unique_civs)
kept_units.extend(compat_units)

tech_infos = xml_tech_dict['Civ4TechInfos']['TechInfos']['TechInfo']
infos = xml_dict['Civ4UnitInfos']['UnitInfos'][('UnitInfo')]
building_infos = xml_building_dict['Civ4BuildingInfos']['BuildingInfos']['BuildingInfo']
only_useful_build_infos = [{key: value for key, value in i.items() if value != 'NONE' and value != None and value != '0'} for i in building_infos]

unit_dict = {'Class': 'UnitType', 'Type': 'Name', 'Description': 'Description', 'iMoves': 'BaseMoves',
             'iCost': 'Cost', 'Advisor': 'AdvisorType', 'iCombat': 'Combat', 'Combat': 'RangedCombat',
             'Domain': 'Domain', 'PromotionClass': 'Combat', 'Maintenance': 'bMilitarySupport',
             'PrereqTech': 'PrereqTech'}

techs_4_to_6 = {'Type': 'TechnologyType', 'Name': 'TechnologyType', 'iCost': 'Cost', 'Repeatable': 0,
                'EmbarkUnitType': 'NULL', 'EmbarkAll': 0, 'Description': 'Description', 'EraType': 'ERA_ANCIENT',
                'Critical': 0, 'BarbarianFree': 0, 'UITreeRow': 0, 'AdvisorType': 'ADVISOR_GENERIC'}

buildings_4_to_6 = {'Type': 'BuildingType', 'PrereqTech': 'PrereqTech', 'iCost': 'Cost',
                    'MaxWorldInstances': -1, 'bCapital': 'MaxPlayerInstances', 'PrereqDistrict': 'DISTRICT_CITY_CENTER',
                    'iHealth': 'Housing', 'iHappiness': 'Entertainment', 'SpecialistCounts': 'CitizenSlots',
                    'Advisor': 'AdvisorType', 'GreatPeopleUnitClass': 'GreatPersonClassType',
                    'iGreatPeopleRateChange': 'PointsPerTurn', 'CommerceChanges': 'YieldType'}


advisor_mapping = {'ADVISOR_MILITARY': 'ADVISOR_CONQUEST', 'ADVISOR_RELIGION': 'ADVISOR_RELIGIOUS',
                   'ADVISOR_ECONOMY': 'ADVISOR_GENERIC', 'ADVISOR_GROWTH': 'ADVISOR_GENERIC',
                   'ADVISOR_SCIENCE': 'ADVISOR_TECHNOLOGY', 'ADVISOR_CULTURE': 'ADVISOR_CULTURE'}
# [i for i in buildings_4_to_6 if i['iTradeRoutes'] != '0']
# [i for i in chs if 'Trade' in i]
six_style_dict = [small_dict(i, unit_dict) for i in infos]
no_equipment_units = [i for i in six_style_dict if not ('EQUIPMENT' in i['Name'])]
buildable_only = [i for i in six_style_dict if not (i['Cost'] == '-1')]
# how to filter out barbarian only
unbuildable_only = [i for i in six_style_dict if i['Cost'] == '-1']

# Conversions for civ vi
for i in buildable_only:
    i['TraitType'] = "NULL"
    i['BaseSightRange'] = 2
    if i['RangedCombat'] == 'UNIT_COMBAT_NAVAL':
        i['Domain'] = 'DOMAIN_SEA'
        i['FormationClass'] = 'FORMATION_CLASS_NAVAL'

    if any([element == i['RangedCombat'] for element in ['UNITCOMBAT_ARCHER', 'UNITCOMBAT_ADEPT', 'UNITCOMBAT_SIEGE']]):
        i['RangedCombat'] = i['Combat']
    else:
        i['RangedCombat'] = 0

    if i['Combat'] == '0':
        i['FormationClass'] = 'FORMATION_CLASS_CIVILIAN'
    else:
        i['FormationClass'] = 'FORMATION_CLASS_LAND_COMBAT'

# now we are gonna filter out those civs we arent doing stuff with
civs = ['AMURITE', 'CALABIM', 'LUCHUIRP']
religions = ['RUNES_OF_KILMORPH', 'OCTOPUS_OVERLORDS', 'THE_ORDER']
# Filter out civ units, processing strings
equipment = [i for i in unbuildable_only if 'EQUIP' in i['Name']]
summons = [i for i in unbuildable_only if not ('EQUIP' in i['Name'])]

# From infos remove unique units not based on another generic
unique_civ_units = [i for i in infos if i.get('PrereqCiv', '')]
has_unique_units = {uunit['PrereqCiv'] for uunit in unique_civ_units}
unique_civ_units_by_type = [[j['Type'] for j in unique_civ_units if i == j['PrereqCiv']] for i in has_unique_units]

# Make dictionaries of units to remove
not_civ_units, civ_units = {i[0]: i[1] for i in uu if not (i[1] in civs)}, {i[0]: i[1] for i in uu if i[1] in civs}
not_civ_heroes, civ_heroes = {i[0]: i[1] for i in heroes if not (i[1] in civs)}, {i[0]: i[1] for i in heroes if
                                                                                  i[1] in civs}
not_double_civ_units = [i[0] for i in two_civs_units if not any([j in civs for j in i])]
double_civ_units = {i[0]: [j for j in i if j in civs][0] for i in two_civs_units if any([j in civs for j in i])}
not_religious_units, religious_units = {i[0]: i[1] for i in religious if not (i[1] in religions)}, {i[0]: i[1] for i in
                                                                                                    religious if
                                                                                                    i[1] in religions}
# Filter the units based on dictionaries
final_units = [i for i in buildable_only if not (i['Name'] in not_civ_units)]
final_units = [i for i in final_units if not (i['Name'] in not_civ_heroes)]  # heroes removal
final_units = [i for i in final_units if not (i['Name'] in [j['Type'] for j in unique_civ_units])]  # units removal
final_units = [i for i in final_units if not i['Name'] in not_double_civ_units]
final_units = [i for i in final_units if not (i['Name'] in not_religious_units)]
final_units = [i for i in final_units if not i['Name'] in excludes_from_four]
final_units, never = [i for i in final_units if i['PrereqTech'] != 'TECH_NEVER'], [i for i in final_units if
                                                                                   i['PrereqTech'] == 'TECH_NEVER']

# filter for our upgrades table too
to_pop = []
names = [i['Name'] for i in final_units]
for unit, upgrade in upgrade_tree.items():
    if unit in names:
        viable_upgrades = [i for i in upgrade if i in names]
        upgrade_tree[unit] = viable_upgrades
    else:
        to_pop.append(unit)

for unit in to_pop:
    upgrade_tree.pop(unit)

# now do formatting for 6 style tables
replaces = {}
for unit in final_units:
    unit['UnitType'] = unit['UnitType'].replace('UNITCLASS', 'UNIT')
    if unit['UnitType'] != unit['Name']:
        replaces[unit['Name']] = unit['UnitType']
        unit['UnitType'] = unit['Name']
    unit['Name'] = 'LOC_' + unit['Name'] + '_NAME'
    unit['Description'] = unit['Description'].replace('TXT_KEY', 'LOC') + '_DESCRIPTION'
    unit['AdvisorType'] = advisor_mapping[unit['AdvisorType']]
    if unit['PrereqTech'] == 'NONE':
        unit['PrereqTech'] = 'NULL'
    unit['Maintenance'] = 1
# patch

replaces.pop('UNIT_SWORDSMAN')
replaces['UNIT_MUD_GOLEM'] = 'UNIT_BUILDER'

# do tech - civic prereqs Conversions
with open('data/techs.sql', 'r') as file:
    techsql = file.read()

techsql = techsql.splitlines()
defined_civic_and_traits = techsql[2:]
civics = {}
techs = []
for line in defined_civic_and_traits:
    formatted = line[2:-3].split("', '")
    if 'TECH' in formatted[1]:
        techs.append(formatted[0])
    elif 'CIVIC' in formatted[1]:
        civics['TECH' + formatted[0][5:]] = formatted[0]

for unit in final_units:
    if unit['PrereqTech'] in civics:
        unit['PrereqCivic'] = civics[unit['PrereqTech']]
        unit['PrereqTech'] = 'NULL'
    else:
        unit['PrereqCivic'] = 'NULL'

trait_types_to_define: list[str] = []
# Insert TraitType for civ-unique units
trait_types_heroes = [[unit for unit, civ in civ_heroes.items() if civ == civ_name] for civ_name in civs]
trait_types_units = [[unit for unit, civ in civ_units.items() if civ == civ_name] for civ_name in civs]
trait_types_double_civ_units = [[unit for unit, civ in double_civ_units.items() if civ == civ_name] for civ_name in
                                civs]
trait_types = [x + y + z for x, y, z in zip(trait_types_heroes, trait_types_units, trait_types_double_civ_units)]
trait_types = {i: j for i, j in zip(civs, trait_types)}

count = 0
for idx, civ in enumerate(civs):
    for i in final_units:
        if i['UnitType'] in trait_types[civs[idx]]:
            trait_str = f'TRAIT_CIVILIZATION_UNIT{i["UnitType"][4:]}'
            i['TraitType'] = trait_str
            trait_types_to_define.append(trait_str)
# Insert TraitType for religion units
trait_types_religion = {religion_name: [unit for unit, civ in religious_units.items() if civ == religion_name] for
                        religion_name in religions}
for idx, religion in enumerate(religions):
    for i in final_units:
        if i['UnitType'] in trait_types_religion[religions[idx]]:
            trait_str = f'TRAIT_RELIGION_UNIT{i["UnitType"][4:]}'
            i['TraitType'] = trait_str
            trait_types_to_define.append(trait_str)

final_units = [i for i in final_units if i['UnitType'] not in compat_units]
unit_military_engineer_issues = ['Improvement_ValidBuildUnits', "Route_ValidBuildUnits",
                                 "Building_BuildChargeProductions", "District_BuildChargeProductions"]
update_string = ""
for table in unit_military_engineer_issues:
    patch_string += f"UPDATE {table} SET UnitType = 'UNIT_BUILDER' WHERE UnitType = 'UNIT_MILITARY_ENGINEER';\n"
delete_string = ""
delete_string += """DELETE FROM Technologies;
DELETE FROM TechnologyPrereqs;
DELETE FROM Technologies_XP2;
DELETE FROM Civics;
DELETE FROM CivicPrereqs;
DELETE FROM Civics_XP2;
DELETE FROM Buildings;
DELETE FROM Building_YieldChanges;
DELETE FROM Building_GreatPersonPoints;
DELETE FROM Unit_BuildingPrereqs;
DELETE FROM UnitUpgrades;
DELETE FROM Boosts;
"""

delete_string += f"DELETE FROM Units WHERE UnitType NOT IN ("
for unit in compat_units:
    delete_string += f"'{unit}', "
delete_string = delete_string[:-2] + ');\n'
# delete_string += f"DELETE FROM UnitReplaces WHERE CivUniqueUnitType is not null;\n"
# delete_string += f"DELETE FROM Units_XP2 WHERE UnitType is not null;\n"
# delete_string += f"DELETE FROM Units WHERE UnitType NOT IN ({unit_list});\n"

patch_string += ("UPDATE RandomAgendaCivicTags SET CivicType = 'CIVIC_FEUDALISM' "
                  "WHERE CivicType = 'CIVIC_NATIONALISM';\n")
patch_string += f"DELETE from Routes_XP2 WHERE PrereqTech is 'TECH_STEAM_POWER';\n"

schema_string = '('
for schema_key in [i for i in final_units[0]]:
    schema_string += f'{schema_key}, '
schema_string = schema_string[:-2] + ') VALUES\n'
unit_table_string = "INSERT INTO Units" + schema_string
for unit in final_units:
    unit_table_string += "("
    for attribute in unit:
        unit_table_string += f"'{unit[attribute]}', "
    unit_table_string = unit_table_string[:-2] + "),\n"
unit_table_string = unit_table_string[:-2] + ";\n"
replacements_string = 'INSERT INTO UnitReplaces(CivUniqueUnitType, ReplacesUnitType) VALUES\n'
for unique_unit, original_unit in replaces.items():
    replacements_string += f"('{unique_unit}', '{original_unit}'),\n"
    debug_string += f"('{unique_unit}',"
debug_string += "\n"
replacements_string = replacements_string[:-2] + ";\n"
upgrades_string = "INSERT INTO UnitUpgrades(Unit, Upgradeunit) VALUES\n"
# upgrade tree, commented out for multiple upgrades, whicn is not supported in 6
for unit, upgrades in upgrade_tree.items():
    # for upgrade in upgrades:
    # upgrades_string += f"('{unit}', '{upgrade}'),\n"
    upgrades_string += f"('{unit}', '{upgrades[0]}'),\n"
upgrades_string = upgrades_string[:-2] + ";\n"

with open('../Core/initial_units.sql', 'w') as file:
    file.write(delete_string + unit_table_string + replacements_string + upgrades_string)

loc_string = 'INSERT OR REPLACE INTO LocalizedText (Language, Tag, Text)\n VALUES\n'
for unit in final_units:
    en_name = ' '.join([word.capitalize() for word in unit['Name'][4:-4].split('_')])[:-1]
    loc_string += f"('en_us', '{unit['Name']}', '{en_name}'),\n"
    loc_string += f"('en_us', '{unit['Description']}',  'Description'),\n"
    loc_string += f"('en_us', 'LOC_PEDIA_UNITS_PAGE_{unit['Name'][4:-4]}CHAPTER_HISTORY_PARA_1', 'DESCRIPTION'),\n"
loc_string = loc_string[:-2] + ';'

with open('../Core/localization.sql', 'w') as file:
    file.write(loc_string)

ui_tree_map = pd.read_csv('data/ui_tree.csv')
ui_tree_map = ui_tree_map.set_index('tech').apply(lambda x: x.tolist(), axis=1).to_dict()
ui_civic_tree = pd.read_csv('data/civic_ui_tree.csv')
ui_civic_tree = ui_civic_tree.set_index('civic').apply(lambda x: x.tolist(), axis=1).to_dict()
era_map = ['ERA_ANCIENT', 'ERA_CLASSICAL', 'ERA_MEDIEVAL', 'ERA_RENAISSANCE', 'ERA_INDUSTRIAL', 'ERA_MODERN',
           'ERA_ATOMIC', 'ERA_INFORMATION']
tech_string = ""

six_techs = [small_dict(i, techs_4_to_6) for i in tech_infos]
six_style_techs = [i for i in six_techs if i['TechnologyType'] in techs]
for tech in six_style_techs:
    tech['Name'] = 'LOC_' + tech['TechnologyType'] + '_NAME'
    tech['Description'] = 'LOC_' + tech['TechnologyType'] + '_DESCRIPTION'
    tech['Cost'] = int(int(tech['Cost']) / 4)
    tech['UITreeRow'] = ui_tree_map[tech['TechnologyType']][0]
    tech['EraType'] = era_map[int(ui_tree_map[tech['TechnologyType']][1])]

six_style_civics = [i for i in six_techs if i['TechnologyType'] in civics]
for civic in six_style_civics:
    civic['CivicType'] = civics[civic['TechnologyType']]
    civic.pop('TechnologyType')
    civic.pop('Critical')
    civic['Description'] = 'LOC_' + civic['CivicType'] + '_DESCRIPTION'
    civic['Name'] = 'LOC_' + civic['CivicType'] + '_NAME'
    civic['UITreeRow'] = ui_civic_tree[civic['CivicType']][0]
    civic['EraType'] = era_map[int(ui_civic_tree[civic['CivicType']][1])]

civ_only_buildings = [i for i in building_infos if not 'BUILDING' + i['BuildingClass'][13:] == i['Type']]
six_style_build_dict = [small_dict(i, buildings_4_to_6) for i in building_infos]
map_specialists = {'SPECIALIST_SCIENTIST': 'DISTRICT_CAMPUS', 'SPECIALIST_ENGINEER': 'DISTRICT_INDUSTRIAL_ZONE',
                   'SPECIALIST_PRIEST': 'DISTRICT_HOLY_SITE', 'SPECIALIST_ARTIST': 'DISTRICT_THEATER',
                   'SPECIALIST_MERCHANT': 'DISTRICT_COMMERCIAL_HUB'}

for building in six_style_build_dict:
    building['AdvisorType'] = advisor_mapping[building['AdvisorType']]
    building['Name'] = 'LOC_' + building['BuildingType'] + '_NAME'
    building['Description'] = 'LOC_' + building['BuildingType'] + '_DESCRIPTION'
    if building['PrereqTech'] in civics:
        building['PrereqCivic'] = civics[building['PrereqTech']]
        building['PrereqTech'] = 'NULL'
    else:
        building['PrereqCivic'] = 'NULL'
    if building['PrereqTech'] == 'NONE':
        building['PrereqTech'] = 'NULL'
    if building['MaxPlayerInstances'] == '0':
        building['MaxPlayerInstances'] = -1
    if building.get('CitizenSlots', False):
        specialists = building['CitizenSlots']['SpecialistCount']
        if isinstance(specialists, dict):
            building['PrereqDistrict'] = map_specialists[specialists['SpecialistType']]
            building['CitizenSlots'] = specialists['iSpecialistCount']
        else:
            if "TEMPLE" in building['BuildingType']:
                building['PrereqDistrict'] = "DISTRICT_HOLY_SITE"
                building['CitizenSlots'] = 1
            else:
                debug_string += f"building['BuildingType'] has multiple specialists, hard to assign"
                building['CitizenSlots'] = 0
    else:
        building['CitizenSlots'] = 'NULL'

    if int(building['Cost']) < 1:
        building['Cost'] = -1


unbuildable_buildings = [i for i in six_style_build_dict if int(i['Cost']) < 1]
buildable_buildings = [i for i in six_style_build_dict if int(i['Cost']) > 0]
commerce_map = ['YIELD_GOLD', 'YIELD_SCIENCE', 'YIELD_CULTURE']
building_yield_changes = []
for building in six_style_build_dict:
    if building.get('YieldType', None):
        for idx, amount in enumerate(building['YieldType']['iCommerce']):
            if int(amount) != 0:
                building_yield_changes.append({'BuildingType': building['BuildingType'], 'YieldType': commerce_map[idx],
                                           'YieldChange': amount})

gpp_map = {'UNITCLASS_PROPHET': 'GREAT_PERSON_CLASS_PROPHET', 'UNITCLASS_COMMANDER': 'GREAT_PERSON_CLASS_GENERAL',
           'UNITCLASS_MERCHANT': 'GREAT_PERSON_CLASS_MERCHANT', 'UNITCLASS_ENGINEER': 'GREAT_PERSON_CLASS_ENGINEER',
           'UNITCLASS_SCIENTIST': 'GREAT_PERSON_CLASS_SCIENTIST', 'UNITCLASS_ARTIST': 'GREAT_PERSON_CLASS_ARTIST',
           'UNITCLASS_ADVENTURER': 'GREAT_PERSON_CLASS_WRITER'}
building_great_person_points = []
for building in six_style_build_dict:
    if building['GreatPersonClassType'] != 'NONE':
        building_great_person_points.append({'BuildingType': building['BuildingType'],
                                             'GreatPersonClassType': gpp_map[building['GreatPersonClassType']],
                                             'PointsPerTurn': building['PointsPerTurn']})

for d in six_style_build_dict:
    for key in ['GreatPersonClassType', 'PointsPerTurn', 'YieldType']:
        d.pop(key, None)

# six_style_build_dict = [i for i in six_style_build_dict if int(i['Cost']) > 0]

tech_table_string = build_sql_table(six_style_techs, 'Technologies')

civic_table_string = build_sql_table(six_style_civics, 'Civics')
patch_string += f"UPDATE Resource_Harvests SET PrereqTech = 'TECH_AGRICULTURE' WHERE PrereqTech = 'TECH_POTTERY';\n"

buildings_dict_existing = [i for i in six_style_build_dict if i['BuildingType'] in existing_buildings]
six_style_build_dict = [i for i in six_style_build_dict if not i['BuildingType'] in existing_buildings]

building_gpp_existing = [i for i in building_great_person_points if i['BuildingType'] in existing_buildings_gpp]
building_great_person_points = [i for i in building_great_person_points if not i['BuildingType'] in existing_buildings_gpp]

building_yield_existing = [i for i in building_yield_changes if i['BuildingType'] in existing_buildings_yields]
building_yield_changes = [i for i in building_yield_changes if not i['BuildingType'] in existing_buildings_yields]

building_table_string = build_sql_table(six_style_build_dict, 'Buildings')
building_table_string += build_sql_table(building_great_person_points, 'Building_GreatPersonPoints')
building_table_string += build_sql_table(building_yield_changes, 'Building_YieldChanges')


kind_string = ""

for tech_type_to_add in techsql:
    first_val = tech_type_to_add[2:].split("',")[0]
    if not ('TECH' in first_val or 'CIVIC' in first_val):
        kind_string += tech_type_to_add + '\n'
    elif not (first_val in kept_techs or first_val in kept_civics):
        kind_string += tech_type_to_add + '\n'

kind_string = kind_string[:-2] + ','

for unit in final_units:
    name = unit['UnitType']
    if name not in kept_units:
        kind_string += f"\n('{name}', 'KIND_UNIT'),"
        debug_string += f"'{name}',"

traits_string = "INSERT INTO Traits(TraitType, Name, Description, InternalOnly) VALUES"
for trait in trait_types_to_define:
    kind_string += f"\n('{trait}', 'KIND_TRAIT'),"
    traits_string += f"\n('{trait}', '{'LOC_' + trait + '_NAME'}', NULL, 0),"
    debug_string += f"'{trait}',"

for building in six_style_build_dict:
    kind_string += f"\n('{building['BuildingType']}', 'KIND_BUILDING'),"

traits_string = traits_string[:-1] + ";\n"
kind_string = kind_string[:-1] + ';\n'

with open('data/prereqstechs.sql', 'r') as file:
    prereqs_tech = file.readlines()
    prereqs_string = "".join(prereqs_tech[:2])
    prereqs_string += "".join([i for i in prereqs_tech[2:]])

prereqs_string = prereqs_string[:-1] + ";\n"
with open('data/prereqscivics.sql', 'r') as file:
    prereqs_string += file.read() + "\n"


with open('debug.txt', 'w') as file:
    file.write(debug_string)

total = (delete_string + kind_string + tech_string + '\n' + tech_table_string + civic_table_string + prereqs_string
         + building_table_string + update_string + traits_string + unit_table_string + replacements_string
         + upgrades_string + patch_string)
total_with_null = total.replace("'NULL'", "NULL")
with open('../Core/techs_civics.sql', 'w') as file:
    file.write(total_with_null)
