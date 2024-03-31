import xmltodict
from utils import build_sql_table, small_dict


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
    # TODO implement FreeTech system from ffh. Look at how Quo's spheres of intrigue /better balanced game did that thing where babylon starts with writing unlocked, or Phoenicia with Celestial Navigation
    def civilizations(self, civs, kinds):
        with open('data/XML/Civilizations/CIV4CivilizationInfos.xml', 'r') as file:
            civ_dict = xmltodict.parse(file.read())['Civ4CivilizationInfos']['CivilizationInfos']['CivilizationInfo']
    
        civ_extras = [small_dict(i, civ_extras_mapper) for i in civ_dict]
        civ_extras = {i.pop('CivilizationType'): i for i in civ_extras}
        for civ_remove in ['CIVILIZATION_BARBARIAN', 'CIVILIZATION_RANDOM']:
            civ_extras.pop(civ_remove)
    
        unique_buildings_to_remove = {}
        unique_units_to_remove = {}
        unique_buildings_not_remove = {}
        unique_units_not_remove = {}
        for civ in civ_dict:
            unique_buildings_not_remove[civ['Type']] = []
            unique_units_not_remove[civ['Type']] = []
            if civ['Type'][13:] in civs:
                for unique_building in civ['Buildings']['Building']:
                    if unique_building['BuildingType'] != 'NONE' and 'PALACE_' not in unique_building['BuildingType']:
                        unique_buildings_not_remove[civ['Type']].append({'BuildingType': unique_building['BuildingType'],
                                                                         'BuildingClassType':  unique_building['BuildingClassType']})
                for unique_unit in civ['Units']['Unit']:
                    if unique_unit['UnitType'] != 'NONE':
                        unique_units_not_remove[civ['Type']].append(unique_unit['UnitType'])
    
        for civ in civ_dict:
            unique_buildings_to_remove[civ['Type']] = []
            unique_units_to_remove[civ['Type']] = []
            if civ['Type'][13:] not in civs:
                for unique_unit in civ['Units']['Unit']:
                    if unique_unit['UnitType'] != 'NONE':
                        if unique_unit['UnitType'] not in unique_units_not_remove:
                            unique_units_to_remove[civ['Type']].append(unique_unit['UnitType'])
                if civ['Hero'] != 'NONE':
                    unique_units_to_remove[civ['Type']].append(civ['Hero'])
    
                if civ.get('Buildings', False):
                    if isinstance(civ['Buildings']['Building'], dict):
                        unique_buildings_to_remove[civ['Type']].append(civ['Buildings']['Building']['BuildingType'])
                    else:
                        for unique_building in civ['Buildings']['Building']:
                            if unique_building['BuildingType'] != 'NONE':
                                unique_buildings_to_remove[civ['Type']].append(unique_building['BuildingType'])
    
        # patch mercurian angels..., demagog, lightbearer
        for civ, units in civ_patch.items():
            if civ not in civs:
                for weird_unit in units:
                    unique_units_to_remove[f'CIVILIZATION_{civ}'].append(weird_unit)
    
        civ_traits, traits = [], []
        for civ, building_list in unique_buildings_not_remove.items():
            if civ[13:] in civs:
                for building in building_list:
                    trait_type = f"TRAIT_CIVILIZATION_{building['BuildingType']}"
                    civ_traits.append({'TraitType': trait_type, 'CivilizationType': civ})
                    traits.append({'TraitType': trait_type, 'Name': f'LOC_{trait_type}_NAME', 'Description': 'NULL'})
                    kinds[trait_type] = 'KIND_TRAIT'
    
        for civ, unit_list in unique_units_not_remove.items():
            if civ[13:] in civs:
                for unit in unit_list:
                    trait_type = f"TRAIT_CIVILIZATION_{unit}"
                    civ_traits.append({'TraitType': trait_type, 'CivilizationType': civ})
                    traits.append({'TraitType': trait_type, 'Name': f'LOC_{trait_type}_NAME', 'Description': 'NULL'})
                    kinds[trait_type] = 'KIND_TRAIT'
    
        patch = {'UNIT_ACHERON': 'CIVILIZATION_BARBARIAN',
                 'UNIT_TREBUCHET': 'CIVILIZATION_KHAZAD'}
        for patch, patch_value in patch.items():
            trait_type = f"TRAIT_CIVILIZATION_{patch}"
            civ_traits.append({'TraitType': trait_type, 'CivilizationType': patch_value})
            traits.append({'TraitType': trait_type, 'Name': f'LOC_{trait_type}_NAME', 'Description': 'NULL'})
            kinds[trait_type] = 'KIND_TRAIT'
    
        self.six_style_civs = [small_dict(i, civ_mapper) for i in civ_dict]
        self.six_style_civs = [i for i in self.six_style_civs
                          if i['CivilizationType'] not in ['CIVILIZATION_BARBARIAN', 'CIVILIZATION_RANDOM']]
    
        for civ in self.six_style_civs:
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
                leader_name = leader['LeaderName']
                self.leaders_of_civs.append({'LeaderType': leader_name, 'CivilizationType': civ,
                                        'CapitalName': f"LOC_{value['Cities']['City'][0][8:]}"})
                if leader_name not in [i['LeaderType'] for i in leaders]:
                    leaders.append({'LeaderType': leader_name, 'Name': f'LOC_{leader_name}_NAME',
                                    'InheritFrom': 'LEADER_DEFAULT'})
                kinds[leader_name] = 'KIND_LEADER'
    
        civ_string = build_sql_table(self.six_style_civs, 'Civilizations')
        civ_string += build_sql_table(civ_traits, 'CivilizationTraits')
        civ_string += build_sql_table(leaders, 'Leaders')
        civ_string += build_sql_table(self.leaders_of_civs, 'CivilizationLeaders')
    
        return civ_string, unique_units_to_remove, {'remove': unique_buildings_to_remove, 'replace': unique_buildings_not_remove}, kinds, traits

    def config_builder(self, civs):
        config_string = 'DELETE FROM Players;\n'
        players = []
        for civ in self.leaders_of_civs:
            if civ['CivilizationType'][13:] in civs:
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
