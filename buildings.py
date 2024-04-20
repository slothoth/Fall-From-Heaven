from utils import small_dict, make_or_add, update_or_add
import xmltodict
import json
import logging

extras_building_map = {'Type': 'BuildingType', 'GreatPeopleUnitClass': 'GreatPersonClassType',
                       'iGreatPeopleRateChange': 'PointsPerTurn', 'CommerceChanges': 'YieldType',
                       'PrereqCiv': 'PrereqCiv', 'YieldChanges': 'YieldChanges',
                       'SpecialistCommerceChanges': 'DistrictWorkedYield_COM',
                       'SpecialistYieldChanges': 'DistrictWorkedYield'
                       }

modifier_building_map = {'Type': 'BuildingType',
                         'YieldModifiers': 'YieldModifiers', 'CommerceModifiers': 'CommerceModifiers',
                         'FreeBonus': 'FreeBonus', 'FreeBonus2': 'FreeBonus2', 'FreeBonus3': 'FreeBonus3',
                         'iNumFreeBonuses': 'iNumFreeBonuses', 'Bonus': 'Bonus',
                         'BonusYieldModifiers': 'BonusYieldModifiers',
                         'DomainProductionModifiers': 'DomainProductionModifiers',
                         'iGlobalSpaceProductionModifier': 'iGlobalSpaceProductionModifier',
                         'iTradeRouteModifier': 'iTradeRouteModifier', 'iFreePromotionPick': 'iFreePromotionPick',
                         'iGreatPeopleRateModifier': 'iGreatPeopleRateModifier'}

buildings_4_to_6 = {'Type': 'BuildingType', 'PrereqTech': 'PrereqTech', 'iCost': 'Cost',
                    'MaxWorldInstances': -1, 'bCapital': 'MaxPlayerInstances',
                    'PrereqDistrict': 'DISTRICT_CITY_CENTER',
                    'iHealth': 'Housing', 'iHappiness': 'Entertainment', 'SpecialistCounts': 'CitizenSlots',
                    'Advisor': 'AdvisorType', 'iDefense': 'iDefense', 'bNoUnhealthyPopulation': 'bNoUnhealthyPopulation',
                    'bNoUnhappiness': 'bNoUnhappiness'}

map_specialists = {'SPECIALIST_SCIENTIST': 'DISTRICT_CAMPUS', 'SPECIALIST_ENGINEER': 'DISTRICT_INDUSTRIAL_ZONE',
                   'SPECIALIST_PRIEST': 'DISTRICT_HOLY_SITE', 'SPECIALIST_ARTIST': 'DISTRICT_THEATER',
                   'SPECIALIST_MERCHANT': 'DISTRICT_COMMERCIAL_HUB'}

commerce_map = ['YIELD_GOLD', 'YIELD_SCIENCE', 'YIELD_CULTURE']
yield_map = ['SDM_UNKNOWN', 'YIELD_PRODUCTION', 'YIELD_GOLD']
gpp_map = {'UNITCLASS_PROPHET': 'GREAT_PERSON_CLASS_PROPHET', 'UNITCLASS_COMMANDER': 'GREAT_PERSON_CLASS_GENERAL',
           'UNITCLASS_MERCHANT': 'GREAT_PERSON_CLASS_MERCHANT', 'UNITCLASS_ENGINEER': 'GREAT_PERSON_CLASS_ENGINEER',
           'UNITCLASS_SCIENTIST': 'GREAT_PERSON_CLASS_SCIENTIST', 'UNITCLASS_ARTIST': 'GREAT_PERSON_CLASS_ARTIST',
           'UNITCLASS_ADVENTURER': 'GREAT_PERSON_CLASS_WRITER'}

advisor_mapping = {'ADVISOR_MILITARY': 'ADVISOR_CONQUEST', 'ADVISOR_RELIGION': 'ADVISOR_RELIGIOUS',
                   'ADVISOR_ECONOMY': 'ADVISOR_GENERIC', 'ADVISOR_GROWTH': 'ADVISOR_GENERIC',
                   'ADVISOR_SCIENCE': 'ADVISOR_TECHNOLOGY', 'ADVISOR_CULTURE': 'ADVISOR_CULTURE'}

