import xmltodict
from utils import small_dict, make_or_add
from collections import Counter

civ_patch = {'MERCURIANS': ['UNIT_ANGEL_OF_DEATH', 'UNIT_OPHANIM', 'UNIT_SERAPH', 'UNIT_REPENTANT_ANGEL',
                                'UNIT_VALKYRIE', 'UNIT_HERALD'],
                 'BANNOR': ['UNIT_DEMAGOG', 'UNIT_FLAGBEARER'], 'BALSERAPHS': ['UNIT_FREAK'],
                 'ILLIANS': ['UNIT_HIGH_PRIEST_OF_WINTER'], 'KURIOTATES': ['UNIT_HERNE'], 'DOVIELLO': ['UNIT_LUCIAN'],
                 'LANUN': ['UNIT_BLACK_WIND']}

civ_mapper = {'Type': 'CivilizationType', 'ShortDescription': 'Name', 'Description': 'Description',
              'Adjective': 'Adjective'}

civ_extras_mapper = {'Type': 'CivilizationType', 'Cities': 'Cities', 'Leaders': 'Leaders', 'CivTrait': 'CivTrait',
                     'Hero': 'Hero'}

ethnicity_mapper = {}       # TODO design doc decision

# For lanun Pearls INSERT INTO MY_TABLE(ModifierId, Name, Type, "Value") VALUES ('GOVERNOR_PROMOTION_HERMETIC_ORDER_1_UNLOCK_LEY_LINE', 'ResourceType', 'ARGTYPE_IDENTITY', 'RESOURCE_LEY_LINE');

