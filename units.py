from utils import small_dict, make_or_add, update_or_add
import xmltodict
import json
import logging

unit_dict = {'Class': 'UnitType', 'Type': 'Name', 'Description': 'Description', 'iMoves': 'BaseMoves',
             'iCost': 'Cost', 'Advisor': 'AdvisorType', 'iCombat': 'Combat', 'Combat': 'RangedCombat',
             'Domain': 'Domain', 'PromotionClass': 'Combat', 'Maintenance': 'bMilitarySupport',
             'PrereqTech': 'PrereqTech', 'DefaultUnitAI': 'DefaultUnitAI'}

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

exceptions = {'SLTH_UNIT_AURIC_ASCENDED': {'EnabledByReligion': 1, 'PrereqTech': 'SLTH_TECH_OMNISCIENCE'},
              'SLTH_UNIT_DRIFA': {'PrereqCivic': 'SLTH_CIVIC_DIVINE_ESSENCE'}, 'SLTH_UNIT_BRIGIT': 'UNKNOWN',
              'SLTH_UNIT_BRIGIT_HELD': 'UNKNOWN',
              'SLTH_UNIT_ROSIER_OATHTAKER': 'UNKNOWN', 'SLTH_UNIT_WORKER': 'UNKNOWN'}

UNIT_NULL = {'UnitType': 'SLTH_UNIT_NULL', 'Name': 'LOC_SLTH_UNIT_NULL_NAME', 'RangedCombat': 0, 'Domain': 'DOMAIN_LAND',
             'Description': 'LOC_SLTH_UNIT_NULL_DESCRIPTION', 'AdvisorType': 'ADVISOR_CONQUEST', 'PrereqTech': 'NULL',
             'Cost': '1', 'BaseMoves': '1', 'Combat': '1', 'Maintenance': 1,
             'TraitType': 'SLTH_TRAIT_CIVILIZATION_UNIT_NULL', 'AllowBarbarians': 1, 'BaseSightRange': 2,
             'EnabledByReligion': 0, 'PromotionClass': 'PROMOTION_CLASS_MELEE', 'Range': 0,
             'FormationClass': 'FORMATION_CLASS_LAND_COMBAT', 'CanTrain': 1, 'BuildCharges': 0, 'PrereqCivic': 'NULL'}