patch = {'Modifier': {'BUILDING_FORBIDDEN_PALACE': 'MODIFIER_ENABLE_BUILDING_FORBIDDEN_PALACE',
                      'BUILDING_SHRINE_OF_THE_CHAMPION': 'MODIFIER_BUILDING_SHRINE_OF_THE_CHAMPION'}}

BUILDING_NULL = {'BuildingType': 'SLTH_BUILDING_NULL', 'AdvisorType': 'ADVISOR_RELIGIOUS', 'PrereqTech': 'NULL',
                 'MaxPlayerInstances': -1, 'Cost': '500', 'Housing': '0', 'Entertainment': '0', 'CitizenSlots': 'NULL',
                 'MaxWorldInstances': -1, 'PrereqDistrict': 'DISTRICT_CITY_CENTER', 'TraitType': 'NULL',
                 'Name': 'LOC_SLTH_BUILDING_NULL_NAME', 'Description': 'LOC_SLTH_BUILDING_NULLDESCRIPTION',
                 'PrereqCivic': 'NULL'}

others_to_remove = ['Description', 'Civilopedia', 'ArtDefineTag', 'ReligionType',
                    'iAdvancedStartCost', 'iMinAreaSize', 'iConquestProb', 'iMaxLatitude', 'iAsset',
                    'fVisibilityPriority', 'ConstructSound', 'Flavors', 'ReligionChanges',
                    'GreatPeopleUnitClass', 'iGreatPeopleRateChange', 'CommerceChanges', 'PrereqCiv', 'bGoldenAge',
                    'bNeverCapture', 'Help', 'bCenterInCity', 'Strategy', 'iHurryCostModifier', 'bGraphicalOnly',
                    'MovieDefineTag', 'iPower', 'bTeamShare', 'bNukeImmune', 'iCrime', 'iPlotRadius', 'HolyCity',
                    'GlobalReligionCommerce', 'CommerceChangeOriginalOwners', 'bEquipment',
                    'ObsoleteSafeCommerceChanges', 'iAIWeight', 'BuildingClass', 'Type',
                    ]

affects_prod = ['CommerceChangeDoubleTimes', 'BonusProductionModifiers', 'ProductionTraits']

prereq_civ4 = ['PrereqTrait', 'StateReligion', 'PrereqReligion', 'bWater', 'bRiver', 'BuildingClassNeededs',
                'iLevelPrereq', 'bRequiresCaster', 'PrereqBuildingClasses', 'Bonus', 'PrereqBonuses',
               'iCitiesPrereq']

others_to_remove += (prereq_civ4 + affects_prod + [i for i in buildings_4_to_6 if i != 'Type']
                     + [i for i in extras_building_map if i != 'Type'])


