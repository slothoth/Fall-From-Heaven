import xmltodict
import pandas as pd
from utils import small_dict, Sql, make_or_add, update_or_add
from modifiers import Modifiers


yield_map = ['YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_GOLD']


def build_resource_string(model_obj):
    resource_renames = {'HORSE': 'HORSES', 'GUNPOWDER': 'NITER', 'BANANA': 'BANANAS', 'CORN': 'MAIZE', 'COW': 'CATTLE',
                        'GEMS': 'DIAMONDS', 'CRAB': 'CRABS', 'DYE': 'DYES', 'FUR': 'FURS', 'WHALE': 'WHALES',
                        'PEARL': 'PEARLS'}
    artdef_resources = {'PIG': 'TRUFFLES', 'MITHRIL': 'SILVER', 'FRUIT_OF_YGGDRASIL': 'CITRUS', 'REAGENTS': 'SPICES',
                        'SHEUT_STONE': 'JADE', 'RAZORWEED': 'OLIVES', 'GULAGARM': 'TOBACCO', 'GOLD': 'GYPSUM',
                        'CLAM': 'TURTLES', 'NIGHTMARE': 'AMBER', 'TOAD': 'HONEY'}

    pre_existing = ['RESOURCE_COPPER', 'RESOURCE_IRON', 'RESOURCE_MARBLE', 'RESOURCE_DEER', 'RESOURCE_FISH',
                    'RESOURCE_RICE', 'RESOURCE_SHEEP', 'RESOURCE_WHEAT', 'RESOURCE_INCENSE', 'RESOURCE_IVORY',
                    'RESOURCE_SILK', 'RESOURCE_SUGAR', 'RESOURCE_WINE', 'RESOURCE_COTTON']

    existing_valid_features = [{'FeatureType': 'FEATURE_JUNGLE', 'ResourceType': 'RESOURCE_BANANA'},
                               {'FeatureType': 'FEATURE_FOREST', 'ResourceType': 'RESOURCE_DEER'},
                               {'FeatureType': 'FEATURE_JUNGLE', 'ResourceType': 'RESOURCE_IVORY'},
                               {'FeatureType': 'FEATURE_FOREST', 'ResourceType': 'RESOURCE_SILK'}]


    resource_class_map = {'BONUSCLASS_RUSH': 'RESOURCECLASS_STRATEGIC', 'BONUSCLASS_GENERAL': 'RESOURCECLASS_BONUS',
                          'BONUSCLASS_MANA': 'RESOURCECLASS_MANA', 'BONUSCLASS_WONDER': 'RESOURCECLASS_LUXURY',
                          'BONUSCLASS_LIVESTOCK': 'RESOURCECLASS_BONUS', 'BONUSCLASS_GRAIN': 'RESOURCECLASS_BONUS',
                          'BONUSCLASS_RAWMANA': 'RESOURCECLASS_RAWMANA'}

    not_plottable = ['RESOURCE_FRUIT_OF_YGGDRASIL', 'RESOURCE_ALE', 'RESOURCE_FINE_CLOTHES', 'RESOURCE_JEWELS']

    with open('data/XML/Terrain/CIV4BonusInfos.xml', 'r') as file:
        bonuses_dict = xmltodict.parse(file.read())['Civ4BonusInfos']['BonusInfos']['BonusInfo']

    resource_mapper = {'Type': 'ResourceType', 'TechReveal': 'PrereqTech', 'iHappiness': 'Happiness',
                       'Description': 'Name', 'BonusClassType': 'ResourceClassType'}
    resource_extras_map = {'YieldChanges': 'YieldChanges', 'bHills': 'bHills', 'bFlatlands': 'bFlatlands',
                           'TerrainBooleans': 'TerrainBooleans', 'FeatureBooleans': 'FeatureBooleans',
                           'FeatureTerrainBooleans': 'FeatureTerrainBooleans', 'Type': 'ResourceType'}

    six_style_resource_dict = [small_dict(i, resource_mapper) for i in bonuses_dict]
    resource_dict_extras = [small_dict(i, resource_extras_map) for i in bonuses_dict]

    for resource in six_style_resource_dict:
        resource['Happiness'] = 4 * int(resource['Happiness'])
        resource['ResourceType'] = f"RESOURCE_{resource['ResourceType'][6:]}"
        resource['Name'] = "LOC_" + resource['ResourceType']
        resource['ResourceClassType'] = 'RESOURCECLASS_LUXURY' if resource['Happiness'] > 0 else resource_class_map[resource['ResourceClassType']]
        resource['PrereqCivic'] = 'NULL'
        if resource['PrereqTech'] == 'NONE':
            resource['PrereqTech'] = 'NULL'
        elif resource['PrereqTech'] in model_obj['civics']:
            resource['PrereqCivic'] = model_obj['civics'][resource['PrereqTech']]
            resource['PrereqTech'] = 'NULL'

    update_dict = [i for i in six_style_resource_dict if i['ResourceType'] in pre_existing]
    six_style_resource_dict = [i for i in six_style_resource_dict if not i['PrereqTech'] == 'TECH_SEAFARING']       # removes lanun tech issue
    resource_dict_extras = [i for i in resource_dict_extras
                            if i['ResourceType'] in ['BONUS_' + j['ResourceType'][9:] for j in six_style_resource_dict]]
    six_style_resource_dict = [i for i in six_style_resource_dict if not i['ResourceType'] in pre_existing]

    resource_valid_terrain, resource_valid_feature, resource_yield_changes = [], [], []
    for resource in resource_dict_extras:
        resource['ResourceType'] = f"RESOURCE_{resource['ResourceType'][6:]}"
        if resource.get('TerrainBooleans', False):
            if isinstance(resource['TerrainBooleans']['TerrainBoolean'], list):
                for terrain in resource['TerrainBooleans']['TerrainBoolean']:
                    if terrain['bTerrain'] == '1':
                        if not terrain['TerrainType'] in ['TERRAIN_MARSH', 'TERRAIN_SHALLOWS']:
                            if resource['bHills'] == '1':
                                resource_valid_terrain.append({'ResourceType': resource['ResourceType'],
                                                               'TerrainType': f"{terrain['TerrainType']}_HILLS"})
                            elif resource['bFlatlands'] == '1':
                                resource_valid_terrain.append({'ResourceType': resource['ResourceType'],
                                                               'TerrainType': terrain['TerrainType']})

            elif isinstance(resource['TerrainBooleans']['TerrainBoolean'], dict):
                terrain = resource['TerrainBooleans']['TerrainBoolean']['TerrainType']
                if terrain in ['TERRAIN_MARSH', 'TERRAIN_SHALLOWS']:
                    resource_valid_feature.append({'ResourceType': resource['ResourceType'],
                                                  'FeatureType': 'FEATURE_' + terrain[8:]})
                if resource['bHills'] == '1':
                    resource_valid_terrain.append({'ResourceType': resource['ResourceType'],
                                                   'TerrainType': f"{terrain}_HILLS"})
                elif resource['bFlatlands'] == '1':
                    resource_valid_terrain.append({'ResourceType': resource['ResourceType'],
                                                   'TerrainType': terrain})

        if resource.get('FeatureBooleans', False):
            feature = resource['FeatureBooleans']['FeatureBoolean']
            resource_valid_feature.append({'ResourceType': resource['ResourceType'],
                                           'FeatureType': feature['FeatureType']})

        if resource.get('YieldChanges', False):
            for idx, i in enumerate(resource['YieldChanges']['iYieldChange']):
                if int(i) > 0:
                    resource_yield_changes.append({'ResourceType': resource['ResourceType'],
                                                   'YieldType': yield_map[idx], 'YieldChange': i})

    # remove pre-existings
    resource_valid_feature = [i for i in resource_valid_feature if i not in existing_valid_features]
    existing_terrains = pd.read_csv(f'data/tables/Resource_ValidTerrains.csv').to_dict(orient='records')
    resource_valid_terrain = [i for i in resource_valid_terrain if i not in existing_terrains]
    existing_yields = pd.read_csv(f'data/tables/Resource_YieldChanges.csv').to_dict(orient='records')
    changes_existing = [(i['ResourceType'], i['YieldType']) for i in existing_yields]
    updates_yield = [i for i in resource_yield_changes if (i['ResourceType'], i['YieldType']) in changes_existing]
    resource_yield_changes = [i for i in resource_yield_changes
                              if (i['ResourceType'], i['YieldType']) not in changes_existing]

    for resource in six_style_resource_dict:
        if not resource['ResourceType'][6:] in resource_renames:
            model_obj['kinds'][resource['ResourceType']] = 'KIND_RESOURCE'
            # check its actually called that

    make_or_add(model_obj['sql_inserts'], six_style_resource_dict, 'Resources')
    update_or_add(model_obj['sql_updates'], update_dict, 'Resources', ['ResourceType'])
    make_or_add(model_obj['sql_inserts'], resource_valid_feature, 'Resource_ValidFeatures')
    make_or_add(model_obj['sql_inserts'], resource_valid_terrain, 'Resource_ValidTerrains')
    make_or_add(model_obj['sql_inserts'], resource_yield_changes, 'Resource_YieldChanges')
    update_or_add(model_obj['sql_updates'], updates_yield, 'Resource_YieldChanges', ['ResourceType', 'YieldType'])
    return model_obj


