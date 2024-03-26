from utils import small_dict
import xmltodict
import json


unit_dict = {'Class': 'UnitType', 'Type': 'Name', 'Description': 'Description', 'iMoves': 'BaseMoves',
             'iCost': 'Cost', 'Advisor': 'AdvisorType', 'iCombat': 'Combat', 'Combat': 'RangedCombat',
             'Domain': 'Domain', 'PromotionClass': 'Combat', 'Maintenance': 'bMilitarySupport',
             'PrereqTech': 'PrereqTech'}

techs_4_to_6 = {'Type': 'TechnologyType', 'Name': 'TechnologyType', 'iCost': 'Cost', 'Repeatable': 0,
                'EmbarkUnitType': 'NULL', 'EmbarkAll': 0, 'Description': 'Description', 'EraType': 'ERA_ANCIENT',
                'Critical': 0, 'BarbarianFree': 0, 'UITreeRow': 0, 'AdvisorType': 'ADVISOR_GENERIC'}

advisor_mapping = {'ADVISOR_MILITARY': 'ADVISOR_CONQUEST', 'ADVISOR_RELIGION': 'ADVISOR_RELIGIOUS',
                   'ADVISOR_ECONOMY': 'ADVISOR_GENERIC', 'ADVISOR_GROWTH': 'ADVISOR_GENERIC',
                   'ADVISOR_SCIENCE': 'ADVISOR_TECHNOLOGY', 'ADVISOR_CULTURE': 'ADVISOR_CULTURE'}


def units_sql(civs, unique_units_to_remove, civics, kind_string, kept):
    debug_string = ""

    with open('data/CIV4UnitInfos.xml', 'r') as file:
        infos = xmltodict.parse(file.read())['Civ4UnitInfos']['UnitInfos'][('UnitInfo')]
    with open("data/unique_units.json", 'r') as json_file:
        uu = json.load(json_file)
    with open("data/heroes_civs.json", 'r') as json_file:
        heroes = json.load(json_file)
    with open("data/two_civ_units.json", 'r') as json_file:
        two_civs_units = json.load(json_file)
    with open("data/religious_units.json", 'r') as json_file:
        religious = json.load(json_file)

    with open("data/upgrade_tree_units.json", 'r') as json_file:
        upgrade_tree = json.load(json_file)

    excludes_from_four, to_keep_but_modify = kept['exclude_from_IV'], kept['units_but_modify_name']
    kept_units, units_changed_tech, = kept['units_as_is'], kept['units_tech_change']
    units_but_for_unique_civs, compat_units = kept['units_unique_civ'], kept['compat_for_VI']

    kept_units.extend(units_changed_tech)
    kept_units.extend(units_but_for_unique_civs)
    kept_units.extend(compat_units)
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

        if any([element == i['RangedCombat'] for element in
                ['UNITCOMBAT_ARCHER', 'UNITCOMBAT_ADEPT', 'UNITCOMBAT_SIEGE']]):
            i['RangedCombat'] = i['Combat']
        else:
            i['RangedCombat'] = 0

        if i['Combat'] == '0':
            i['FormationClass'] = 'FORMATION_CLASS_CIVILIAN'
        else:
            i['FormationClass'] = 'FORMATION_CLASS_LAND_COMBAT'

    religions = ['RUNES_OF_KILMORPH', 'OCTOPUS_OVERLORDS', 'THE_ORDER']
    # Filter out civ units, processing strings
    equipment = [i for i in unbuildable_only if 'EQUIP' in i['Name']]
    summons = [i for i in unbuildable_only if not ('EQUIP' in i['Name'])]

    # From infos remove unique units not based on another generic
    unique_civ_units = [i for i in infos if i.get('PrereqCiv', '')]
    has_unique_units = {uunit['PrereqCiv'] for uunit in unique_civ_units}
    unique_civ_units_by_type = [[j['Type'] for j in unique_civ_units if i == j['PrereqCiv']] for i in has_unique_units]

    # Make dictionaries of units to remove
    civ_units = {i[0]: i[1] for i in uu if i[1] in civs}
    civ_heroes = {i[0]: i[1] for i in heroes if i[1] in civs}
    double_civ_units = {i[0]: [j for j in i if j in civs][0] for i in two_civs_units if any([j in civs for j in i])}
    not_religious_units = {i[0]: i[1] for i in religious if not (i[1] in religions)}
    religious_units = {i[0]: i[1] for i in religious if i[1] in religions}
    # Filter the units based on dictionaries
    final_units = [i for i in buildable_only if not (i['Name'] in unique_units_to_remove)]
    final_units = [i for i in final_units if not (i['Name'] in not_religious_units)]
    final_units = [i for i in final_units if not i['Name'] in excludes_from_four]
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
        unit['Maintenance'] = 1
        if unit['PrereqTech'] == 'NONE':
            unit['PrereqTech'] = 'NULL'
        if unit['PrereqTech'] == 'TECH_NEVER':
            unit['PrereqTech'] = 'NULL'
            unit['Cost'] = -1
        if unit['PrereqTech'] in civics:
            unit['PrereqCivic'] = civics[unit['PrereqTech']]
            unit['PrereqTech'] = 'NULL'
        else:
            unit['PrereqCivic'] = 'NULL'
    # patch

    for unit in final_units:
        name = unit['UnitType']
        if name not in kept_units:
            kind_string += f"\n('{name}', 'KIND_UNIT'),"
            debug_string += f"'{name}',"

    replaces.pop('UNIT_SWORDSMAN')
    replaces['UNIT_MUD_GOLEM'] = 'UNIT_BUILDER'

    trait_types_to_define: list[str] = []
    # Insert TraitType for civ-unique units
    trait_types_heroes = [[unit for unit, civ in civ_heroes.items() if civ == civ_name] for civ_name in civs]
    trait_types_units = [[unit for unit, civ in civ_units.items() if civ == civ_name] for civ_name in civs]
    trait_types_double_civ_units = [[unit for unit, civ in double_civ_units.items() if civ == civ_name] for civ_name in
                                    civs]
    trait_types = [x + y + z for x, y, z in zip(trait_types_heroes, trait_types_units, trait_types_double_civ_units)]
    trait_types = {i: j for i, j in zip(civs, trait_types)}

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

    return unit_table_string, replacements_string, upgrades_string, trait_types_to_define, kind_string