class Civilizations:
    def __init__(self):
        self.trait_modifiers = []
        self.unit_abilities = []
        self.ability_modifiers = []
        self.type_tags = []
        self.civ_traits = []

    def civilizations(self, model_obj):
        with open('data/XML/Civilizations/CIV4CivilizationInfos.xml', 'r') as file:
            civ_dict = xmltodict.parse(file.read())['Civ4CivilizationInfos']['CivilizationInfos']['CivilizationInfo']

        with open('data/XML/Units/CIV4UnitInfos.xml', 'r') as file:
            infos = xmltodict.parse(file.read())['Civ4UnitInfos']['UnitInfos'][('UnitInfo')]

        with open('data/XML/Buildings/CIV4BuildingInfos.xml', 'r') as file:
            building_infos = xmltodict.parse(file.read())['Civ4BuildingInfos']['BuildingInfos']['BuildingInfo']

        default = [i for i in infos if f"UNIT_{i['Class'][10:]}" == i['Type']]

        civ_unique_buildings = {i['Type']: {'Type': i['Type'], 'PrereqCiv': i['PrereqCiv']} for i in building_infos if
                                i['BuildingClass'].replace('BUILDINGCLASS', 'BUILDING') != i['Type'] and i['PrereqCiv']}
    
        civ_extras = [small_dict(i, civ_extras_mapper) for i in civ_dict]
        civ_extras = {f"SLTH_{i.pop('CivilizationType')}": i for i in civ_extras}
        for civ_remove in ['SLTH_CIVILIZATION_BARBARIAN', 'SLTH_CIVILIZATION_RANDOM']:
            civ_extras.pop(civ_remove)

        civ_dict = {i['Type']: i for i in civ_dict}
        for i in civ_dict.values():
            i['Units']['Unit'] = {j['UnitClassType']:j['UnitType'] for j in i['Units']['Unit']}
        civ_dict.pop('CIVILIZATION_RANDOM')

        string_counts = Counter()
        civ_building_replace = []
        no_access_building, building_replaces, traits, barb_unit_traits, not_barb = {}, {}, {}, {}, {}
        civ_units = {'barbarian': [], 'not_barbarian': [], 'civ_traits': [], 'dev_null': {}}
        civ_buildings = {'civ_traits': [], 'dev_null': {}}
        for civ_name, civ in civ_dict.items():
            if isinstance(civ['Buildings']['Building'], dict):
                civ['Buildings']['Building'] = [civ['Buildings']['Building']]
            no_access_building[civ_name] = [build['BuildingClassType'].replace('BUILDINGCLASS', 'BUILDING')
                                       for build in civ['Buildings']['Building']
                                       if 'NONE' in build['BuildingType']]

            building_replaces[civ_name] = [build for build in civ['Buildings']['Building']
                                      if 'CIV_BUILDING' not in build['BuildingClassType']
                                      and 'NONE' not in build['BuildingType']]

            no_access = [i['Class'] for i in default if
                         i['Class'] in [unitclass for unitclass, unittype in civ['Units']['Unit'].items()
                                        if unittype == 'NONE']]
            string_counts.update(no_access)

        for civ, building_list in no_access_building.items():
            if not civ_buildings['dev_null'].get(civ, False):
                civ_buildings['dev_null'][civ] = []
            for building in building_list:
                civ_buildings['dev_null'][civ].append(f"SLTH_{building}")

        for civ, building_list in building_replaces.items():
            for i in building_list:
                if 'BUILDING_PALACE' not in i['BuildingType']:
                    trait_type = f"SLTH_TRAIT_CIVILIZATION_{i['BuildingType']}"
                    model_obj['traits'][trait_type] = {'TraitType': trait_type, 'Name': f'LOC_{trait_type}_NAME',
                                          'Description':  f"LOC_{trait_type}_DESCRIPTION"}
                    model_obj['kinds'][trait_type] = 'KIND_TRAIT'
                    self.civ_traits.append({'TraitType': trait_type, 'CivilizationType': f"SLTH_{civ}"})
                    civ_building_replace.append({'ReplacesBuildingType': f"SLTH_{i['BuildingClassType'].replace('INGCLASS', 'ING')}",
                                                 'CivUniqueBuildingType': f"SLTH_{i['BuildingType']}"})
                    civ_buildings['civ_traits'].append(f"SLTH_{i['BuildingType']}")

        for building, civ in civ_unique_buildings.items():
            trait_type = f"SLTH_TRAIT_CIVILIZATION_{building}"
            model_obj['traits'][trait_type] = {'TraitType': trait_type, 'Name': f'LOC_{trait_type}_NAME',
                                  'Description': f'LOC_{trait_type}_DESCRIPTION'}
            model_obj['kinds'][trait_type] = 'KIND_TRAIT'
            self.civ_traits.append({'TraitType': trait_type, 'CivilizationType': f"SLTH_{civ['PrereqCiv']}"})
            civ_buildings['civ_traits'].append(f"SLTH_{building}")

        unit_not_in = {i: [] for i in string_counts.keys()}
        unit_replaces, building_replaces = {}, {}
        civ_unit_replaced, civ_replacements_basic = {}, {}
        for civ, details in civ_dict.items():
            no_access = [i['Class'] for i in default if
                         i['Class'] in [unitclass for unitclass, unittype in details['Units']['Unit'].items()
                                        if unittype == 'NONE']]
            civ_unit_replaced[civ] = [{i['Class']: details['Units']['Unit'][i['Class']]} for i in default
                                      if i['Class'] in [unitclass for unitclass, unittype
                                                        in details['Units']['Unit'].items() if unittype != 'NONE']]
            no_none = [i['Class'] for i in default if i['Class'] in [unitclass for unitclass, unittype
                                                                     in details['Units']['Unit'].items()
                                                                     if unittype != 'NONE']]
            for i in no_access:
                unit_not_in[i].append(civ)
            for i in no_none:
                if i.replace('UNITCLASS', 'UNIT') != details['Units']['Unit'][i]:
                    if unit_replaces.get(i, 'none') == 'none':
                        unit_replaces[i] = []
                    unit_replaces[i].append({civ: details['Units']['Unit'][i]})

        for unit, civ_list in unit_not_in.items():
            if civ_list == ['CIVILIZATION_BARBARIAN']:
                civ_units['not_barbarian'].append(f"SLTH_UNIT_{unit[10:]}")
                continue
            elif len(civ_list) == 21 and 'CIVILIZATION_BARBARIAN' not in civ_list:
                civ_units['barbarian'].append(f"SLTH_UNIT_{unit[10:]}")
                continue
            elif len(civ_list) == 21:
                trait_belongs_to = [i for i in civ_dict if i not in civ_list][0]
                trait_type = f"SLTH_TRAIT_CIVILIZATION_UNIT_{unit[10:]}"
                model_obj['traits'][trait_type] = {'TraitType': trait_type, 'Name': f'LOC_{trait_type}_NAME',
                                      'Description': f'LOC_{trait_type}_DESCRIPTION'}
                model_obj['kinds'][trait_type] = 'KIND_TRAIT'
                self.civ_traits.append({'TraitType': trait_type, 'CivilizationType': f"SLTH_{trait_belongs_to}"})
                civ_units['civ_traits'].append(f"SLTH_UNIT_{unit[10:]}")
            else:
                for civ in civ_list:
                    if not civ_units['dev_null'].get(civ, False):
                        civ_units['dev_null'][civ] = []
                    civ_units['dev_null'][civ].append(f"SLTH_UNIT_{unit[10:]}")
    
        self.six_style_civs = {key: small_dict(i, civ_mapper) for key, i in civ_dict.items()}
        self.six_style_civs.pop('CIVILIZATION_BARBARIAN')
    
        for civ_name, civ in self.six_style_civs.items():
            civ['CivilizationType'] = f"SLTH_{civ['CivilizationType']}"
            civ['Name'] = f"LOC_{civ['Name'][8:-10]}NAME"
            civ['Description'] = f"LOC_{civ['Description'][8:]}RIPTION"
            civ['Adjective'] = f"LOC_SLTH_{civ['Adjective'][8:]}"
            civ['StartingCivilizationLevelType'] = 'CIVILIZATION_LEVEL_FULL_CIV'
            civ['RandomCityNameDepth'] = 10
            civ['Ethnicity'] = 'ETHNICITY_EURO'       # harhar white as default. Change later with ethnicity mapper
            model_obj['kinds'][civ['CivilizationType']] = 'KIND_CIVILIZATION'
    
        leaders = []
        self.leaders_of_civs = []
        for civ, value in civ_extras.items():
            civ_leaders = [value['Leaders']['Leader']] if isinstance(value['Leaders']['Leader'], dict) else value['Leaders']['Leader']
            for leader in civ_leaders:
                leader_name = f"SLTH_{leader['LeaderName']}"
                self.leaders_of_civs.append({'LeaderType': leader_name, 'CivilizationType': civ,
                                        'CapitalName': f"LOC_SLTH_{value['Cities']['City'][0][8:]}"})
                if leader_name not in [i['LeaderType'] for i in leaders]:
                    leaders.append({'LeaderType': leader_name, 'Name': f'LOC_{leader_name}_NAME',
                                    'InheritFrom': 'LEADER_DEFAULT'})
                model_obj['kinds'][leader_name] = 'KIND_LEADER'

        model_obj['civ_units'] = civ_units
        model_obj['civ_buildings'] = civ_buildings
        self.civilization_modifiers(model_obj, civ_dict)

        self.civ_traits.append({'TraitType': 'SLTH_TRAIT_CIVILIZATION_UNIT_MUD_GOLEM',
                                'CivilizationType': "SLTH_CIVILIZATION_LUCHUIRP"})
    
        make_or_add(model_obj['sql_inserts'], self.six_style_civs, 'Civilizations')
        make_or_add(model_obj['sql_inserts'], self.civ_traits, 'CivilizationTraits')
        make_or_add(model_obj['sql_inserts'], leaders, 'Leaders')
        make_or_add(model_obj['sql_inserts'], self.leaders_of_civs, 'CivilizationLeaders')
        make_or_add(model_obj['sql_inserts'], civ_building_replace, 'BuildingReplaces')
        make_or_add(model_obj['sql_inserts'], self.type_tags, 'TypeTags')
        make_or_add(model_obj['sql_inserts'], self.ability_modifiers, 'UnitAbilityModifiers')
        make_or_add(model_obj['sql_inserts'], self.unit_abilities, 'UnitAbilities')

    def civilization_modifiers(self, model_obj, civ_dict):
        modifier_stuff = {key: {'CivTrait': i.get('CivTrait'), 'FreeTechs': i.get('FreeTechs'),
                                'DefaultRace': i.get('DefaultRace')} for key, i in civ_dict.items()
                          if 'BARBARIAN' not in key}

        with open('data/XML/Units/CIV4PromotionInfos.xml', 'r') as file:
            promo_dict = xmltodict.parse(file.read())['Civ4PromotionInfos']['PromotionInfos']['PromotionInfo']

        races = {}
        for j in [i.get('DefaultRace') for i in civ_dict.values() if i.get('DefaultRace') != 'NONE']:
            races[j] = [k for k in promo_dict if j in k['Type']][0]
            races[j].pop('Description', None), races[j].pop('Sound', None), races[j].pop('TechPrereq', None),
            races[j].pop('Button', None), races[j].pop('bRace', None), races[j].pop('UnitArtStyleType', None),
            races[j].pop('iMinLevel', None), races[j].pop('bGraphicalOnly', None), races[j].pop('UnitCombats', None)        # Winterborn has this, why??
        for name, promo in races.items():
            name = promo.pop('Type', None)
            if 'TerrainAttacks' in promo and 'TerrainDefenses' in promo:  # get rid o['TerrainDefenses']f defense if attack same
                t_att, t_d = promo['TerrainAttacks']['TerrainAttack'], promo['TerrainDefenses']['TerrainDefense']
                if isinstance(t_att, dict) and t_att['TerrainType'] == t_d['TerrainType']:
                    if t_att['iTerrainAttack'] == t_d['iTerrainDefense']:
                        promo.pop('TerrainDefenses')
                        promo['TerrainAttacks']['Terrain_Strength'] = promo['TerrainAttacks'].pop('TerrainAttack')
                elif [i['TerrainType'] for i in t_att] and [i['TerrainType'] for i in t_d]:
                    if [i['iTerrainAttack'] for i in t_att] and [i['iTerrainDefense'] for i in t_d]:
                        promo.pop('TerrainDefenses')
                        promo['TerrainAttacks']['Terrain_Strength'] = promo['TerrainAttacks'].pop('TerrainAttack')

            trait_mods = []
            for ability_name, ability in promo.items():
                if not isinstance(ability, dict):
                    ability = {ability_name: ability}
                ab_name = model_obj['modifiers'].generate_modifier(civ4_target=ability,
                                                                     name='SLTH_DEFAULT_RACE',
                                                                     civ6_target=name)
                if ab_name is not None:
                    """ab_name = f'{name}_ABILITY_{list(ability.keys())[0].upper()}'
                    self.unit_abilities.append({'UnitAbilityType': ab_name, 'Name': f'LOC_SLTH_{ab_name}_NAME',
                                                'Description': f'LOC{ab_name}_DESCRIPTION', 'Inactive': 1,
                                                'ShowFloatTextWhenEarned': 0, 'Permanent': 1})

                    self.ability_modifiers.append({'UnitAbilityType': ab_name,
                                                   'ModifierId': modifiers[0]})

                    self.type_tags.append({'Type': ab_name, 'Tag': 'CLASS_ALL_UNITS'})

                    model_obj['kinds'][ab_name] = 'KIND_ABILITY'"""
                    trait_mods.append(ab_name)
            promo['trait_modifier'] = trait_mods

        for civ, i in modifier_stuff.items():
            trait_type = f'SLTH_TRAIT_{civ}_COOL'
            self.civ_traits.append({'TraitType': trait_type,
                                    'CivilizationType': f'SLTH_{civ}'})
            model_obj['traits'][trait_type] = {'TraitType': trait_type, 'Name': f'LOC_{trait_type}_NAME',
                                               'Description': f'LOC_{trait_type}_DESCRIPTION'}
            model_obj['kinds'][trait_type] = 'KIND_TRAIT'
            if i['CivTrait'] != 'NONE':
                mod_ = model_obj['modifiers'].generate_modifier({f"SLTH_{i['CivTrait']}": 'Cheese'},
                                                                'SLTH_DEFAULT_RACE', civ)
                if mod_ is not None:
                    self.trait_modifiers.append({'TraitType': trait_type, 'ModifierId': mod_})
            if i['FreeTechs'] is not None:
                if i['FreeTechs'] == 'TECH_SEAFARING':
                    logger.info(i)
                else:
                    mod_ = model_obj['modifiers'].generate_modifier(f"SLTH_{i['FreeTechs']['FreeTech']['TechType']}",
                                                                    'SLTH_GRANT_SPECIFIC_TECH', civ)
                    self.trait_modifiers.append({'TraitType': trait_type, 'ModifierId': mod_})

            if i['DefaultRace'] != 'NONE':
                promo = races[i['DefaultRace']]
                for mod_ in promo['trait_modifier']:
                    self.trait_modifiers.append({'TraitType': trait_type, 'ModifierId': mod_})
                if 'ELF' in i['DefaultRace']:
                    mod_ = model_obj['modifiers'].generate_modifier(f"SLTH_TECH_FOREST_SECRETS",
                                                                    'SLTH_GRANT_SPECIFIC_TECH', civ)
                    self.trait_modifiers.append({'TraitType': trait_type, 'ModifierId': mod_})

        dummy = []
        [dummy.extend(i) for i in model_obj['civ_units']['dev_null'].values()]
        ban_unit_modifiers = []
        for unit in list(set(dummy)):
            ban_unit_modifiers.append(model_obj['modifiers'].generate_modifier(civ4_target=unit,
                                                                               name='SLTH_BAN_UNIT',
                                                                               civ6_target='placeholder'))

        for civ, unit_list in model_obj['civ_units']['dev_null'].items():
            if civ == 'CIVILIZATION_BARBARIAN':
                continue
            for unit in unit_list:
                self.trait_modifiers.append({'TraitType': f'SLTH_TRAIT_{civ}_COOL',
                                             'ModifierId': f"MODIFIER_BAN_{unit}"})

        make_or_add(model_obj['sql_inserts'], self.trait_modifiers, 'TraitModifiers')


    def config_builder(self, model_obj):
        config_string = 'DELETE FROM Players;\n'
        players = []
        for civ in self.leaders_of_civs:
            if civ['CivilizationType'][18:] in model_obj['select_civs']:
                players.append({'Domain': 'Players:Expansion2_Players', 'CivilizationType': civ['CivilizationType'],
                                'LeaderType': civ['LeaderType'], 'LeaderName': f"LOC_{civ['LeaderType']}_NAME",
                                'HumanPlayable': 1, 'LeaderIcon': f'ICON_{civ["LeaderType"]}',
                                'CivilizationName': f'LOC_CIV_{civ["CivilizationType"][18:]}_NAME',
                                'CivilizationIcon': f'ICON_{civ["CivilizationType"]}', 'LeaderAbilityName': f'LOC_SLTH_TRAIT_{civ["CivilizationType"]}_COOL_NAME',
                                'LeaderAbilityDescription': 'NULL', 'LeaderAbilityIcon': f'ICON_{civ["LeaderType"]}',
                                'CivilizationAbilityName': 'NULL', 'CivilizationAbilityDescription': 'NULL',
                                'CivilizationAbilityIcon': f'ICON_{civ["CivilizationType"]}', 'Portrait': 'NULL',
                                'PortraitBackground': 'NULL', 'PlayerColor': 'NULL'
                                })

        make_or_add(model_obj['sql_config'], players, 'Players')