class Buildings:
    def __init__(self, civs):
        self.logger = logging.getLogger(__name__)
        self.building_modifiers, self.modifier_table, self.civilization_modifiers = [], [], []
        self.modifier_arguments, self.dynamic_modifiers = [], {}
        self.requirements, self.requirement_arguments, self.requirement_set_reqs, self.requirement_set = [], [], [], []
        self.civilization_traits, self.traits, self.trait_modifiers = [], {}, []
        self.building_great_person_points, self.building_yield_changes = [], []
        self.civs = civs
        self.kinds = {}

    def buildings_sql(self, model_obj):
        self.kinds = model_obj['kinds']
        debug_string = ''
        with open('data/XML/Buildings/CIV4BuildingInfos.xml', 'r') as file:
            building_infos = xmltodict.parse(file.read())['Civ4BuildingInfos']['BuildingInfos']['BuildingInfo']

        with open("data/existing_buildings.json", 'r') as json_file:
            exist_dict = json.load(json_file)

        only_useful_build_infos = {i['Type']:
            {key: value for key, value in i.items() if
             value != 'NONE' and value != None and value != '0' and key not in others_to_remove} for i in
            building_infos}

        uniques = set()
        for key, i in only_useful_build_infos.items():
            for key, val in i.items():
                if key not in ['Type', 'BuildingClass']:
                    uniques.add(key)
        self.logger.debug(uniques)
        for build_name, building in only_useful_build_infos.items():
            for key, val in building.items():
                if key == 'FreeBonus':
                    building[key] = {'FreeBonus': val, 'iNumFreeBonuses': building['iNumFreeBonuses']}
                elif key == 'FreeBonus2':
                    building[key] = {'FreeBonus': val, 'iNumFreeBonuses': building['iNumFreeBonuses']}
                elif key == 'FreeBonus3':
                    building[key] = {'FreeBonus': val, 'iNumFreeBonuses': building['iNumFreeBonuses']}
            building.pop('iNumFreeBonuses', None)

        for build_name, building in only_useful_build_infos.items():
            for key, val in building.items():
                if key == 'CommerceModifiers':
                    key = 'CommerceModifiers_City'
                modifier_ids = model_obj['modifiers'].generate_modifier(val, key, 'SLTH_' + build_name)
                if modifier_ids is not None:
                    for modifier_id in modifier_ids:
                        self.building_modifiers.append({'PolicyType': f"MODIFIER_BUILDING_{build_name[9:]}".upper(),
                                                        'ModifierId': modifier_id})

        six_style_build_dict = {f"SLTH_{i['Type']}": small_dict(i, buildings_4_to_6) for i in building_infos}
        six_style_build_extras = {f"SLTH_{i['Type']}": small_dict(i, extras_building_map) for i in building_infos}
        for i in six_style_build_extras.values():
            i['BuildingType'] = f"SLTH_{i['BuildingType']}"

        existing_buildings = exist_dict['existing_buildings']

        for name, building in six_style_build_dict.items():
            building['BuildingType'] = f"SLTH_{building['BuildingType']}"
            building['AdvisorType'], building['TraitType'] = advisor_mapping[building['AdvisorType']], 'NULL'
            building['Name'] = 'LOC_' + building['BuildingType'] + '_NAME'
            building['Description'] = 'LOC_' + building['BuildingType'] + '_DESCRIPTION'
            if building['PrereqTech'] in model_obj['civics']:
                building['PrereqCivic'] = f"SLTH_{model_obj['civics'][building['PrereqTech']]}"
                building['PrereqTech'] = 'NULL'
            else:
                building['PrereqCivic'] = 'NULL'
            if building['PrereqTech'] == 'NONE' or building['PrereqTech'] == 'NULL':
                building['PrereqTech'] = 'NULL'
            else:
                building['PrereqTech'] = f"SLTH_{building['PrereqTech']}"
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
                        debug_string += f"{building['BuildingType']} has multiple specialists, hard to assign\n"
                        building['CitizenSlots'] = 0
            else:
                building['CitizenSlots'] = 'NULL'

            if int(building['Cost']) < 1:
                building['Cost'] = 1

            if 'bNoUnhappiness' in building:
                if building['bNoUnhappiness'] != '0':
                    building['Entertainment'] = 70             # high enough to always be ecstatic, but not above 99
                building.pop('bNoUnhappiness')
            if 'bNoUnhealthyPopulation' in building:
                if building['bNoUnhealthyPopulation'] != '0':
                    building['Housing'] = 70                   # ditto
                building.pop('bNoUnhealthyPopulation')
            if 'iDefense' in building:
                if building['iDefense'] != '0':                      # Done to scale strongest to highest existing
                    building['OuterDefenseHitPoints'] = int(building['iDefense']) * 8
                building.pop('iDefense')

        unbuildable_buildings = {key: value for key, value in six_style_build_dict.items() if int(value['Cost']) <= 1}
        building_conditions = []
        for build_name, building in unbuildable_buildings.items():
            name = building['BuildingType']
            modifier_id = f'MODIFIER_UNBUILDABLE_{name}'
            self.modifier_table.append(
                {'ModifierId': modifier_id, 'ModifierType': 'MODIFIER_PLAYER_ADJUST_VALID_BUILDING'})
            self.modifier_arguments.append({'ModifierId': modifier_id, 'Name': 'BuildingType',
                                            'Type': 'ARGTYPE_IDENTITY', 'Value': name})
            building_conditions.append({'BuildingType': name, 'UnlocksFromEffect': 1})

        for building, modifier_id in patch['Modifier'].items():
            self.modifier_table.append(
                {'ModifierId': modifier_id, 'ModifierType': 'MODIFIER_PLAYER_ADJUST_VALID_BUILDING'})
            self.modifier_arguments.append(
                {'ModifierId': modifier_id, 'Name': 'BuildingType', 'Type': 'ARGTYPE_IDENTITY',
                 'Value': building})  # 'SubjectRequirementSetId': 'PLAYER_HAS_AT_LEAST_TWELVE_CITIES_REQUIREMENTS'
            building_conditions.append({'BuildingType': f"SLTH_{building}", 'UnlocksFromEffect': 1})
            # "INSERT INTO Requirements(RequirementId, RequirementType, ProgressWeight) VALUES ('REQUIRES_PLAYER_HAS_AT_LEAST_TWELVE_CITIES', 'REQUIREMENT_PLAYER_HAS_AT_LEAST_NUMBER_CITIES', '1')"
            # "INSERT INTO RequirementArguments(RequirementId, Name, Type, Value) VALUES ('REQUIRES_PLAYER_HAS_AT_LEAST_TWELVE_CITIES', 'Amount', 'ARGTYPE_IDENTITY', '1')"
            # "INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES('PLAYER_HAS_AT_LEAST_TWELVE_CITIES_REQUIREMENTS', 'REQUIRES_PLAYER_HAS_AT_LEAST_TWELVE_CITIES')"
            # "INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES('PLAYER_HAS_AT_LEAST_TWELVE_CITIES_REQUIREMENTS', 'REQUIRES_PLAYER_HAS_AT_LEAST_TWELVE_CITIES')"

        for building in model_obj['civ_buildings']['civ_traits']:
            six_style_build_dict[building]['TraitType'] = f"SLTH_TRAIT_CIVILIZATION_{building[5:]}"

        palaces = {'building': {key: value for key, value in six_style_build_dict.items() if 'PALACE_' in key},
                   'extras': {key: value for key, value in six_style_build_extras.items() if 'PALACE_' in key}}
        self.palace_gen(palaces)
        six_style_build_dict = {key: value for key, value in six_style_build_dict.items() if 'PALACE_' not in key}
        six_style_build_extras = {key: value for key, value in six_style_build_extras.items() if 'PALACE_' not in key}

        update_buildings = {key: value for key, value in six_style_build_dict.items() if key in existing_buildings}
        six_style_build_dict = {key: value for key, value in six_style_build_dict.items() if
                                key not in existing_buildings}

        building_replaces = []
        for civ, buildings in model_obj['civ_buildings']['dev_null'].items():
            if civ == 'CIVILIZATION_BARBARIAN':
                continue
            for building in buildings:
                civ_null = BUILDING_NULL.copy()
                civ_null['BuildingType'] = f"{civ_null['BuildingType']}_{civ}_{building[14:]}"
                civ_null['TraitType'] = f"{civ_null['TraitType']}_{civ}"
                self.traits[civ_null['TraitType']] = {'TraitType': civ_null['TraitType'],
                                                      'Name': f"LOC_SLTH_{civ_null['TraitType']}_NAME",
                                                      'Description': 'LOC_NULL_DESCRIPTION'}
                six_style_build_dict[civ_null['BuildingType']] = civ_null
                building_replaces.append({'CivUniqueBuildingType': civ_null['BuildingType'],
                                          'ReplacesBuildingType': building})
                model_obj['kinds'][civ_null['TraitType']] = 'KIND_TRAIT'

        for building in six_style_build_dict:
            self.kinds[building] = 'KIND_BUILDING'

        for name, building in six_style_build_extras.items():
            if building.get('YieldType', None) is not None and building['YieldType'] != 'NONE':
                for idx, amount in enumerate(building['YieldType']['iCommerce']):
                    if int(amount) != 0:
                        self.building_yield_changes.append({'BuildingType': name, 'YieldType': commerce_map[idx],
                                                       'YieldChange': amount})
            if building.get('GreatPersonClassType', 'NONE') != 'NONE':
                self.building_great_person_points.append({'BuildingType': name,
                                                     'GreatPersonClassType': gpp_map[building['GreatPersonClassType']],
                                                     'PointsPerTurn': building['PointsPerTurn']})

        make_or_add(model_obj['sql_inserts'], six_style_build_dict, 'Buildings')
        update_or_add(model_obj['sql_updates'], update_buildings, 'Buildings', ['BuildingType'])
        make_or_add(model_obj['sql_inserts'], self.building_great_person_points, 'Building_GreatPersonPoints')
        make_or_add(model_obj['sql_inserts'], self.building_yield_changes, 'Building_YieldChanges')
        make_or_add(model_obj['sql_inserts'], building_conditions, 'BuildingConditions')
        make_or_add(model_obj['sql_inserts'], building_replaces, 'BuildingReplaces')
        make_or_add(model_obj['sql_inserts'], self.traits, 'Traits')

        model_obj['kinds'] = self.kinds
        model_obj['update_build'] = [i for i in update_buildings]

    def add_to_modifiers(self, name, modifier_id, modifier_type, modifier_names, modifier_values, is_palace=False):
        if is_palace:
            trait_type = f'SLTH_TRAIT_CIVILIZATION_{name[14:]}'
            if {'CivilizationType': f'SLTH_CIVILIZATION_{name[21:]}',
                'TraitType': trait_type} not in self.civilization_traits:
                self.civilization_traits.append(
                    {'CivilizationType': f'SLTH_CIVILIZATION_{name[21:]}', 'TraitType': trait_type})
            self.traits[trait_type] = {'TraitType': trait_type, 'Name': f"LOC_{trait_type}_NAME",
                                       'Description': f"LOC_{trait_type}_DESCRIPTION"}
            self.kinds[trait_type] = 'KIND_TRAIT'
            self.trait_modifiers.append({'TraitType': trait_type, 'ModifierId': modifier_id})
        else:
            self.building_modifiers.append({'BuildingType': name, 'ModifierId': modifier_id})
        self.modifier_table.append(
            {'ModifierId': modifier_id, 'ModifierType': modifier_type})
        for name, value in zip(modifier_names, modifier_values):
            self.modifier_arguments.append({'ModifierId': modifier_id, 'Name': name, 'Type': 'ARGTYPE_IDENTITY',
                                            'Value': value})

    def palace_gen(self, palaces):
        for name, building in palaces['extras'].items():
            # DAMN GRIGORI
            if building.get('iGreatPeopleRateModifier', '0') != '0':
                modifier_id = f"MODIFIER_{name[14:]}_INCREASE_GPP_MULT"
                modifier_type = 'MODIFIER_PLAYER_CAPITAL_CITY_GPP_MULT'
                trait_type = f'TRAIT_CIVILIZATION_{name[14:]}_GPP_MULT'
                modifier_names = ['Amount']
                modifier_values = [building['iGreatPeopleRateModifier']]
                self.traits[trait_type] = {'TraitType': trait_type, 'Name': f"LOC_SLTH_{trait_type}_NAME",
                                           'Description': 'NULL'}
                self.kinds[trait_type] = 'KIND_TRAIT'
                self.dynamic_modifiers[modifier_type] = {'ModifierType': modifier_type,
                                                         'CollectionType': 'COLLECTION_PLAYER_CAPITAL_CITY',
                                                         'EffectType': 'EFFECT_ADJUST_CITY_GREAT_PERSON_POINTS_MODIFIER'}
                self.civilization_traits.append({'CivilizationType': f"SLTH_CIVILIZATION_{name[21:]}",
                                                 'TraitType': trait_type})
                self.trait_modifiers.append({'TraitType': trait_type, 'ModifierId': modifier_id})
                self.modifier_table.append({'ModifierId': modifier_id, 'ModifierType': modifier_type})
                for m_name, value in zip(modifier_names, modifier_values):
                    self.modifier_arguments.append({'ModifierId': modifier_id, 'Name': m_name,
                                                    'Type': 'ARGTYPE_IDENTITY', 'Value': value})

            if building.get('GreatPersonClassType', 'NONE') != 'NONE':
                great_person = gpp_map[building['GreatPersonClassType']]
                modifier_id = f"MODIFIER_{name[14:]}_INCREASE_GPP_POINT_BONUS"
                modifier_type = 'MODIFIER_PLAYER_CAPITAL_CITY_GPP_INCREASE'
                trait_type = f'TRAIT_CIVILIZATION_{name[14:]}_GPP_INCREASE'
                modifier_names = ['GreatPersonClassType', 'Amount']
                modifier_values = [great_person, building['PointsPerTurn']]
                self.dynamic_modifiers[modifier_type] = {'ModifierType': modifier_type,
                                                         'CollectionType': 'COLLECTION_PLAYER_CAPITAL_CITY',
                                                         'EffectType': 'EFFECT_ADJUST_GREAT_PERSON_POINTS'}
                self.civilization_traits.append({'CivilizationType': f"SLTH_CIVILIZATION_{name[21:]}",
                                                 'TraitType': trait_type})
                self.traits[trait_type] = {'TraitType': trait_type, 'Name': f'LOC{trait_type}_NAME', 'Description': f'LOC{trait_type}_DESCRIPTION'}
                self.trait_modifiers.append({'TraitType': trait_type, 'ModifierId': modifier_id})
                self.modifier_table.append({'ModifierId': modifier_id, 'ModifierType': modifier_type})
                self.kinds[trait_type] = 'KIND_TRAIT'
                for m_name, value in zip(modifier_names, modifier_values):
                    self.modifier_arguments.append({'ModifierId': modifier_id, 'Name': m_name,
                                                    'Type': 'ARGTYPE_IDENTITY', 'Value': value})

    def building_features(self, six_style_build_extras, exist_dict):
        existing_buildings_gpp = exist_dict['existing_buildings_gpp']
        existing_buildings_yields = exist_dict['existing_buildings_yields']
        building_great_person_points, building_yield_changes = [], []

        building_great_person_points = [i for i in building_great_person_points if
                                        not i['BuildingType'] in existing_buildings_gpp]

        building_yield_changes = [i for i in building_yield_changes if
                                  not i['BuildingType'] in existing_buildings_yields]



        building_features_string = ''
        building_features_string += build_sql_table(building_great_person_points, 'Building_GreatPersonPoints')
        building_features_string += build_sql_table(building_yield_changes, 'Building_YieldChanges')
        building_features_string += build_sql_table(self.building_modifiers, 'BuildingModifiers')
        building_features_string += build_sql_table(self.modifier_table, 'Modifiers')
        building_features_string += build_sql_table(self.modifier_arguments, 'ModifierArguments')

        return building_features_string