def build_terrains_string(model_obj):
    with open('data/XML/Terrain/CIV4TerrainInfos.xml', 'r') as file:
        terrain_dict = xmltodict.parse(file.read())['Civ4TerrainInfos']['TerrainInfos']['TerrainInfo']

    keep_terrains = ['TERRAIN_GRASS', 'TERRAIN_PLAINS', 'TERRAIN_DESERT', 'TERRAIN_TUNDRA', 'TERRAIN_COAST',
                     'TERRAIN_OCEAN', 'TERRAIN_SNOW', 'TERRAIN_PEAK', 'TERRAIN_HILL']

    terrain_mapper = {'Type': 'TerrainType', 'Description': 'Name', 'iMovement': 'MovementCost',
                      'iSeeThrough': 'SightThroughModifier', 'iSeeFrom': 'SightModifier', 'bWater': 'Water',
                      'Hills': 0, 'Mountain': 0, 'InfluenceCost': 1}

    terrain_extra_mapper = {'Type': 'TerrainType', 'Yields': 'Yields', 'bWater': 'Water'}
    terrain_yield_map = ['YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_GOLD']

    six_style_terrain_dict = [small_dict(i, terrain_mapper) for i in terrain_dict
                              if i['Type'] not in keep_terrains]

    to_featurise = [i for i in six_style_terrain_dict if i['TerrainType'] in ['TERRAIN_MARSH', 'TERRAIN_SHALLOWS']]

    six_style_terrain_dict = [i for i in six_style_terrain_dict
                              if not i['TerrainType'] in ['TERRAIN_MARSH', 'TERRAIN_SHALLOWS']]

    terrain_dict_extras = [small_dict(i, terrain_extra_mapper) for i in terrain_dict]

    hills = []
    for terrain in six_style_terrain_dict:
        terrain['Name'] = "LOC_" + "_".join(terrain['Name'].split('_')[2:])
        if terrain['TerrainType'] == 'TERRAIN_BURNING_SANDS':
            terrain['InfluenceCost'] = 2
        if terrain['Water'] == '0':
            hills_terrain = terrain.copy()
            mountains_terrain = terrain.copy()
            mountains_terrain['TerrainType'] = mountains_terrain['TerrainType'] + '_MOUNTAIN'
            mountains_terrain['Mountain'], mountains_terrain['Name'] = 1, mountains_terrain['Name'] + '_MOUNTAIN'
            mountains_terrain['InfluenceCost'] = 3
            hills.append(mountains_terrain)
            hills_terrain['Hills'], hills_terrain['TerrainType'] = 1, hills_terrain['TerrainType'] + '_HILLS'
            hills_terrain['Name'] = hills_terrain['Name'] + '_HILLS'
            hills.append(hills_terrain)

    # TODO Marsh is treated as terrain not feature in civ 4, we will have compat issues
    six_style_terrain_dict.extend(hills)

    terrain_dict_extras = [i for i in terrain_dict_extras if
                           i['TerrainType'] in [j['TerrainType'] for j in six_style_terrain_dict]]
    terrain_yields = []
    for terrain in terrain_dict_extras:
        if terrain.get('Yields', None) is not None:
            for idx, i in enumerate(terrain['Yields']['iYield']):
                if int(i) > 0:
                    terrain_yields.append({'TerrainType': terrain['TerrainType'],
                                           'YieldType': terrain_yield_map[idx], 'YieldChange': i})
            if terrain['Water'] == '0':
                hills_version = terrain['Yields']['iYield']
                hills_version[1] = int(hills_version[1]) + 1
                for idx, i in enumerate(hills_version):
                    if int(i) > 0:
                        terrain_yields.append({'TerrainType': terrain['TerrainType'] + '_HILLS',
                                               'YieldType': terrain_yield_map[idx], 'YieldChange': i})

    make_or_add(model_obj['sql_inserts'], six_style_terrain_dict, 'Terrains')
    make_or_add(model_obj['sql_inserts'], terrain_yields, 'Terrain_YieldChanges')

    for terrain in six_style_terrain_dict:
        model_obj['kinds'][terrain['TerrainType']] = 'KIND_TERRAIN'

    return model_obj


