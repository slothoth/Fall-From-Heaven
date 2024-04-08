from utils import small_dict, build_sql_table, localization, update_sql_table
import xmltodict
import json

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
        self.building_modifiers, self.modifier_table, self.civilization_modifiers = [], [], []
        self.modifier_arguments, self.dynamic_modifiers = [], {}
        self.requirements, self.requirement_arguments, self.requirement_set_reqs, self.requirement_set = [], [], [], []
        self.civilization_traits, self.traits, self.trait_modifiers = [], {}, []
        self.building_great_person_points, self.building_yield_changes = [], []
        self.civs = civs

    def buildings_sql(self, civics, civ_data, kinds, modifiers):
        self.kinds = kinds
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
                    # print(f"{i['Type']} has modifier {key} and value {val}")
                    uniques.add(key)
        print(uniques)
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
                modifier_ids = modifiers.generate_modifier(val, key, build_name[9:])
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
                        debug_string += f"{building['BuildingType']} has multiple specialists, hard to assign\n"
                        building['CitizenSlots'] = 0
            else:
                building['CitizenSlots'] = 'NULL'

            if int(building['Cost']) < 1:
                building['Cost'] = 1

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

        for building in civ_data['civ_traits']:
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
        for civ, buildings in civ_data['dev_null'].items():
            if civ == 'CIVILIZATION_BARBARIAN':
                continue
            for building in buildings:
                civ_null = BUILDING_NULL.copy()
                civ_null['BuildingType'] = f"{civ_null['BuildingType']}_{civ}_{building[14:]}"
                civ_null['TraitType'] = f"{civ_null['TraitType']}_{civ}"
                self.traits[civ_null['TraitType']] = {'TraitType': civ_null['TraitType'],
                                                      'Name': f"LOC_{civ_null['TraitType']}_NAME",
                                                      'Description': 'NULL'}
                six_style_build_dict[civ_null['BuildingType']] = civ_null
                building_replaces.append({'CivUniqueBuildingType': civ_null['BuildingType'],
                                          'ReplacesBuildingType': building})
                kinds[civ_null['TraitType']] = 'KIND_TRAIT'

        for building in six_style_build_dict:
            self.kinds[building] = 'KIND_BUILDING'

        self.building_features(six_style_build_extras)

        building_table_string = build_sql_table(six_style_build_dict, 'Buildings')
        building_table_string += update_sql_table(update_buildings, 'Buildings', ['BuildingType'])
        building_table_string += build_sql_table(self.building_great_person_points, 'Building_GreatPersonPoints')
        building_table_string += build_sql_table(self.building_yield_changes, 'Building_YieldChanges')
        building_table_string += build_sql_table(building_conditions, 'BuildingConditions')
        building_table_string += build_sql_table(building_replaces, 'BuildingReplaces')

        localization(six_style_build_dict)
        print(debug_string)

        return building_table_string, self.kinds, [i for i in update_buildings]

    def building_features(self, six_style_build_extras):
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

    def building_modifiers_generate(self, six_style_modifiers):
        for name, building in six_style_modifiers.items():
            if building.get('YieldModifiers', None) is not None and building['YieldModifiers'] != 'NONE':
                for idx, amount in enumerate(building['YieldModifiers']['iYield']):
                    if int(amount) != 0:
                        self.add_to_modifiers(name=name,
                                              modifier_id=f"MODIFIER_{name[14:]}_ADD{yield_map[idx][5:]}YIELD",
                                              modifier_names=['Amount', 'YieldType'],
                                              modifier_values=[amount, yield_map[idx]],
                                              modifier_type='MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER')

            if building.get('CommerceModifier', None) is not None and building['CommerceModifier'] != 'NONE':
                for idx, amount in enumerate(building['CommerceModifier']['iCommerce']):
                    if int(amount) != 0:
                        self.add_to_modifiers(name=name,
                                              modifier_id=f"MODIFIER_{name[14:]}_ADD{commerce_map[idx][5:]}YIELD",
                                              modifier_names=['Amount', 'YieldType'],
                                              modifier_values=[amount, commerce_map[idx]],
                                              modifier_type='MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER')

            if building.get('BonusYieldModifiers', None) is not None and building['BonusYieldModifiers'] != 'NONE':
                for resource in building['BonusYieldModifiers']['BonusYieldModifier']:
                    for idx, amount in enumerate(resource['YieldModifiers']['iYield']):
                        if int(amount) != 0:
                            self.add_to_modifiers(name=name,
                                                  modifier_id=f"MODIFIER_{name[14:]}_{resource['BonusType']}_MULT_YIELD",
                                                  modifier_names=['Amount', 'YieldType'],
                                                  modifier_values=[amount, yield_map[idx]],
                                                  modifier_type='MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER')
                            # TODO add requirement needing access to the bonus resource

            if building.get('iTradeRouteModifier', None) is not None and building['iTradeRouteModifier'] != '0':
                trade_route_modifier = 'MODIFIER_CITY_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL'
                modifier_id = f"MODIFIER_{name[14:]}_TRADE_ROUTE_YIELD_MULT"
                vt = building['iTradeRouteModifier']
                if trade_route_modifier not in [i for i in self.dynamic_modifiers]:
                    self.dynamic_modifiers[trade_route_modifier] = {'ModifierType': trade_route_modifier,
                                              'CollectionType': 'COLLECTION_OWNER',
                                              'EffectType': 'EFFECT_ADJUST_CITY_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL'}
                self.add_to_modifiers(name=name,
                                      modifier_id=modifier_id,
                                      modifier_names=['YieldType', 'Amount'],
                                      modifier_values=['YIELD_PRODUCTION, YIELD_FOOD, YIELD_SCIENCE, YIELD_CULTURE, '
                                                       'YIELD_GOLD, YIELD_FAITH', f'{vt}, {vt}, {vt}, {vt}, {vt}, {vt}'
                                                       ],
                                      modifier_type=trade_route_modifier)

            if building.get('FreeBonus', None) is not None and building['FreeBonus'] != 'NONE':
                self.add_to_modifiers(name=name,
                                      modifier_id=f"MODIFIER_{name[14:]}_GRANT_{building['FreeBonus'][6:]}",
                                      modifier_names=['ResourceType', 'Amount'],
                                      modifier_values=[f"RESOURCE_{building['FreeBonus'][6:]}",
                                                       f"{building['iNumFreeBonuses']}"],
                                      modifier_type='MODIFIER_SINGLE_CITY_GRANT_RESOURCE_IN_CITY')

            if building.get('FreeBonus2', None) is not None and building['FreeBonus2'] != 'NONE':
                self.add_to_modifiers(name=name,
                                      modifier_id=f"MODIFIER_{name[14:]}_GRANT_{building['FreeBonus2'][6:]}",
                                      modifier_names=['ResourceType', 'Amount'],
                                      modifier_values=[f"RESOURCE_{building['FreeBonus2'][6:]}",
                                                       f"{building['iNumFreeBonuses']}"],
                                      modifier_type='MODIFIER_SINGLE_CITY_GRANT_RESOURCE_IN_CITY')

            if building.get('FreeBonus3', None) is not None and building['FreeBonus3'] != 'NONE':
                self.add_to_modifiers(name=name,
                                      modifier_id=f"MODIFIER_{name[14:]}_GRANT_{building['FreeBonus3'][6:]}",
                                      modifier_names=['ResourceType', 'Amount'],
                                      modifier_values=[f"RESOURCE_{building['FreeBonus3'][6:]}",
                                                       f"{building['iNumFreeBonuses']}"],
                                      modifier_type='MODIFIER_SINGLE_CITY_GRANT_RESOURCE_IN_CITY')

                # if building.get('Bonus', None) is not None and building['Bonus'] != 'NONE':
                # to implement
                """'DomainProductionModifiers': 'DomainProductionModifiers',
                MARITIMIEINDUSTRIES_ANCIENT_NAVAL_MELEE_PRODUCTION, Amount, ARGTYPE_IDENTITY, 100, -1,
                MARITIMIEINDUSTRIES_ANCIENT_NAVAL_MELEE_PRODUCTION, EraType, ARGTYPE_IDENTITY, ERA_ANCIENT, -1,
                MARITIMIEINDUSTRIES_ANCIENT_NAVAL_MELEE_PRODUCTION, UnitPromotionClass, ARGTYPE_IDENTITY, PROMOTION_CLASS_NAVAL_MELEE, -1,
                'iGlobalSpaceProductionModifier': 'iGlobalSpaceProductionModifier' "HONG_KONG CITY STATE BONUS"
                'iFreePromotionPick': 'iFreePromotionPick'"""

        building_features_string = ''
        building_features_string += build_sql_table(self.building_modifiers, 'BuildingModifiers')
        building_features_string += build_sql_table(self.modifier_table, 'Modifiers')
        building_features_string += build_sql_table(self.modifier_arguments, 'ModifierArguments')
        building_features_string += build_sql_table([i for i in self.civilization_traits], 'CivilizationTraits')
        building_features_string += build_sql_table([i for i in self.traits.values()], 'Traits')
        building_features_string += build_sql_table(self.trait_modifiers, 'TraitModifiers')
        return building_features_string

    def add_to_modifiers(self, name, modifier_id, modifier_type, modifier_names, modifier_values, is_palace=False):
        if is_palace:
            trait_type = f'SLTH_TRAIT_CIVILIZATION_{name[14:]}'
            if {'CivilizationType': f'SLTH_CIVILIZATION_{name[21:]}',
                'TraitType': trait_type} not in self.civilization_traits:
                self.civilization_traits.append(
                    {'CivilizationType': f'SLTH_CIVILIZATION_{name[21:]}', 'TraitType': trait_type})
            self.traits[trait_type] = {'TraitType': trait_type, 'Name': f"LOC_{trait_type}_NAME",
                                       'Description': 'NULL'}
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
            if building.get('FreeBonus', None) is not None and building['FreeBonus'] != 'NONE':
                self.add_to_modifiers(name=name,
                                      modifier_id=f"MODIFIER_{name[14:]}_GRANT_{building['FreeBonus'][6:]}",
                                      modifier_names=['ResourceType', 'Amount'],
                                      modifier_values=[f"RESOURCE_{building['FreeBonus'][6:]}",
                                                       f"{building['iNumFreeBonuses']}"],
                                      modifier_type='MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT', is_palace=True)

            if building.get('FreeBonus2', None) is not None and building['FreeBonus2'] != 'NONE':
                self.add_to_modifiers(name=name,
                                      modifier_id=f"MODIFIER_{name[14:]}_GRANT_{building['FreeBonus2'][6:]}",
                                      modifier_names=['ResourceType', 'Amount'],
                                      modifier_values=[f"RESOURCE_{building['FreeBonus2'][6:]}",
                                                       f"{building['iNumFreeBonuses']}"],
                                      modifier_type='MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT', is_palace=True)

            if building.get('FreeBonus3', None) is not None and building['FreeBonus3'] != 'NONE':
                self.add_to_modifiers(name=name,
                                      modifier_id=f"MODIFIER_{name[14:]}_GRANT_{building['FreeBonus3'][6:]}",
                                      modifier_names=['ResourceType', 'Amount'],
                                      modifier_values=[f"RESOURCE_{building['FreeBonus3'][6:]}",
                                                       f"{building['iNumFreeBonuses']}"],
                                      modifier_type='MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT', is_palace=True)

            if building.get('YieldModifiers', None) is not None and building['YieldModifiers'] != 'NONE':
                for idx, amount in enumerate(building['YieldModifiers']['iYield']):
                    if int(amount) != 0:
                        self.add_to_modifiers(name=name,
                                              modifier_id=f"MODIFIER_{name[14:]}_ADD{yield_map[idx][5:]}YIELD",
                                              modifier_names=['Amount', 'YieldType'], is_palace=True,
                                              modifier_values=[amount, yield_map[idx]],
                                              modifier_type='MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_YIELD_MODIFIER')

            if building.get('CommerceModifier', None) is not None and building['CommerceModifier'] != 'NONE':
                for idx, amount in enumerate(building['CommerceModifier']['iCommerce']):
                    if int(amount) != 0:
                        self.add_to_modifiers(name=name,
                                              modifier_id=f"MODIFIER_{name[14:]}_ADD{commerce_map[idx][5:]}YIELD",
                                              modifier_names=['Amount', 'YieldType'], is_palace=True,
                                              modifier_values=[amount, commerce_map[idx]],
                                              modifier_type='MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_YIELD_MODIFIER')
            # DAMN GRIGORI
            if building.get('iGreatPeopleRateModifier', '0') != '0':
                modifier_id = f"MODIFIER_{name[14:]}_INCREASE_GPP_MULT"
                modifier_type = 'MODIFIER_PLAYER_CAPITAL_CITY_GPP_MULT'
                trait_type = f'TRAIT_CIVILIZATION_{name[14:]}_GPP_MULT'
                modifier_names = ['Amount']
                modifier_values = [building['iGreatPeopleRateModifier']]
                self.traits[trait_type] = {'TraitType': trait_type, 'Name': f"LOC_{trait_type}_NAME",
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
                self.traits[trait_type] = {'TraitType': trait_type, 'Name': 'NULL', 'Description': 'NULL'}
                self.trait_modifiers.append({'TraitType': trait_type, 'ModifierId': modifier_id})
                self.modifier_table.append({'ModifierId': modifier_id, 'ModifierType': modifier_type})
                self.kinds[trait_type] = 'KIND_TRAIT'
                for m_name, value in zip(modifier_names, modifier_values):
                    self.modifier_arguments.append({'ModifierId': modifier_id, 'Name': m_name,
                                                    'Type': 'ARGTYPE_IDENTITY', 'Value': value})


def districts_build():
    district_changes = [{'DistrictType': 'DISTRICT_HOLY_SITE', 'PrereqCivic': 'CIVIC_MYSTICISM'},
                        {'DistrictType': 'DISTRICT_CAMPUS', 'PrereqCivic': 'CIVIC_MYSTICISM'},
                        {'DistrictType': 'DISTRICT_ENCAMPMENT', 'PrereqTech': 'TECH_BRONZE_WORKING'},
                        {'DistrictType': 'DISTRICT_HARBOR', 'PrereqTech': 'TECH_FISHING'},
                        {'DistrictType': 'DISTRICT_COMMERCIAL_HUB', 'PrereqCivic': 'CIVIC_FESTIVALS'},
                        {'DistrictType': 'DISTRICT_ENTERTAINMENT_COMPLEX', 'PrereqCivic': 'CIVIC_DRAMA'},
                        {'DistrictType': 'DISTRICT_THEATER', 'PrereqCivic': 'CIVIC_FESTIVALS'},
                        {'DistrictType': 'DISTRICT_INDUSTRIAL_ZONE', 'PrereqTech': 'TECH_SMELTING'},
                        {'DistrictType': 'DISTRICT_AQUEDUCT', 'PrereqTech': 'TECH_SANITATION'}]

    to_keep = "', '".join([i['DistrictType'] for i in district_changes] + ['DISTRICT_CITY_CENTER', 'DISTRICT_WONDER'])
    districts_string = f"DELETE FROM Districts WHERE DistrictType NOT IN ('{to_keep}');\n"
    districts_string += update_sql_table(district_changes, 'Districts', ['DistrictType'])
    return districts_string
