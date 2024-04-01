from utils import small_dict, localization, build_sql_table, update_sql_table
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
                   'ADVISOR_SCIENCE': 'ADVISOR_TECHNOLOGY', 'ADVISOR_CULTURE': 'ADVISOR_CULTURE',
                   'NONE': 'NULL'}

combat_map = {'UNITCOMBAT_NAVAL': 'PROMOTION_CLASS_NAVAL_MELEE', 'UNITCOMBAT_SIEGE': 'PROMOTION_CLASS_SIEGE',
              'UNITCOMBAT_MELEE': 'PROMOTION_CLASS_MELEE', 'UNITCOMBAT_ARCHER': 'PROMOTION_CLASS_RANGED',
              'UNITCOMBAT_MOUNTED': 'PROMOTION_CLASS_LIGHT_CAVALRY', 'UNITCOMBAT_RECON': 'PROMOTION_CLASS_RECON',
              'UNITCOMBAT_ANIMAL': 'PROMOTION_CLASS_ANIMAL', 'UNITCOMBAT_BEAST': 'PROMOTION_CLASS_BEAST',
              'UNITCOMBAT_DISCIPLE': 'PROMOTION_CLASS_DISCIPLE', 'UNITCOMBAT_ADEPT': 'PROMOTION_CLASS_ADEPT',
              'NONE': 'NULL'}

exceptions = {'UNIT_LOKI': {}, 'UNIT_LUCIAN': {'CanTrain': 0}}