def build_features_string(model_obj):
    with open('data/XML/Terrain/CIV4FeatureInfos.xml', 'r') as file:
        feature_dict = xmltodict.parse(file.read())['Civ4FeatureInfos']['FeatureInfos']['FeatureInfo']

    feature_dict.append({'Type': 'FEATURE_SHALLOWS', 'Description': 'LOC_FEATURE_SHALLOWS', 'bNoCoast': 0,
                         'bNoRiver': 0, 'bRequiresRiver': 0, 'bAddsFreshWater': 0, 'iSeeThrough': 0,
                         'YieldChanges': {'iYieldChange': ['1', '0', '0']},
                         'TerrainBooleans': {'TerrainBoolean': {'TerrainType': 'TERRAIN_BROKEN_LANDS'}}})
    feature_map = {'Type': 'FeatureType', 'Description': 'Name', 'bNoCoast': 'NoCoast', 'bNoRiver': 'NoRiver',
                   'bRequiresRiver': 'RequiresRiver', 'bAddsFreshWater': 'AddsFreshWater',
                   'iSeeThrough': 'SightThroughModifier'}
    features_extras_map = {'Type': 'FeatureType', 'YieldChanges': 'YieldChanges', 'TerrainBooleans': 'TerrainBooleans'}
    # Its basically not useful at all, but we do need the Ancient Forest, Obsidian Plains and conver the Shallows
    features = [i for i in feature_dict if i['Type'] in ['FEATURE_FOREST_ANCIENT', 'FEATURE_OBSIDIAN_PLAINS',
                                                         'FEATURE_SHALLOWS']]
    six_style_features = [small_dict(i, feature_map) for i in features]
    feature_extras = [small_dict(i, features_extras_map) for i in features]

    for i in six_style_features:
        i['Name'] = "LOC_" + i['FeatureType']

    feature_yields, feature_valid_terrain = [], []

    for feature in feature_extras:
        if feature.get('TerrainBooleans', False):
            if isinstance(feature['TerrainBooleans']['TerrainBoolean'], list):
                for terrain in feature['TerrainBooleans']['TerrainBoolean']:
                    feature_valid_terrain.append({'FeatureType': feature['FeatureType'],
                                                   'TerrainType': terrain['TerrainType']})

            elif isinstance(feature['TerrainBooleans']['TerrainBoolean'], dict):
                terrain = feature['TerrainBooleans']['TerrainBoolean']['TerrainType']
                feature_valid_terrain.append({'FeatureType': feature['FeatureType'],
                                              'TerrainType': terrain})

        if feature.get('YieldChanges', False):
            for idx, i in enumerate(feature['YieldChanges']['iYieldChange']):
                if int(i) > 0:
                    feature_yields.append({'FeatureType': feature['FeatureType'],
                                           'YieldType': yield_map[idx], 'YieldChange': i})

    make_or_add(model_obj['sql_inserts'], six_style_features, 'Features')
    make_or_add(model_obj['sql_inserts'], feature_valid_terrain, 'Feature_ValidTerrains')
    make_or_add(model_obj['sql_inserts'], feature_yields, 'Feature_YieldChanges')

    for features in six_style_features:
        model_obj['kinds'][features['FeatureType']] = 'KIND_FEATURE'
    return model_obj


