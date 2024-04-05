import xmltodict
from utils import build_sql_table, small_dict
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

class Civilizations:
    def __init__(self):
        print('Loading Civilizations...')

    # TODO implement FreeTech system from ffh. Look at how Quo's spheres of intrigue /better balanced game did that
    #  thing where babylon starts with writing unlocked, or Phoenicia with Celestial Navigation

    def civilizations(self, civs_to_keep, kinds):
        with open('data/XML/Civilizations/CIV4CivilizationInfos.xml', 'r') as file:
            civ_dict = xmltodict.parse(file.read())['Civ4CivilizationInfos']['CivilizationInfos']['CivilizationInfo']

        with open('data/CIV4UnitInfos.xml', 'r') as file:
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

        dev_null = {'units': {}, 'buildings': {}}
    
        unique_units_to_remove = {}
        string_counts = Counter()
        civ_traits, civ_building_replace = [], []
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
                    traits[trait_type] = {'TraitType': trait_type, 'Name': f'LOC_{trait_type}_NAME',
                                          'Description': 'NULL'}
                    kinds[trait_type] = 'KIND_TRAIT'
                    civ_traits.append({'TraitType': trait_type, 'CivilizationType': f"SLTH_{civ}"})
                    civ_building_replace.append({'ReplacesBuildingType': f"SLTH_{i['BuildingClassType'].replace('INGCLASS', 'ING')}",
                                                 'CivUniqueBuildingType': f"SLTH_{i['BuildingType']}"})
                    civ_buildings['civ_traits'].append(f"SLTH_{i['BuildingType']}")

        for building, civ in civ_unique_buildings.items():
            trait_type = f"SLTH_TRAIT_CIVILIZATION_{building}"
            traits[trait_type] = {'TraitType': trait_type, 'Name': f'LOC_{trait_type}_NAME',
                                  'Description': 'NULL'}
            kinds[trait_type] = 'KIND_TRAIT'
            civ_traits.append({'TraitType': trait_type, 'CivilizationType': f"SLTH_{civ['PrereqCiv']}"})
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
                traits[trait_type] = {'TraitType': trait_type, 'Name': f'LOC_{trait_type}_NAME',
                                      'Description': 'NULL'}
                kinds[trait_type] = 'KIND_TRAIT'
                civ_traits.append({'TraitType': trait_type, 'CivilizationType': f"SLTH_{trait_belongs_to}"})
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
            civ['Name'] = f"LOC_{civ['Name'][8:-9]}"
            civ['Description'] = f"LOC_{civ['Description'][8:]}RIPTION"
            civ['Adjective'] = f"LOC_{civ['Adjective'][8:]}"
            civ['StartingCivilizationLevelType'] = 'CIVILIZATION_LEVEL_FULL_CIV'
            civ['RandomCityNameDepth'] = 10
            civ['Ethnicity'] = 'ETHNICITY_EURO'       # harhar white as default. Change later with ethnicity mapper
            kinds[civ['CivilizationType']] = 'KIND_CIVILIZATION'
    
        leaders = []
        self.leaders_of_civs = []
        for civ, value in civ_extras.items():
            civ_leaders = [value['Leaders']['Leader']] if isinstance(value['Leaders']['Leader'], dict) else value['Leaders']['Leader']
            for leader in civ_leaders:
                leader_name = f"SLTH_{leader['LeaderName']}"
                self.leaders_of_civs.append({'LeaderType': leader_name, 'CivilizationType': civ,
                                        'CapitalName': f"LOC_{value['Cities']['City'][0][8:]}"})
                if leader_name not in [i['LeaderType'] for i in leaders]:
                    leaders.append({'LeaderType': leader_name, 'Name': f'LOC_{leader_name}_NAME',
                                    'InheritFrom': 'LEADER_DEFAULT'})
                kinds[leader_name] = 'KIND_LEADER'

        civ_traits.append({'TraitType': 'SLTH_TRAIT_CIVILIZATION_UNIT_MUD_GOLEM',
                           'CivilizationType': "SLTH_CIVILIZATION_LUCHUIRP"})
    
        civ_string = build_sql_table(self.six_style_civs, 'Civilizations')
        civ_string += build_sql_table(civ_traits, 'CivilizationTraits')
        civ_string += build_sql_table(leaders, 'Leaders')
        civ_string += build_sql_table(self.leaders_of_civs, 'CivilizationLeaders')
        civ_string += build_sql_table(civ_building_replace, 'BuildingReplaces')

        return civ_string, civ_units, civ_buildings, kinds, traits

    def config_builder(self, civs):
        config_string = 'DELETE FROM Players;\n'
        players = []
        for civ in self.leaders_of_civs:
            if civ['CivilizationType'][18:] in civs:
                players.append({'Domain': 'Players:Expansion2_Players', 'CivilizationType': civ['CivilizationType'],
                                'LeaderType': civ['LeaderType'], 'LeaderName': f"LOC_{ civ['LeaderType']}",
                                'HumanPlayable': 1, 'LeaderIcon': f'ICON_{civ["LeaderType"]}',
                                'CivilizationName': f'LOC_{civ["CivilizationType"]}_NAME',
                                'CivilizationIcon': f'ICON_{civ["CivilizationType"]}', 'LeaderAbilityName': 'NULL',
                                'LeaderAbilityDescription': 'NULL', 'LeaderAbilityIcon': f'ICON_{civ["LeaderType"]}',
                                'CivilizationAbilityName': 'NULL', 'CivilizationAbilityDescription': 'NULL',
                                'CivilizationAbilityIcon': f'ICON_{civ["CivilizationType"]}', 'Portrait': 'NULL',
                                'PortraitBackground': 'NULL', 'PlayerColor': 'NULL'
                                })

        config_string += build_sql_table(players, 'Players')
        return config_string