def districts_build(model_obj):
    district_changes = [{'DistrictType': 'DISTRICT_HOLY_SITE', 'PrereqCivic': 'SLTH_CIVIC_MYSTICISM'},
                        {'DistrictType': 'DISTRICT_CAMPUS', 'PrereqCivic': 'SLTH_CIVIC_MYSTICISM'},
                        {'DistrictType': 'DISTRICT_ENCAMPMENT', 'PrereqTech': 'SLTH_TECH_BRONZE_WORKING'},
                        {'DistrictType': 'DISTRICT_HARBOR', 'PrereqTech': 'SLTH_TECH_FISHING'},
                        {'DistrictType': 'DISTRICT_COMMERCIAL_HUB', 'PrereqCivic': 'SLTH_CIVIC_FESTIVALS'},
                        {'DistrictType': 'DISTRICT_ENTERTAINMENT_COMPLEX', 'PrereqCivic': 'SLTH_CIVIC_DRAMA'},
                        {'DistrictType': 'DISTRICT_THEATER', 'PrereqCivic': 'SLTH_CIVIC_FESTIVALS'},
                        {'DistrictType': 'DISTRICT_INDUSTRIAL_ZONE', 'PrereqTech': 'SLTH_TECH_SMELTING'},
                        {'DistrictType': 'DISTRICT_AQUEDUCT', 'PrereqTech': 'SLTH_TECH_SANITATION'}]

    to_keep = "', '".join([i['DistrictType'] for i in district_changes] + ['DISTRICT_CITY_CENTER', 'DISTRICT_WONDER'])
    update_or_add(model_obj['sql_updates'], district_changes, 'Districts', ['DistrictType'])