def build_policies(model_obj):
    with open('data/XML/Gameinfo/CIV4CivicInfos.xml', 'r') as file:
        policy_dict = xmltodict.parse(file.read())['Civ4CivicInfos']['CivicInfos']['CivicInfo']

    remove = ['CIVIC_NO_MEMBERSHIP', 'CIVIC_OVERCOUNCIL', 'CIVIC_UNDERCOUNCIL']
    policy_mapper = {'Type': 'PolicyType', 'Description': 'Description', 'TechPrereq': 'PrereqTech',
                     'CivicOptionType': 'GovernmentSlotType'}
    gov_slot_mapper = {'CIVICOPTION_LABOR': 'SLOT_MILITARY', 'CIVICOPTION_CULTURAL_VALUES': 'SLOT_ECONOMIC',
                       'CIVICOPTION_GOVERNMENT': 'SLOT_DIPLOMATIC', 'CIVICOPTION_ECONOMY': 'SLOT_GREAT_PERSON'}
    old_policy_dict = {i['Type']:i for i in policy_dict}
    six_policy_dict = {i['Type']: small_dict(i, policy_mapper) for i in policy_dict}
    six_policy_dict = {key: val for key, val in six_policy_dict.items() if key not in remove}
    useful_infos = {key:{key: value for key, value in i.items() if value != 'NONE' and value != None and value != '0'} for key, i in old_policy_dict.items()}
    useful_infos = {key: val for key, val in useful_infos.items() if key not in remove}
    pop_list = ['Button', 'Description', 'Strategy', 'iAnarchyLength', 'iAIWeight', 'CivicOptionType', 'WeLoveTheKing',
                'TechPrereq', 'Type', 'Civilopedia']
    for i in useful_infos.values():
        for j in pop_list:
            i.pop(j, None)
    for i in six_policy_dict.values():
        i['GovernmentSlotType'] = gov_slot_mapper[i['GovernmentSlotType']]
        i['PolicyType'] = 'POLICY_' + i['PolicyType'][6:]
        i['Name'] = f"LOC_{i['PolicyType']}_NAME"
        i['PrereqCivic'] = 'NULL'
        if i['PolicyType'] != 'POLICY_GOD_KING':
            model_obj['kinds'][i['PolicyType']] = 'KIND_POLICY'
        if i['PrereqTech'] in model_obj['civics']:
            i['PrereqCivic'] = f"CIVIC_{i['PrereqTech'][5:]}"
            i['PrereqTech'] = 'NULL'
        elif i['PrereqTech'] == 'NONE':
            i['PrereqTech'] = 'NULL'

    # reused : iGreatPeopleRateModifier,

    all_mods = {j for sublist in [[j for j in i] for policy, i in useful_infos.items()] for j in sublist}

    all_modifiers_full = []
    for i in useful_infos.values():
        for key, j in i.items():
            all_modifiers_full.append((key,j))

    #{'iDistanceMaintenanceModifier':, 'Upkeep':, 'CommerceModifiers'}
    # none of 4 0,1 are 1 except builder extra builds
    # OwnerRequirementSetId is always null,
    mod_types = set()
    policy_modifiers = []
    for policy, i in useful_infos.items():
        for key, val in i.items():
            modifier_ids = model_obj['modifiers'].generate_modifier(val, key, policy[6:])
            if modifier_ids is not None:
                for modifier_id in modifier_ids:
                    policy_modifiers.append({'PolicyType': f"POLICY_{policy[6:]}".upper(),
                                             'ModifierId': modifier_id})

    make_or_add(model_obj['sql_inserts'], six_policy_dict, 'Policies')
    make_or_add(model_obj['sql_inserts'], policy_modifiers, 'PolicyModifiers')
    return model_obj