def units_sql(civs, unique_units_to_remove, civics, kinds, trait_types, kept):
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
    units_to_update, units_changed_tech = kept['units_as_is'], kept['units_tech_change']
    units_but_for_unique_civs, compat_units = kept['units_unique_civ'], kept['compat_for_VI']
    units_to_update.extend(units_but_for_unique_civs)
    kept_units = units_to_update
    kept_units.extend(units_changed_tech)
    kept_units.extend(compat_units)
    six_style_dict = {i['Type']: small_dict(i, unit_dict) for i in infos}

    # Conversions for civ vi
    for i in six_style_dict.values():
        i['TraitType'] = "NULL"
        i['BaseSightRange'] = 2
        i['PromotionClass'] = combat_map[i['RangedCombat']]
        if i['RangedCombat'] == 'UNIT_COMBAT_NAVAL':
            i['Domain'] = 'DOMAIN_SEA'
            i['FormationClass'] = 'FORMATION_CLASS_NAVAL'

        if any([element == i['RangedCombat'] for element in
                ['UNITCOMBAT_ARCHER', 'UNITCOMBAT_ADEPT', 'UNITCOMBAT_SIEGE']]):
            i['RangedCombat'], i['Range'] = i['Combat'], 2
        else:
            i['RangedCombat'], i['Range'] = 0, 0

        if i['Combat'] == '0':
            i['FormationClass'] = 'FORMATION_CLASS_CIVILIAN'
        else:
            i['FormationClass'] = 'FORMATION_CLASS_LAND_COMBAT'

        i['CanTrain'] = 0 if i['Cost'] == '-1' else 1
        if 'SLAVE' in i['UnitType']:
            i['CanTrain'] = 0                           # patchy

    religions = ['RUNES_OF_KILMORPH', 'OCTOPUS_OVERLORDS', 'THE_ORDER']
    no_equipment_units = {key: val for key, val in six_style_dict.items() if 'EQUIPMENT' not in key}
    unbuildable_only = {key: val for key, val in six_style_dict.items() if val['Cost'] == '-1'}
    # Filter out civ units, processing strings
    equipment = {key: val for key, val in unbuildable_only.items() if 'EQUIP' in key}
    summons = {key: val for key, val in unbuildable_only.items() if 'EQUIP' not in key}

    # From infos remove unique units not based on another generic
    unique_civ_units = [i for i in infos if i.get('PrereqCiv', '')]
    has_unique_units = {uunit['PrereqCiv'] for uunit in unique_civ_units}

    # Make dictionaries of units to remove
    double_civ_units = {i[0]: [j for j in i if j in civs][0] for i in two_civs_units if any([j in civs for j in i])}
    not_religious_units = {i[0]: i[1] for i in religious if not (i[1] in religions)}
    religious_units = {i[0]: i[1] for i in religious if i[1] in religions}
    # Filter the units based on dictionaries
    final_units = {key: val for key, val in six_style_dict.items() if key not in not_religious_units}
    unique_units_to_remove = {key: [i for i in j if i not in [k for k in double_civ_units]]
                              for key, j in unique_units_to_remove.items()}

    SWORDSMAN, TREBUCHET = final_units['UNIT_SWORDSMAN'], final_units['UNIT_TREBUCHET']
    for civ, civ_units_to_remove in unique_units_to_remove.items():
        if civ[13:] not in civs:
            final_units = {key: val for key, val in final_units.items()
                           if key not in [j for j in civ_units_to_remove]}

    final_units = {key: val for key, val in final_units.items() if key not in excludes_from_four}

    buildable_only = {key: val for key, val in final_units.items() if val['Cost'] != '-1'}
    # filter for our upgrades table too
    to_pop = []
    names = [i['Name'] for i in buildable_only.values()]
    for unit, upgrade in upgrade_tree.items():
        if unit in names:
            viable_upgrades = [i for i in upgrade if i in names]
            upgrade_tree[unit] = viable_upgrades
        else:
            to_pop.append(unit)

    for unit in to_pop:
        upgrade_tree.pop(unit)

    # now do formatting for 6 style tables
    replaces = []
    for key, unit in final_units.items():
        unit['UnitType'] = unit['UnitType'].replace('UNITCLASS', 'UNIT')
        if unit['UnitType'] != unit['Name']:
            if 'EQUIPMENT' not in unit['UnitType'] and unit['UnitType'] not in ['UNIT_SWORDSMAN', 'UNIT_WORKER']:
                replaces.append({'CivUniqueUnitType': unit['Name'], 'ReplacesUnitType': unit['UnitType']})
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

    for unit, changes in exceptions.items():                                             # patchy
        if unit in final_units:
            for change_name, change_value in changes.items():
                final_units[unit][change_name] = change_value

    for name, unit in final_units.items():
        if name not in kept_units:
            kinds[name] = 'KIND_UNIT'
            debug_string += f"'{name}',"

    replaces.append({'CivUniqueUnitType': 'UNIT_MUD_GOLEM', 'ReplacesUnitType': 'UNIT_BUILDER'})

    for civ in civs:
        for key, i in final_units.items():
            if key in [j['TraitType'][19:] for j in trait_types]:
                trait_str = f'TRAIT_CIVILIZATION_UNIT{key[4:]}'
                i['TraitType'] = trait_str
    # Insert TraitType for religion units
    trait_types_religion = {religion_name: [unit for unit, civ in religious_units.items() if civ == religion_name] for
                            religion_name in religions}
    for idx, religion in enumerate(religions):
        for key, i in final_units.items():
            if key in trait_types_religion[religions[idx]]:
                trait_str = f'TRAIT_RELIGION_UNIT{i["UnitType"][4:]}'
                i['TraitType'] = trait_str
                trait_types.append({'TraitType': trait_str, 'Name': f'LOC_{trait_str}_NAME', 'Description': 'NULL'})
                kinds[trait_str] = 'KIND_TRAIT'

    final_units = {key: val for key, val in final_units.items() if key not in compat_units}
    update_units = {key: val for key, val in final_units.items() if key in units_to_update}
    final_units = {key: val for key, val in final_units.items() if key not in units_to_update}

    upgrades_string = "INSERT INTO UnitUpgrades(Unit, Upgradeunit) VALUES\n"
    # upgrade tree, commented out for multiple upgrades, whicn is not supported in 6
    for unit, upgrades in upgrade_tree.items():
        # for upgrade in upgrades:
        # upgrades_string += f"('{unit}', '{upgrade}'),\n"
        upgrades_string += f"('{unit}', '{upgrades[0]}'),\n"
    upgrades_string = upgrades_string[:-2] + ";\n"

    # patch khazad cuz im mad, also patch back in swordsman for testing sanity as barbs are wreckin
    TREBUCHET['TraitType'], TREBUCHET['UnitType'] = 'TRAIT_CIVILIZATION_UNIT_TREBUCHET', 'UNIT_TREBUCHET'
    SWORDSMAN['UnitType'], SWORDSMAN['Maintenance'] = 'UNIT_SWORDSMAN', 1
    update_units['UNIT_TREBUCHET'], update_units['UNIT_SWORDSMAN'] = TREBUCHET, SWORDSMAN
    unit_table_string = build_sql_table(final_units, 'Units')
    unit_table_string += update_sql_table(update_units, 'Units', ['UnitType'])
    replacements_string = build_sql_table(replaces, 'UnitReplaces')

    localization(final_units)
    return unit_table_string, replacements_string, upgrades_string, trait_types, kinds
