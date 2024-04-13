from utils import build_sql_table

commerce_map = ['YIELD_GOLD', 'YIELD_SCIENCE', 'YIELD_CULTURE']
yield_map = ['YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_GOLD']
gpp_map = {'UNITCLASS_PROPHET': 'GREAT_PERSON_CLASS_PROPHET', 'UNITCLASS_COMMANDER': 'GREAT_PERSON_CLASS_GENERAL',
           'UNITCLASS_MERCHANT': 'GREAT_PERSON_CLASS_MERCHANT', 'UNITCLASS_ENGINEER': 'GREAT_PERSON_CLASS_ENGINEER',
           'UNITCLASS_SCIENTIST': 'GREAT_PERSON_CLASS_SCIENTIST', 'UNITCLASS_ARTIST': 'GREAT_PERSON_CLASS_ARTIST',
           'UNITCLASS_ADVENTURER': 'GREAT_PERSON_CLASS_WRITER'}
map_specialists = {'SPECIALIST_SCIENTIST': 'DISTRICT_CAMPUS', 'SPECIALIST_ENGINEER': 'DISTRICT_INDUSTRIAL_ZONE',
                   'SPECIALIST_PRIEST': 'DISTRICT_HOLY_SITE', 'SPECIALIST_ARTIST': 'DISTRICT_THEATER',
                   'SPECIALIST_MERCHANT': 'DISTRICT_COMMERCIAL_HUB'}