class Units:

    def __init__(self):
        self.abilities = {}
        self.ability_modifiers = []

    def units_sql(self, model_obj, kept):
        logger = logging.getLogger(__name__)
        civs = model_obj['select_civs']
        debug_string = ""
        with open('data/XML/Units/CIV4UnitInfos.xml', 'r') as file:
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
        six_style_dict = {f"SLTH_{i['Type']}": small_dict(i, unit_dict) for i in infos}
        useful = [{key: value for key, value in i.items() if value != 'NONE' and value != None and value != '0'} for i in
                  infos]
        builders = [{'Type': i['Type'], 'Builds': [j['BuildType'] for j in i['Builds']['Build']]} for i in useful if len(i.get('Builds', [])) > 0]
        model_obj['builders'] = builders
        # Conversions for civ vi
        for i in six_style_dict.values():
            i['TraitType'], i['AllowBarbarians'], i['UnitType'] = "NULL", 1, f"SLTH_{i['UnitType']}"
            i['BaseSightRange'], i['EnabledByReligion'] = 2, 0
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
                i['CanTrain'] = 0  # patchy

        religions = ['RUNES_OF_KILMORPH', 'OCTOPUS_OVERLORDS', 'THE_ORDER']
        no_equipment_units = {key: val for key, val in six_style_dict.items() if 'EQUIPMENT' not in key}
        unbuildable_only = {key: val for key, val in six_style_dict.items() if val['Cost'] == '-1'}
        # Filter out civ units, processing strings
        equipment = {key: val for key, val in unbuildable_only.items() if 'EQUIP' in key}
        summons = {key: val for key, val in unbuildable_only.items() if 'EQUIP' not in key}

        for unit in model_obj['civ_units']['barbarian']:
            if six_style_dict[unit]['TraitType'] != 'NULL':
                logger.error(f"Unit {unit} already has a trait, so we cant set trait_barb_but_shows_up")
            six_style_dict[unit]['TraitType'] = 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA'

        for unit in model_obj['civ_units']['not_barbarian']:
            six_style_dict[unit]['AllowBarbarians'] = 0

        for unit in model_obj['civ_units']['civ_traits']:
            six_style_dict[unit]['TraitType'] = f"SLTH_TRAIT_CIVILIZATION_{unit[5:]}"

        # Make dictionaries of units to remove
        double_civ_units = {i[0]: [j for j in i if j in civs][0] for i in two_civs_units if any([j in civs for j in i])}
        not_religious_units = {i[0]: i[1] for i in religious if not (i[1] in religions)}
        religious_units = {i[0]: i[1] for i in religious if i[1] in religions}
        # Filter the units based on dictionaries
        final_units = {key: val for key, val in six_style_dict.items() if key not in not_religious_units}

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
            unit['BuildCharges'] = 0
            unit['PrereqCivic'] = 'NULL'
            unit['UnitType'] = unit['UnitType'].replace('UNITCLASS', 'UNIT')
            if unit['UnitType'] != f"SLTH_{unit['Name']}":
                if 'EQUIPMENT' not in unit['UnitType'] and unit['UnitType'] not in ['SLTH_UNIT_SWORDSMAN', 'SLTH_UNIT_WORKER']:
                    replaces.append({'CivUniqueUnitType': f"SLTH_{unit['Name']}", 'ReplacesUnitType': unit['UnitType']})
                    trait_str = f"SLTH_TRAIT_CIVILIZATION_{unit['Name']}"
                    unit['TraitType'] = trait_str
                    model_obj['traits'][trait_str] = {'TraitType': trait_str, 'Name': f'LOC_{trait_str}_NAME',
                                              'Description': 'NULL'}
                    model_obj['kinds'][trait_str] = 'KIND_TRAIT'
                unit['UnitType'] = f"SLTH_{unit['Name']}"
            unit['Name'] = 'LOC_SLTH_' + unit['Name'] + '_NAME'
            unit['Description'] = unit['Description'].replace('TXT_KEY', 'LOC_SLTH') + '_DESCRIPTION'
            unit['AdvisorType'] = advisor_mapping[unit['AdvisorType']]
            unit['Maintenance'] = 1
            if unit['PrereqTech'] == 'NONE':
                unit['PrereqTech'] = 'NULL'
            elif unit['PrereqTech'] == 'TECH_NEVER':
                unit['PrereqTech'] = 'NULL'
            elif unit['PrereqTech'] in model_obj['civics']:
                unit['PrereqCivic'] = f"SLTH_{model_obj['civics'][unit['PrereqTech']]}"
                unit['PrereqTech'] = 'NULL'
            else:
                unit['PrereqTech'] = f"SLTH_{unit['PrereqTech']}"

        for unit, changes in exceptions.items():        # patchy
            if changes == 'UNKNOWN':
                if unit in final_units:
                    final_units.pop(unit)
            else:
                for key, val in changes.items():
                    final_units[unit][key] = val

        for key, i in final_units.items():
            if key in [f"SLTH_{j['TraitType'][24:]}" for j in model_obj['traits'].values()]:
                trait_str = f'SLTH_TRAIT_CIVILIZATION{key[4:]}'
                i['TraitType'] = trait_str
                model_obj['traits'][trait_str] = {'TraitType': trait_str, 'Name': f'LOC_{trait_str}_NAME',
                                          'Description': f'LOC_{trait_str}_DESCRIPTION'}
                model_obj['kinds'][trait_str] = 'KIND_TRAIT'

        # Insert TraitType for religion units
        trait_types_religion = {religion_name: [unit for unit, civ in religious_units.items() if civ == religion_name] for
                                religion_name in religions}
        for idx, religion in enumerate(religions):
            for key, i in final_units.items():
                if key in trait_types_religion[religions[idx]]:
                    trait_str = f'SLTH_TRAIT_RELIGION{i["UnitType"][4:]}'
                    i['TraitType'] = trait_str
                    model_obj['traits'][trait_str] = {'TraitType': trait_str, 'Name': f'LOC_{trait_str}_NAME', 'Description': f'LOC_{trait_str}_DESCRIPTION'}
                    model_obj['kinds'][trait_str] = 'KIND_TRAIT'

        hero_units = {key: val for key, val in final_units.items() if val['DefaultUnitAI'] == 'UNITAI_HERO'}
        for i in final_units.values():
            i.pop('DefaultUnitAI')

        final_units = {key: val for key, val in final_units.items() if key not in compat_units}
        update_units = {key: val for key, val in final_units.items() if key in units_to_update}
        final_units = {key: val for key, val in final_units.items() if key not in units_to_update}

        for name, unit in final_units.items():
            if name not in kept_units:
                model_obj['kinds'][name] = 'KIND_UNIT'
                debug_string += f"'{name}',"

        simple_upgrades = {unit: {'Unit': f'SLTH_{unit}', 'UpgradeUnit': f'SLTH_{upgrades[0]}'}
                           for unit, upgrades in upgrade_tree.items()}

        replaces.append({'CivUniqueUnitType': 'SLTH_UNIT_MUD_GOLEM', 'ReplacesUnitType': 'UNIT_BUILDER'})
        mud_golem = final_units['SLTH_UNIT_MUD_GOLEM']
        mud_golem['TraitType'] = 'SLTH_TRAIT_CIVILIZATION_UNIT_MUD_GOLEM'
        model_obj['traits']['SLTH_TRAIT_CIVILIZATION_UNIT_MUD_GOLEM'] = {'TraitType': 'SLTH_TRAIT_CIVILIZATION_UNIT_MUD_GOLEM',
                                                                 'Name': 'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_MUD_GOLEM_NAME',
                                                                 'Description': f'LOC_SLTH_TRAIT_CIVILIZATION_UNIT_MUD_GOLEM_DESCRIPTION'}
        model_obj['kinds']['SLTH_TRAIT_CIVILIZATION_UNIT_MUD_GOLEM'] = 'KIND_TRAIT'
        mud_golem['BuildCharges'], mud_golem['Combat'], mud_golem['RangedCombat'] = 5, 3, 1

        self.heros_builder(hero_units, model_obj)

        free_promotions = [{'UnitType': f"SLTH_{i['Type']}", 'FreePromotion': i['FreePromotions']['FreePromotion']} for i in useful
                           if i.get('FreePromotions') is not None]

        self.free_promotions_builder(free_promotions, model_obj)

        model_obj['modifiers'].generate_modifier({'PROMOTION_CHANNELING1': ''}, 'SLTH_PROMOTION', 'CHANNELING')

        type_tags = [{'Type': i['UnitType'], 'Tag': i['PromotionClass'][10:]} for i in final_units.values() if
                     i['PromotionClass'] != 'NULL']

        make_or_add(model_obj['sql_inserts'], final_units, 'Units')
        update_or_add(model_obj['sql_updates'], update_units, 'Units', ['UnitType'])
        make_or_add(model_obj['sql_inserts'], replaces, 'UnitReplaces')
        make_or_add(model_obj['sql_inserts'], simple_upgrades, 'UnitUpgrades')
        make_or_add(model_obj['sql_inserts'], type_tags, 'TypeTags')
        return model_obj

    def heros_builder(self, hero_units, model_obj):
        for hero_name, details in hero_units.items():
            model_obj['modifiers'].generate_modifier({'SLTH_ONLY_UNIT': hero_name}, 'SLTH_DEFAULT_RACE', 'BAN')

    def mage_builder(self, mage_units, model_obj):
        for unit_name, details in mage_units.items():
            model_obj['modifiers'].generate_modifier({'SLTH_CHANNELING': unit_name}, 'SLTH_DEFAULT_RACE', 'CHANNELING')

    def free_promotions_builder(self, free_promotions, model_obj):
        for i in free_promotions:
            name = i['UnitType']
            promos = i['FreePromotion']
            if isinstance(promos, dict):
                promos = [promos]
            i['FreePromotion'] = [i['PromotionType'] for i in promos]

        my_l = []
        for promo in free_promotions:
            unit_name = promo['UnitType']
            promotions = promo['FreePromotion']
            for promo in promotions:
                my_l.append(promo)
                #model_obj['modifiers'].generate_modifier({promo: unit_name}, 'SLTH_DEFAULT_RACE', 'CHANNELING')

        print(set(my_l))