class Modifiers:
    def __init__(self):
        self.modifiers = {}
        self.dynamic_modifiers = {}
        self.modifier_arguments = []
        self.traits = {}
        self.trait_modifiers = []

        self.requirements = {}
        self.requirements_arguments = []
        self.requirement_set_reqs = []
        self.requirement_set = []

        self.complete_set = {}

        self.modifier_map = {'CapitalCommerceModifiers': self.capital_commerce_modifier,
                             'CapitalYieldModifiers': self.capital_yield_modifier,  # dummy
                             'iWarWearinessModifier': self.war_weariness_modifier,
                             'CommerceModifiers': self.commerce_modifier,
                             'ImprovementYieldChanges': self.improvement_yield_modifier,
                             'iGreatPeopleRateModifier': self.gpp_rate_modifier,
                             'iExtraHealth': self.housing_modifier,
                             'BuildingHappinessChanges': self.buildings_amenities_modifier,
                             'iMilitaryProductionModifier': self.military_prod_modifier,
                             'FreePromotion': self.free_xp_modifier,
                             'DomainFreeExperiences': self.free_xp_modifier_promo_class_specific,
                             'DomainProductionModifiers': self.prod_modifier_class_specific,
                             'iEnslavementChance': self.slave_taking_modifier,
                             'iWorkerSpeedModifier': self.builder_charge_modifier,
                             'iTradeRoutes': self.trade_route_count_modifier,
                             'iCoastalTradeRoutes': self.trade_route_count_sea_modifier,
                             'iGlobalHappiness': self.global_amenities_modifier,
                             'iGlobalHealth': self.global_housing_modifier,
                             'iAreaHealth': self.global_housing_modifier,
                             'FreeBonus': self.free_bonus_modifier,
                             'FreeBonus2': self.free_bonus_modifier,
                             'FreeBonus3': self.free_bonus_modifier,
                             'FreeBuilding': self.free_building_modifier,
                             'iGlobalSpaceProductionModifier': self.project_prod_mult_modifier,
                             'YieldModifiers': self.yield_modifier,
                             'SeaPlotYieldChanges': self.plot_yield_modifier,
                             'GlobalSeaPlotYieldChanges': self.plot_yield_modifier_global,
                             'iTradeRouteModifier': self.trade_route_yield_modifier,
                             }

        not_implemented = {'iHealRateChange': self.apply_to_unit_if_in_cityImplement,
                           'iResistMagic': self.apply_to_unit_if_in_cityImplement,
                           'Upkeep': self.maintenanceImplement,
                           'iMaintenanceModifier': self.maintenanceImplement,
                           'iNumCitiesMaintenanceModifier': self.maintenanceImplement,
                           'iDistanceMaintenanceModifier': self.maintenanceImplement,
                           'iFreeUnitsPopulationPercent': self.maintenanceImplement,
                           'bGovernmentCenter': self.maintenanceImplement,
                           'bNoNonStateReligionSpread': self.religionImplement,
                           'bStateReligion': self.religionImplement,
                           'iStateReligionHappiness': self.religionImplement,
                           'iStateReligionFreeExperience': self.religionImplement,
                           'iStateReligionUnitProductionModifier': self.religionImplement,
                           'iStateReligionGreatPeopleRateModifier': self.religionImplement,
                           'bPrereqReligion': self.religionImplement,
                           'StateReligionCommerces': self.religionImplement,
                           'iGlobalResistEnemyModify': self.magicImplement,
                           'iGlobalResistEnemyModifier':  self.magicImplement,
                           'iGlobalResistModify':  self.magicImplement,
                           'BlockAlignment': self.alignmentImplement,
                           'iLargestCityHappiness': self.otherSystemImplement,
                           'bNoDiplomacyWithEnemies': self.otherSystemImplement,
                           'iModifyGlobalCounter': self.otherSystemImplement,           # armageddon/CO2
                           'VictoryPrereq': self.otherSystemImplement,           # New victory type
                           'iFoodConsumptionPerPopulation': self.cantImplement,  # seems hardcoded
                           'Hurrys': self.cantImplement,  # just purchase
                           'iMaxConscript': self.cantImplement,  # units recruitable from city pop
                           'bMilitaryFoodProduction': self.cantImplement,  # food unused, added to prod
                           'iFoodKept': self.cantImplement,  # store food
                           'bUnhappyProduction': self.cantImplement,  # Gives prod equal to amenities required.
                           'bForceTeamVoteEligible': self.cantImplement,  # no way to limit congress
                           'bSeeInvisible': self.cantImplement,  # invis is barely a concept as is
                           'iBombardDefense': self.cantImplement, # wall strength and wall hp seems same
                           'bHideUnits': self.otherSystemImplement,
                           # apply wukong invis as ability, like khan capture cavalry
                           'CommerceHappinesses': self.cantImplement,  # no concept of slider commerce
                           'iAllCityDefense': self.cantImplement,  # city defense handled by walls now, and only highest
                           'bPrereqWar': self.prereqImplement,
                           'PrereqReligion': self.prereqImplement,
                           'PrereqCivilization': self.prereqImplement,
                           'SpecialistValids': self.specialistImplement,
                           'SpecialistExtraCommerces': self.specialistImplement,
                           'iFreeSpecialist': self.specialistImplement,
                           'SpecialistCounts': self.specialistImplement,
                           'FreeSpecialistCounts': self.specialistImplement,
                           'iCivicPercentAnger': self.no_fucking_clue,
                           'bNoCivicAnger': self.no_fucking_clue,               # WHAT IS civic anger
                           'iHappyPerMilitaryUnit': self.no_fucking_clue,  # cant stack city units, so retainers
                           'RemovePromotion': self.no_fucking_clue,  # implement temp effects first
                           'iAirlift': self.no_fucking_clue,  # airlift hardcoded, needs all airport buildings
                           'SpecialBuildingType': self.no_fucking_clue,
                           'iAreaHappiness': self.no_fucking_clue,              # its continent level modifier...
                           'FeatureHappinessChanges': self.feature_happiness_modifier,
                           'BonusYieldModifiers': self.bonus_requirementImplementation,
                           'BonusHappinessChanges': self.bonus_requirementImplementation,
                           'BonusHealthChanges': self.bonus_requirementImplementation
                           }

        somewhat_botched = {'iGlobalExperience': self.free_xp_modifier,
                            'iFreeExperience': self.free_xp_modifier,
                            'UnitCombatFreeExperiences': self.free_xp_modifier,
                            'bApplyFreePromotionOnMove': self.free_xp_modifier,
                            'iFreePromotionPick': self.free_xp_modifier,
                            'bNoForeignTrade': self.no_foreign_trade,
                            'iFreeTechs': self.free_tech_grant,
                            'iGlobalWarWearinessModifier': self.war_weariness_modifier
                            }

        self.modifier_map.update(not_implemented)
        self.modifier_map.update(somewhat_botched)

    def capital_commerce_modifier(self, civ4_target, name):
        return self.commerce_modifier(civ4_target, name,
                                      modifier_type='MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_YIELD_MODIFIER')

    def capital_yield_modifier(self, civ4_target, name):
        return self.commerce_modifier(civ4_target, name, mapper=yield_map,
                                      modifier_type='MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_YIELD_MODIFIER')

    def war_weariness_modifier(self, civ4_target, name):
        modifier = {'ModifierId': f"MODIFIER_{name}_ADJUST_WAR_WEARINESS",
                    'ModifierType': 'MODIFIER_PLAYER_ADJUST_WAR_WEARINESS'}
        modifier_args = []
        for name, value in [('Amount', civ4_target), ('Overall', 1)]:
            modifier_args.append({'ModifierId': modifier['ModifierId'], 'Name': name, 'Type': 'ARGTYPE_IDENTITY',
                                  'Value': value})
        self.organize(modifier, modifier_args)
        return [modifier['ModifierId']]

    def commerce_modifier(self, civ4_target, name, mapper=None,
                          modifier_type='MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER'):
        if mapper is None:
            mapper = commerce_map

        modifiers = []
        modifier_args = []
        yield_changes = next(iter(civ4_target.values()))
        for idx, amount in enumerate(yield_changes):
            if int(amount) != 0:
                modifier = {'ModifierId': f"MODIFIER_{name}_ADD_{mapper[idx][6:]}YIELD",
                            'ModifierType': modifier_type}
                modifiers.append(modifier)
                for name, value in [('Amount', amount), ('YieldType', mapper[idx])]:
                    modifier_args.append({'ModifierId': modifier['ModifierId'], 'Name': name,
                                          'Type': 'ARGTYPE_IDENTITY', 'Value': value})

        self.organize(modifiers, modifier_args)
        return [i['ModifierId'] for i in modifiers]

    def improvement_yield_modifier(self, civ4_target, name):
        improvement = civ4_target['ImprovementYieldChange']['ImprovementType']
        modifiers = []
        modifier_args = []
        yield_changes = civ4_target['ImprovementYieldChange']['ImprovementYields']['iYield']
        for idx, amount in enumerate(yield_changes):
            if int(amount) != 0:
                modifier = {'ModifierId': f"MODIFIER_{name}_{improvement[12:]}_{yield_map[idx][6:]}",
                            'ModifierType': 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',
                            'SubjectRequirementSetId': f'PLOT_HAS_{improvement[12:]}_REQUIREMENTS'}
                modifiers.append(modifier)
                for name, value in [('Amount', amount), ('YieldType', yield_map[idx])]:
                    modifier_args.append({'ModifierId': modifier['ModifierId'], 'Name': name,
                                          'Type': 'ARGTYPE_IDENTITY', 'Value': value})

        self.organize(modifiers, modifier_args)
        return [i['ModifierId'] for i in modifiers]

    def gpp_rate_modifier(self, civ4_target, name):
        modifier = {'ModifierId': f"MODIFIER_{name}_INCREASE_GPP_MULT",
                    'ModifierType': 'MODIFIER_PLAYER_CITIES_ADJUST_GREAT_PERSON_POINT_BONUS'}

        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': name, 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target}]
        self.organize(modifier, modifier_args)
        return [modifier['ModifierId']]

    def buildings_amenities_modifier(self, civ4_target, name, **kwargs):
        buildings = civ4_target['BuildingHappinessChange']
        modifiers, modifier_args, requirements, requirement_arguments, requirement_set = [], [], [], [], []
        if not isinstance(buildings, list):
            buildings = [buildings]
        for building in buildings:
            building_name = building.pop('BuildingType')
            amount = next(iter(building.values()))
            building_name = building_name.replace('BUILDINGCLASS', 'BUILDING')
            modifier = {'ModifierId': f"MODIFIER_{name}_{building_name}_ADD_AMENITIES",
                        'ModifierType': 'MODIFIER_SINGLE_CITY_ADJUST_ENTERTAINMENT',
                        'SubjectRequirementSetId': f'SLTH_REQUIRES_CITY_HAS_{building_name[9:]}'}
            modifiers.append(modifier)
            modifier_args.append({'ModifierId': modifier['ModifierId'], 'Name': name, 'Type': 'ARGTYPE_IDENTITY',
                                  'Value': amount})
            requirements_ = {'RequirementId': modifier['SubjectRequirementSetId'],
                             'RequirementType': 'REQUIREMENT_CITY_HAS_BUILDING'}
            requirements.append(requirements_)
            requirement_arguments.append({'RequirementId': requirements_['RequirementId'], 'Name': 'BuildingType',
                                          'Type': 'ARGTYPE_IDENTITY', 'Value': building_name})
            requirement_set.append({'RequirementSetId': requirements_['RequirementId'],
                                    'RequirementSetType': 'REQUIREMENTSET_TEST_ALL'})
        self.organize(modifiers, modifier_args, requirements=requirements, requirements_arguments=requirement_arguments,
                      requirements_set=requirement_set)

        """RequirementSetRequirements(RequirementSetId, RequirementId)
                VALUES('BUILDING_IS_FACTORY', 'REQUIRES_CITY_HAS_FACTORY');"""
        return [i['ModifierId'] for i in modifiers]

    def military_prod_modifier(self, civ4_target, name):
        modifier = {'ModifierId': f"MODIFIER_{name}_MILITARY_PRODUCTION",
                    'ModifierType': 'MODIFIER_PLAYER_CITIES_ADJUST_MILITARY_UNITS_PRODUCTION'}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target}]
        self.organize(modifier, modifier_args)
        return [modifier['ModifierId']]

    def free_xp_modifier(self, civ4_target, name):
        modifier = {'ModifierId': f"MODIFIER_{name}_MILITARY_EXPERIENCE",
                    'ModifierType': 'MODIFIER_CITY_TRAINED_UNITS_ADJUST_GRANT_EXPERIENCE'}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': -1}]
        self.organize(modifier, modifier_args)  # this just gives promo, cant seem to find method for part xp
        return [modifier['ModifierId']]

    def free_xp_global_modifier(self, civ4_target, name):
        modifiers = [{'ModifierId': f"MODIFIER_ALL_CITIES_MILITARY_EXPERIENCE",
                      'ModifierType': 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER'},
                     {'ModifierId': f"MODIFIER_{name}_MILITARY_EXPERIENCE",
                      'ModifierType': 'MODIFIER_CITY_TRAINED_UNITS_ADJUST_GRANT_EXPERIENCE'}]

        modifier_args = [{'ModifierId': modifiers[1]['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': -1},
                         {'ModifierId': modifiers[0]['ModifierId'], 'Name': 'ModifierId', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': modifiers[1]['ModifierId']}]
        self.organize(modifiers, modifier_args)  # this just gives promo, cant seem to find method for part xp
        return [i['ModifierId'] for i in modifiers]

    def free_xp_modifier_promo_class_specific(self, civ4_target, name):
        target_name = civ4_target['DomainFreeExperience']['DomainType']
        modifier = {'ModifierId': f"MODIFIER_MILITARY_EXPERIENCE_PROMO_{target_name}",
                    'ModifierType': 'MODIFIER_CITY_TRAINED_UNITS_ADJUST_GRANT_EXPERIENCE',
                    'SubjectRequirementSetId': 'REQUIREMENT_UNIT_IS_RANGED'}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': -1}]

        requirements = {'RequirementId': f'REQUIREMENT_UNIT_{target_name}',
                        'RequirementType': 'REQUIREMENT_UNIT_PROMOTION_CLASS_MATCHES', 'ProgressWeight': '1'}

        requirements_arguments = {'RequirementId': requirements['RequirementId'], 'Name': 'UnitPromotionClass',
                                  'Type': 'ARGTYPE_IDENTITY', 'Value': f'PROMOTION_CLASS_{target_name}'}

        requirements_set = {'RequirementSetId': f'{name}_UNIT_REQUIREMENTS',
                            'RequirementSetType': 'REQUIREMENTSET_TEST_ALL'}

        requirement_set_requirements = {'RequirementSetId': requirements_set['RequirementSetId'],
                                        'RequirementId': requirements['RequirementId']}

        self.organize(modifier, modifier_args, requirements=[requirements],
                      requirements_arguments=[requirements_arguments],
                      requirements_set=[requirements_set], requirements_set_reqs=[requirement_set_requirements])
        return [modifier['ModifierId']]

    def slave_taking_modifier(self, civ4_target, name):
        modifiers = [{'ModifierId': f"MODIFIER_{name}_SLAVE_TAKING_MODIFIER",
                      'ModifierType': 'MODIFIER_UNIT_ADJUST_COMBAT_UNIT_CAPTURE'},
                     {'ModifierId': f"MODIFIER_{name}_SLAVE_TAKING",
                      'ModifierType': 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER'}]
        modifier_args = [{'ModifierId': modifiers[0]['ModifierId'], 'Name': 'CanCapture', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': 1},
                         {'ModifierId': modifiers[0]['ModifierId'], 'Name': 'UnitType',
                          'Type': 'ARGTYPE_IDENTITY', 'Value': 'UNIT_SLAVE'},
                         {'ModifierId': modifiers[1]['ModifierId'], 'Name': 'ModifierId',
                          'Type': 'ARGTYPE_IDENTITY', 'Value': modifiers[0]['ModifierId']}]

        self.organize(modifiers, modifier_args)
        # do i need this?, also maybe need to alter probability of slave taking
        """MY_TABLE(UnitAbilityType, Name, Description, Inactive, ShowFloatTextWhenEarned, Permanent)
        VALUES('ABILITY_GENGHIS_KHAN_CAVALRY_CAPTURE_CAVALRY', 'LOC_ABILITY_GENGHIS_KHAN_CAVALRY_CAPTURE_CAVALRY_NAME',
               'LOC_ABILITY_GENGHIS_KHAN_CAVALRY_CAPTURE_CAVALRY_DESCRIPTION', '1', '0', '1');"""

        return [modifiers[1]['ModifierId']]

    def builder_charge_modifier(self, civ4_target, name):
        # closest thing to worker speed modifier
        modifier = {'ModifierId': f"MODIFIER_{name}_BUILD_CHARGES",
                    'ModifierType': 'MODIFIER_PLAYER_TRAINED_UNITS_ADJUST_BUILDER_CHARGES', 'Permanent': '1',
                    'SubjectRequirementSetId': 'UNIT_IS_BUILDER'}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': 2}]  # hardcoded value at the moment, unless we see other instances
        self.organize(modifier, modifier_args)
        return [modifier['ModifierId']]

    def housing_modifier(self, civ4_target, name):
        modifier = {'ModifierId': f"MODIFIER_{name}_ADJUST_HOUSING",
                    'ModifierType': 'MODIFIER_PLAYER_CITIES_ADJUST_POLICY_HOUSING'}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target}]  # hardcoded value at the moment, unless we see other instances
        self.organize(modifier, modifier_args)
        return [modifier['ModifierId']]

    def no_foreign_trade(self, civ4_target, name):
        # cant ban them, can set them to 0
        modifier = {'ModifierId': f"MODIFIER_{name}_FOREIGN_TRADE_SET_TO_ZERO",
                    'ModifierType': 'MODIFIER_PLAYER_ADJUST_INTERNATIONAL_TRADE_ROUTE_YIELD_MODIFIER_WARLORDS'}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'YieldType', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': 'YIELD_PRODUCTION, YIELD_FOOD, YIELD_SCIENCE, YIELD_CULTURE, YIELD_GOLD, YIELD_FAITH'},
                         {'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': '-100, -100, -100, -100, -100, -100'}]
        self.organize(modifier, modifier_args)
        return [modifier['ModifierId']]

    def trade_route_count_modifier(self, civ4_target, name):
        modifier = {'ModifierId': f"MODIFIER_{name}_ADJUST_TRADE_ROUTE_CAPACITY",
                    'ModifierType': 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY'}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target}]  # hardcoded value at the moment, unless we see other instances
        self.organize(modifier, modifier_args)
        return [modifier['ModifierId']]

    def trade_route_count_sea_modifier(self, civ4_target, name):
        # Since Civ4 just gives you trade routes per city, and this gives extra trade routes on coastal cities
        # We can implement it, but it will kinda be op
        # A modifier that applies a modifer to all cities in our civ, with requirement the city is coastal
        # That modifier adds a trade route

        modifiers = [{'ModifierId': f"MODIFIER_{name}_ADJUST_TRADE_ROUTE_CAPACITY_COASTAL_PER_CITY",
                      'ModifierType': 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY',
                      'SubjectRequirementSetId': 'PLOT_IS_ADJACENT_TO_COAST'},
                     {'ModifierId': f"MODIFIER_{name}_ADJUST_TRADE_ROUTE_CAPACITY_COASTAL",
                      'ModifierType': 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER'}]
        modifier_args = [{'ModifierId': modifiers[0]['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target},
                         {'ModifierId': modifiers[1]['ModifierId'], 'Name': 'ModifierId', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': modifiers[0]['ModifierId']}]
        self.organize(modifiers, modifier_args)
        return [modifiers[1]['ModifierId']]

    def trade_route_yield_modifier(self, civ4_target, name):
        trade_route_modifier = 'MODIFIER_CITY_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL'
        dynamic_modifier = {'ModifierType': trade_route_modifier, 'CollectionType': 'COLLECTION_OWNER',
                            'EffectType': 'EFFECT_ADJUST_CITY_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL'}
        modifier = {'ModifierId': f"MODIFIER_{name}_TRADE_ROUTE_YIELD_MULT",
                    'ModifierType': 'trade_route_modifier'}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'YieldType', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': 'YIELD_PRODUCTION, YIELD_FOOD, YIELD_SCIENCE, YIELD_CULTURE, YIELD_GOLD, YIELD_FAITH'},
                         {'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': f'{civ4_target}, {civ4_target}, {civ4_target}, {civ4_target}, {civ4_target},'
                                   f' {civ4_target}'}]
        self.organize(modifier, modifier_args, dynamic_modifier=dynamic_modifier)
        return [modifier['ModifierId']]

    def global_amenities_modifier(self, civ4_target, name):
        dynamic_modifier = {'ModifierType': 'MODIFIER_ALL_CITY_ADJUST_ENTERTAINMENT',
                            'CollectionType': 'COLLECTION_PLAYER_CITIES',
                            'EffectType': 'EFFECT_ADJUST_CITY_ENTERTAINMENT'}
        modifiers, modifier_args = [], []
        modifier = {'ModifierId': f"MODIFIER_{name}_ADD_AMENITIES",
                    'ModifierType': dynamic_modifier['ModifierType']}
        modifiers.append(modifier)
        modifier_args.append({'ModifierId': modifier['ModifierId'], 'Name': name, 'Type': 'ARGTYPE_IDENTITY',
                              'Value': civ4_target})
        self.organize(modifiers, modifier_args)

        return [i['ModifierId'] for i in modifiers]

    def global_housing_modifier(self, civ4_target, name):
        modifier = {'ModifierId': f"MODIFIER_{name}_ADJUST_HOUSING",
                    'ModifierType': 'MODIFIER_PLAYER_CITIES_ADJUST_POLICY_HOUSING'}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target}]  # hardcoded value at the moment, unless we see other instances
        self.organize(modifier, modifier_args)
        return [modifier['ModifierId']]

    def free_bonus_modifier(self, civ4_target, name):
        modifier = {'ModifierId': f"MODIFIER_{name}_GRANT_{civ4_target['FreeBonus'][6:]}",
                    'ModifierType': 'MODIFIER_SINGLE_CITY_GRANT_RESOURCE_IN_CITY'}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target['iNumFreeBonuses']},
                         {'ModifierId': modifier['ModifierId'], 'Name': 'ResourceType', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target['FreeBonus']}]
        self.organize(modifier, modifier_args)
        return [modifier['ModifierId']]

    def free_building_modifier(self, civ4_target, name):
        # gives free building in all cities
        modifiers = [{'ModifierId': f"MODIFIER_ALL_CITIES_FREE_{name}",
                      'ModifierType': 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER'},
                     {'ModifierId': f"MODIFIER_FREE_{name}",
                      'ModifierType': 'MODIFIER_SINGLE_CITY_GRANT_BUILDING_IN_CITY_IGNORE',
                      'RunOnce': 1,
                      'Permanent': 1}]

        modifier_args = [{'ModifierId': modifiers[0]['ModifierId'], 'Name': 'ModifierId', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': modifiers[1]['ModifierId']},
                         {'ModifierId': modifiers[1]['ModifierId'], 'Name': 'BuildingType', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target}]
        self.organize(modifiers, modifier_args)
        return [i['ModifierId'] for i in modifiers]

    def project_prod_mult_modifier(self, civ4_target, name):
        modifier = {'ModifierId': f"MODIFIER_{name}_PROJECT_PROD_MULT",
                    'ModifierType': 'MODIFIER_PLAYER_CITIES_ADJUST_ALL_PROJECTS_PRODUCTION'}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target}]
        self.organize(modifier, modifier_args)
        return [modifier['ModifierId']]

    def yield_modifier(self, civ4_target, name):
        return self.commerce_modifier(civ4_target, name, mapper=yield_map,
                                      modifier_type='MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER')

    def plot_yield_modifier(self, civ4_target, name, modifier_type='MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',
                            requirement='PLOT_HAS_COAST_REQUIREMENTS'):
        yield_changes = civ4_target['iYield']
        modifiers, modifier_args = [], []
        for idx, amount in enumerate(yield_changes):
            if int(amount) != 0:
                modifier = {'ModifierId': f"MODIFIER_{name}_PLOT_YIELD_CHANGE_{yield_map[idx][6:]}",
                            'ModifierType': modifier_type,
                            'SubjectRequirementSetId': requirement}
                modifiers.append(modifier)
                modifier_args.extend([{'ModifierId': modifier['ModifierId'], 'Name': 'YieldType', 'Type': 'ARGTYPE_IDENTITY',
                                  'Value': yield_map[idx]},
                                 {'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                                  'Value': amount}])
        self.organize(modifiers, modifier_args)
        return modifiers

    def plot_yield_modifier_global(self, civ4_target, name, ):
        return self.plot_yield_modifier(civ4_target, name, modifier_type='MODIFIER_PLAYER_ADJUST_PLOT_YIELD')

    def prod_modifier_class_specific(self, civ4_target, name):
        domain = civ4_target['DomainProductionModifier']['DomainType']
        modifier = {'ModifierId': f"MODIFIER_{name}_{domain}_PROD_MULT",
                    'ModifierType': 'MODIFIER_CITY_ADJUST_UNIT_DOMAIN_PRODUCTION'}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'Domain', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': domain},
                         {'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target['DomainProductionModifier']['iProductionModifier']}]
        self.organize(modifier, modifier_args)
        return [modifier['ModifierId']]

    def free_tech_grant(self, civ4_target, name):
        modifier = {'ModifierId': f"MODIFIER_{name}_FREE_TECH",
                    'ModifierType': 'MODIFIER_PLAYER_GRANT_RANDOM_TECHNOLOGY',
                    'RunOnce': 1, 'Permanent': 1}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target}]
        self.organize(modifier, modifier_args)
        return [modifier['ModifierId']]

    def spec_build(self, civ4_target, name):
        print('chs')

    def bonus_requirementImplementation(self, civ4_target, name):
        print(f"{name}'s {civ4_target} not implemented")
        print('If we have apply a modifier to the city, with secondary requirement that we have x resource')

    def apply_to_unit_if_in_cityImplement(self, civ4_target, name):
        modifier = {'ModifierId': 'MEDIC_INCREASE_HEAL_RATE',
                    'ModifierType': 'MODIFIER_PLAYER_UNITS_ADJUST_HEAL_PER_TURN',
                    'SubjectRequirementSetId': 'MEDIC_HEALING_REQUIREMENTS'}
        requirement_set = {'RequirementSetId': 'MEDIC_HEALING_REQUIREMENTS',
                           'RequirementSetType': 'REQUIREMENTSET_TEST_ALL'}
        requirement_set_requirements = {'RequirementSetId': 'MEDIC_HEALING_REQUIREMENTS',
                                        'RequirementId': 'ADJACENT_UNIT_REQUIREMENT'}
        print(f"{name} with {civ4_target} seems possible, but awkward")

    def feature_happiness_modifier(self, civ4_target, name):
        print(f"{name}'s {civ4_target} not implemented")

    def specialistImplement(self, civ4_target, name):
        print(f"{name}'s {civ4_target} not implemented")
        # for idx, amount in enumerate(civ4_target['iCommerce']):
        # if int(amount) != 0:
        # yieldtype = commerce_map[idx]

        # specialist_classes = civ4_target['SpecialistValid']
        # for i in specialist_classes:
        #    district = map_specialists[i['SpecialistType']]
        # modifier = {'ModifierId': f"MODIFIER_{name}_UNLIMITED_SPECIALIST_{district}",
        #            'ModifierType': 'ISSUE_IS_NO_ADJUST_DISTRICT/BUILDING/CITY_CITIZEN_SLOTS'}
        # map_citizen_slot to district. Make player that district have 94 CitizenSlots

    def no_fucking_clue(self, civ4_target, name):
        print(f"{name}'s {civ4_target} not implemented, who knows")

    def magicImplement(self, civ4_target, name):
        print(f"{name}'s {civ4_target} not implemented as needs Magic module")

    def maintenanceImplement(self, civ4_target, name):
        print(f"{name}'s {civ4_target} not implemented as needs Maintenance Rework")

    def religionImplement(self, civ4_target, name):
        print(f"{name}'s {civ4_target} not implemented as needs Religion Rework")

    def alignmentImplement(self, civ4_target, name):
        print(f"{name}'s {civ4_target} not implemented as needs Alignment Rework")

    def otherSystemImplement(self, civ4_target, name):
        print(f"{name}'s {civ4_target} not implemented as needs some other thing")
        # Stuck on SpecialistValids, iLargestCityHappiness as no concept of largest cities in civ,
        # bNoDiplomacyWithEnemies, bPrereqWar

    def prereqImplement(self, civ4_target, name):
        print(f"{name}'s {civ4_target} not implemented as it is a prerequisite, how can we apply this to a policy")

    def cantImplement(self, civ4_target, name):
        print(f"{name}'s {civ4_target} not implemented as it is a concept too far outside of civ vi")
        # half food requirements GlobalParameters (Name: 'CITY_FOOD_CONSUMPTION_PER_POPULATION', "Value": '2.0')

    def organize(self, modifier, modifier_arguments, dynamic_modifier=None, trait_modifiers=None, trait=None,
                 requirements=None, requirements_arguments=None, requirements_set=None, requirements_set_reqs=None):
        modifiers = modifier
        if isinstance(modifier, list):
            for mod in modifier:
                self.modifiers[mod['ModifierId']] = mod
            modifier = modifier[0]

        self.complete_set[modifier['ModifierId']] = [modifiers, modifier_arguments, dynamic_modifier, trait_modifiers,
                                                     trait, requirements, requirements_arguments, requirements_set]

        self.modifiers[modifier['ModifierId']] = modifier
        self.modifier_arguments.extend(modifier_arguments)
        if dynamic_modifier:
            self.dynamic_modifiers[dynamic_modifier['ModifierType']] = dynamic_modifier
        if trait_modifiers:
            self.trait_modifiers.extend(trait_modifiers)
        if requirements:
            for requirement in requirements:
                self.requirements[requirement['RequirementId']] = requirement
        if requirements_arguments:
            self.requirements_arguments.extend(requirements_arguments)
        if requirements_set:
            self.requirement_set.extend(requirements_set)
        if requirements_set_reqs:
            self.requirement_set_reqs.extend(requirements_set_reqs)

    def generate_modifier(self, civ4_target, name, civ6_target):
        modifier_id = self.modifier_map[name](civ4_target, civ6_target)
        return modifier_id

    def big_get(self):
        modifier_string = ''
        for i in [(self.modifier_arguments, 'ModifierArguments'),
                  (self.modifiers, 'Modifiers'),
                  (self.dynamic_modifiers, 'DynamicModifiers'),
                  (self.requirements, 'Requirements'),
                  (self.requirement_set, 'RequirementSets'),
                  (self.requirement_set_reqs, 'RequirementSetRequirements'),
                  (self.requirements_arguments, 'RequirementArguments')]:

            if isinstance(i[0], dict):
                unique_tuples = set(tuple(sorted(d.items())) for d in i[0].values())
                unique_dicts = {key: dict(t) for key, t in zip(i[0].keys(), unique_tuples)}
            else:
                tuples = [(tuple(sorted(d.items()))) for d in i[0]]
                problem_tuples = [i for i in tuples if any([any([isinstance(k, dict) for k in j]) for j in i])]
                unique_tuples = set(tuple(sorted(d.items())) for d in i[0])
                unique_dicts = [dict(t) for t in unique_tuples]
            modifier_string += build_sql_table(unique_dicts, i[1])
        return modifier_string
