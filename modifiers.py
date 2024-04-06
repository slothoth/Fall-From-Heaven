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
        self.trait_modifiers = []

        self.requirements = {}
        self.requirement_arguments = []
        self.requirement_set_reqs = []
        self.requirement_set = []

        self.complete_set = {}

        modifier_map = {'CapitalCommerceModifiers': self.capital_commerce_modifier,
                        'CapitalYieldModifiers': self.capital_yield_modifier,        # dummy
                        'iWarWearinessModifier': self.war_weariness_modifier,
                        'CommerceModifiers': self.commerce_modifier,
                        'ImprovementYieldChanges': self.improvement_yield_modifier,
                        'SpecialistValids': self.unlimited_specialists_modifier,
                        'SpecialistExtraCommerces': self.specialist_yield_modifier,
                        'iGreatPeopleRateModifier': self.gpp_rate_modifier,
                        'iCivicPercentAnger': self.no_fucking_clue,
                        'iExtraHealth': self.housing_modifier,
                        'iHappyPerMilitaryUnit': self.no_fucking_clue,
                        'BuildingHappinessChanges': self.buildings_amenities_modifier,
                        'iMilitaryProductionModifier': self.military_prod_modifier,
                        'iFoodConsumptionPerPopulation': self.food_use_modifier,
                        'iFreeExperience': self.free_xp_modifier,
                        'iEnslavementChance': self.slave_taking_modifier,
                        'iWorkerSpeedModifier': self.builder_charge_modifier,
                        'bMilitaryFoodProduction': self.units_made_with_food,
                        'bNoForeignTrade': self.no_foreign_trade,
                        'iTradeRoutes': self.trade_route_count_modifier,
                        'iCoastalTradeRoutes': self.trade_route_count_sea_modifier,
                        'FeatureHappinessChanges': self.feature_happiness_modifier}

    def capital_commerce_modifier(self, civ4_target, name):
        self.commerce_modifier(civ4_target, name,
                               modifier_type='MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_YIELD_MODIFIER')

    def capital_yield_modifier(self, civ4_target, name):
        self.commerce_modifier(civ4_target, name, mapper=yield_map,
                               modifier_type='MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_YIELD_MODIFIER')

    def war_weariness_modifier(self, civ4_target, name):
        modifier = {'ModifierId': f"MODIFIER_{name}_ADJUST_WAR_WEARINESS",
                    'ModifierType': 'MODIFIER_PLAYER_ADJUST_WAR_WEARINESS'}
        modifier_args = []
        for name, value in zip([('Amount', civ4_target), ('Overall', 1)]):
            modifier_args.append({'ModifierId': modifier['ModifierId'], 'Name': name, 'Type': 'ARGTYPE_IDENTITY',
                                  'Value': value})
        self.organize(modifier, modifier_args)

    def commerce_modifier(self, civ4_target, name, mapper=None, modifier_type='MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER'):
        if mapper is None:
            mapper = commerce_map
        for idx, amount in enumerate(civ4_target):
            if int(amount) != 0:
                modifier = {'ModifierId': f"MODIFIER_{name[14:]}_ADD_{mapper[idx][6:]}YIELD",
                            'ModifierType': modifier_type}
                modifier_args = []
                for name, value in zip([('Amount', amount), ('YieldType', mapper[idx])]):
                    modifier_args.append(
                        {'ModifierId': modifier['ModifierId'], 'Name': name, 'Type': 'ARGTYPE_IDENTITY',
                         'Value': value})
                self.organize(modifier, modifier_args)

    def improvement_yield_modifier(self, civ4_target, name):
        improvement = name[12:]
        for idx, amount in enumerate(civ4_target):
            if int(amount) != 0:
                modifier = {'ModifierId': f"MODIFIER_{name}_{improvement}_{yield_map[idx][6:]}",
                            'ModifierType': 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',
                            'SubjectRequirementSetId': f'PLOT_HAS_{improvement}_REQUIREMENTS'}
                modifier_args = []
                for name, value in zip([('Amount', amount), ('YieldType', yield_map[idx])]):
                    modifier_args.append(
                        {'ModifierId': modifier['ModifierId'], 'Name': name, 'Type': 'ARGTYPE_IDENTITY',
                         'Value': value})
                self.organize(modifier, modifier_args)

    def gpp_rate_modifier(self, civ4_target, name):
        modifier = {'ModifierId':  f"MODIFIER_{name[14:]}_INCREASE_GPP_MULT",
                    'ModifierType': 'MODIFIER_PLAYER_CITIES_ADJUST_GREAT_PERSON_POINT_BONUS'}

        modifier_args = {'ModifierId': modifier['ModifierId'], 'Name': name, 'Type': 'ARGTYPE_IDENTITY',
                         'Value': civ4_target['value']}
        self.organize(modifier, modifier_args)

    def buildings_amenities_modifier(self, civ4_target, name):
        buildings = civ4_target['BuildingHappinessChanges']['BuildingHappinessChange']
        for building, amount in buildings:
            building = building.replace('BUILDINGCLASS', 'BUILDING')
            modifier = {'ModifierId': f"MODIFIER_{name}_{building}_ADD_AMENITIES",
                        'ModifierType': 'MODIFIER_SINGLE_CITY_ADJUST_ENTERTAINMENT',
                        'SubjectRequirementSetId': f'REQUIRES_CITY_HAS_{building}'}
            modifier_args = {'ModifierId': modifier['ModifierId'], 'Name': name, 'Type': 'ARGTYPE_IDENTITY',
                            'Value': amount}
            requirements = {'RequirementId': f'REQUIRES_CITY_HAS_{building}',
                            'RequirementType': 'REQUIREMENT_CITY_HAS_BUILDING'}
            requirement_arguments = {'RequirementId': requirements['RequirementId'], 'Name': 'BuildingType',
                                     'Type': 'ARGTYPE_IDENTITY', 'Value': building}
            self.organize(modifier, modifier_args, requirements, requirement_arguments)

        """RequirementSetRequirements(RequirementSetId, RequirementId)
                VALUES('BUILDING_IS_FACTORY', 'REQUIRES_CITY_HAS_FACTORY');"""

    def military_prod_modifier(self, civ4_target, name):
        modifier = {'ModifierId': f"MODIFIER_{name}_MILITARY_PRODUCTION",
                    'ModifierType': 'MODIFIER_PLAYER_CITIES_ADJUST_MILITARY_UNITS_PRODUCTION'}
        modifier_args = {'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                         'Value': civ4_target['value']}
        self.organize(modifier, modifier_args)

    def free_xp_modifier(self, civ4_target, name):
        print('cgd')

    def slave_taking_modifier(self, civ4_target, name):
        print('dsc')

    def builder_charge_modifier(self, civ4_target, name):
        print(name)

    def housing_modifier(self, civ4_target, name):
        print(name)

    def units_made_with_food(self, civ4_target, name):
        print(name)

    def no_foreign_trade(self, civ4_target, name):
        print(name)

    def trade_route_count_modifier(self, civ4_target, name):
        print(name)

    def trade_route_count_sea_modifier(self, civ4_target, name):
        print(name)


    def feature_happiness_modifier(self, civ4_target, name):
        print(name)

    def unlimited_specialists_modifier(self, civ4_target, name):
        specialist_classes = civ4_target['SpecialistValids']['SpecialistValid']
        for i in specialist_classes:
            district = map_specialists[i['SpecialistType']]
        modifier = {'ModifierId': f"MODIFIER_{name}_UNLIMITED_SPECIALIST_{district}",
                    'ModifierType': 'ISSUE_IS_NO_ADJUST_DISTRICT/BUILDING/CITY_CITIZEN_SLOTS'}
        # map_citizen_slot to district. Make player that district have 94 CitizenSlots

    def specialist_yield_modifier(self, civ4_target, name):
        district = map_specialists[civ4_target['specialist']]
        print('chs')

    def no_fucking_clue(self):
        print('didnt do it')

    def food_use_modifier(self, civ4_target, name):
        # GlobalParameters (Name: 'CITY_FOOD_CONSUMPTION_PER_POPULATION', "Value": '2.0')

    """{'CIVIC_DESPOTISM': {'Upkeep': 'UPKEEP_LOW', 'iNumCitiesMaintenanceModifier': '25', 'iWarWearinessModifier': '-50'},
     'CIVIC_CITY_STATES': {'Upkeep': 'UPKEEP_LOW', 'iDistanceMaintenanceModifier': '-80', 'iNumCitiesMaintenanceModifier': '-25', 'iWarWearinessModifier': '25', 'CommerceModifiers': {'iCommerce': ['0', '0', '-20']}},
      'CIVIC_GOD_KING': {'Upkeep': 'UPKEEP_HIGH', 'iDistanceMaintenanceModifier': '10', 'CapitalYieldModifiers': {'iYield': ['0', '50', '0']}, 'CapitalCommerceModifiers': {'iCommerce': ['50', '0', '0']}},
       'CIVIC_ARISTOCRACY': {'Upkeep': 'UPKEEP_LOW', 'iDistanceMaintenanceModifier': '-40', 'ImprovementYieldChanges': {'ImprovementYieldChange': {'ImprovementType': 'IMPROVEMENT_FARM', 'ImprovementYields': {'iYield': ['-1', '0', '2']}}}}, 
       'CIVIC_THEOCRACY': {'Upkeep': 'UPKEEP_MEDIUM', 'bNoNonStateReligionSpread': '1', 'iStateReligionHappiness': '1', 'iStateReligionFreeExperience': '2', 'SpecialistValids': {'SpecialistValid': {'SpecialistType': 'SPECIALIST_PRIEST', 'bValid': '1'}}},
        'CIVIC_REPUBLIC': {'Upkeep': 'UPKEEP_MEDIUM', 'iGreatPeopleRateModifier': '25', 'iLargestCityHappiness': '3', 'iCivicPercentAnger': '200', 'CommerceModifiers': {'iCommerce': ['0', '0', '20']}}, 
        'CIVIC_RELIGION': {'Upkeep': 'UPKEEP_LOW', 'bStateReligion': '1', 'iStateReligionHappiness': '1', 'CommerceModifiers': {'iCommerce': ['0', '0', '10']}, 'BuildingHappinessChanges': {'BuildingHappinessChange': [{'BuildingType': 'BUILDINGCLASS_TEMPLE_OF_KILMORPH', 'iHappinessChange': '1'}, {'BuildingType': 'BUILDINGCLASS_TEMPLE_OF_LEAVES', 'iHappinessChange': '1'}, {'BuildingType': 'BUILDINGCLASS_TEMPLE_OF_THE_ORDER', 'iHappinessChange': '1'}, {'BuildingType': 'BUILDINGCLASS_TEMPLE_OF_THE_OVERLORDS', 'iHappinessChange': '1'}, {'BuildingType': 'BUILDINGCLASS_TEMPLE_OF_THE_VEIL', 'iHappinessChange': '1'}, {'BuildingType': 'BUILDINGCLASS_TEMPLE_OF_THE_EMPYREAN', 'iHappinessChange': '1'}]}}, 
        'CIVIC_PACIFISM': {'Upkeep': 'UPKEEP_LOW', 'iGreatPeopleRateModifier': '50', 'iMilitaryProductionModifier': '-20', 'iWarWearinessModifier': '25', 'bStateReligion': '1'}, 
        'CIVIC_NATIONHOOD': {'Upkeep': 'UPKEEP_LOW', 'iMilitaryProductionModifier': '10', 'iWarWearinessModifier': '-25', 'bStateReligion': '1', 'BuildingHappinessChanges': {'BuildingHappinessChange': {'BuildingType': 'BUILDINGCLASS_TRAINING_YARD', 'iHappinessChange': '1'}}},
         'CIVIC_SACRIFICE_THE_WEAK': {'iGreatPeopleRateModifier': '-20', 'iExtraHealth': '-4', 'bStateReligion': '1', 'CommerceModifiers': {'iCommerce': ['10', '0', '0']}, 'iFoodConsumptionPerPopulation': '1', 'PrereqReligion': 'RELIGION_THE_ASHEN_VEIL'}, 
         'CIVIC_SOCIAL_ORDER': {'Upkeep': 'UPKEEP_LOW', 'iHappyPerMilitaryUnit': '1', 'bStateReligion': '1', 'BuildingHappinessChanges': {'BuildingHappinessChange': [{'BuildingType': 'BUILDINGCLASS_COURTHOUSE', 'iHappinessChange': '1'}, {'BuildingType': 'BUILDINGCLASS_BASILICA', 'iHappinessChange': '1'}]}, 'PrereqReligion': 'RELIGION_THE_ORDER'},
          'CIVIC_CONSUMPTION': {'Upkeep': 'UPKEEP_MEDIUM', 'bStateReligion': '1', 'CommerceModifiers': {'iCommerce': ['20', '0', '0']}, 'BuildingHappinessChanges': {'BuildingHappinessChange': [{'BuildingType': 'BUILDINGCLASS_MARKET', 'iHappinessChange': '1'}, {'BuildingType': 'BUILDINGCLASS_TAVERN', 'iHappinessChange': '1'}, {'BuildingType': 'BUILDINGCLASS_THEATRE', 'iHappinessChange': '1'}]}},
           'CIVIC_SCHOLARSHIP': {'Upkeep': 'UPKEEP_HIGH', 'iWarWearinessModifier': '20', 'bStateReligion': '1', 'CommerceModifiers': {'iCommerce': ['0', '10', '0']}, 'SpecialistExtraCommerces': {'iCommerce': ['0', '1', '0']}, 'SpecialistValids': {'SpecialistValid': {'SpecialistType': 'SPECIALIST_SCIENTIST', 'bValid': '1'}}, 'BuildingHappinessChanges': {'BuildingHappinessChange': {'BuildingType': 'BUILDINGCLASS_LIBRARY', 'iHappinessChange': '1'}}},
            'CIVIC_LIBERTY': {'Upkeep': 'UPKEEP_MEDIUM', 'iWarWearinessModifier': '50', 'iFreeSpecialist': '1', 'bStateReligion': '1', 'CommerceModifiers': {'iCommerce': ['0', '0', '100']}, 'SpecialistValids': {'SpecialistValid': {'SpecialistType': 'SPECIALIST_ARTIST', 'bValid': '1'}}},
             'CIVIC_CRUSADE': {'Upkeep': 'UPKEEP_MEDIUM', 'iFreeUnitsPopulationPercent': '50', 'iWarWearinessModifier': '-75', 'bStateReligion': '1', 'iStateReligionHappiness': '2', 'iStateReligionUnitProductionModifier': '25', 'bNoDiplomacyWithEnemies': '1', 'bPrereqWar': '1', 'PrereqCivilization': 'CIVILIZATION_BANNOR'},
              'CIVIC_TRIBALISM': {'Upkeep': 'UPKEEP_LOW'},
               'CIVIC_APPRENTICESHIP': {'Upkeep': 'UPKEEP_LOW', 'iFreeExperience': '2', 'iMilitaryProductionModifier': '-10'},
                'CIVIC_SLAVERY': {'Upkeep': 'UPKEEP_LOW', 'Hurrys': {'Hurry': {'HurryType': 'HURRY_POPULATION', 'bHurry': '1'}}, 'ImprovementYieldChanges': {'ImprovementYieldChange': {'ImprovementType': 'IMPROVEMENT_QUARRY', 'ImprovementYields': {'iYield': ['0', '1', '0']}}}, 'iEnslavementChance': '25', 'BlockAlignment': 'ALIGNMENT_GOOD'},
                 'CIVIC_ARETE': {'Upkeep': 'UPKEEP_MEDIUM', 'iStateReligionGreatPeopleRateModifier': '20', 'Hurrys': {'Hurry': {'HurryType': 'HURRY_GOLD', 'bHurry': '1'}}, 'ImprovementYieldChanges': {'ImprovementYieldChange': {'ImprovementType': 'IMPROVEMENT_MINE', 'ImprovementYields': {'iYield': ['0', '1', '0']}}}, 'PrereqReligion': 'RELIGION_RUNES_OF_KILMORPH'},
                  'CIVIC_MILITARY_STATE': {'Upkeep': 'UPKEEP_HIGH', 'iMilitaryProductionModifier': '15', 'iFreeUnitsPopulationPercent': '20', 'iMaxConscript': '3', 'CommerceModifiers': {'iCommerce': ['0', '0', '-25']}, 'Hurrys': {'Hurry': {'HurryType': 'HURRY_GOLD', 'bHurry': '1'}}},
                   'CIVIC_CASTE_SYSTEM': {'Upkeep': 'UPKEEP_MEDIUM', 'iWorkerSpeedModifier': '50', 'iLargestCityHappiness': '-1', 'SpecialistExtraCommerces': {'iCommerce': ['0', '1', '2']}, 'Hurrys': {'Hurry': {'HurryType': 'HURRY_GOLD', 'bHurry': '1'}}}, 
                   'CIVIC_GUILDS': {'Upkeep': 'UPKEEP_MEDIUM', 'Hurrys': {'Hurry': {'HurryType': 'HURRY_GOLD', 'bHurry': '1'}}, 'SpecialistValids': {'SpecialistValid': [{'SpecialistType': 'SPECIALIST_ARTIST', 'bValid': '1'}, {'SpecialistType': 'SPECIALIST_ENGINEER', 'bValid': '1'}, {'SpecialistType': 'SPECIALIST_MERCHANT', 'bValid': '1'}, {'SpecialistType': 'SPECIALIST_SCIENTIST', 'bValid': '1'}]}}, 
                   'CIVIC_DECENTRALIZATION': {'Upkeep': 'UPKEEP_LOW'},
                    'CIVIC_AGRARIANISM': {'Upkeep': 'UPKEEP_MEDIUM', 'iExtraHealth': '1', 'ImprovementYieldChanges': {'ImprovementYieldChange': {'ImprovementType': 'IMPROVEMENT_FARM', 'ImprovementYields': {'iYield': ['1', '-1', '0']}}}},
                     'CIVIC_CONQUEST': {'Upkeep': 'UPKEEP_MEDIUM', 'iFreeExperience': '2', 'bMilitaryFoodProduction': '1'},
                    'CIVIC_MERCANTILISM': {'Upkeep': 'UPKEEP_LOW', 'bNoForeignTrade': '1', 'CommerceModifiers': {'iCommerce': ['20', '0', '0']}, 'BuildingHappinessChanges': {'BuildingHappinessChange': {'BuildingType': 'BUILDINGCLASS_MARKET', 'iHappinessChange': '1'}}}, 
                    'CIVIC_FOREIGN_TRADE': {'Upkeep': 'UPKEEP_LOW', 'iTradeRoutes': '1', 'CommerceModifiers': {'iCommerce': ['-10', '0', '20']}, 'iCoastalTradeRoutes': '1'}, 
                    'CIVIC_GUARDIAN_OF_NATURE': {'Upkeep': 'UPKEEP_HIGH', 'iExtraHealth': '5', 'iMilitaryProductionModifier': '-10', 'BuildingHappinessChanges': {'BuildingHappinessChange': {'BuildingType': 'BUILDINGCLASS_GROVE', 'iHappinessChange': '2'}}, 'FeatureHappinessChanges': {'FeatureHappinessChange': [{'FeatureType': 'FEATURE_JUNGLE', 'iHappinessChange': '1'}, {'FeatureType': 'FEATURE_FOREST', 'iHappinessChange': '1'}, {'FeatureType': 'FEATURE_FOREST_ANCIENT', 'iHappinessChange': '1'}]}, 'PrereqReligion': 'RELIGION_FELLOWSHIP_OF_LEAVES'}}"""

    def organize(self, modifier, modifier_arguments, dynamic_modifier=None, trait_modifiers=None, requirements=None, requirements_arguments=None):
        self.complete_set[modifier['ModifierId']] = [modifier, modifier_arguments, dynamic_modifier, trait_modifiers,
                                                     requirements, requirements_arguments]

        self.modifiers[modifier['ModifierId']] = modifier
        self.modifier_arguments.extend(modifier_arguments)
        if dynamic_modifier:
            self.dynamic_modifiers[dynamic_modifier['ModifierType']] = dynamic_modifier
        if trait_modifiers:
            self.trait_modifiers.extend(trait_modifiers)
        if requirements:
            self.requirements[requirements['RequirementId']] = requirements
        if requirements_arguments:
            self.requirements_arguments.extend(requirements_arguments)

    def modifier_master(self, civ4_target):
        run_target = self.modifier_map[civ4_target]
        runtarget()

# ALIGNMENT REWORK: BlockAlignment
# MAINTENANCE_REWORK rework: Upkeep, iNumCitiesMaintenanceModifier, iDistanceMaintenanceModifier, iFreeUnitsPopulationPercent
# RELIGION_REWORK bNoNonStateReligionSpread, iStateReligionHappiness, iStateReligionFreeExperience, iStateReligionUnitProductionModifier, iStateReligionGreatPeopleRateModifier
# Prebuilt Religions: bPrereqReligion
# Stuck on SpecialistValids, iLargestCityHappiness as no concept of largest cities in civ, bNoDiplomacyWithEnemies, bPrereqWar
# Hurry already in base game so... reduce cost? For slaveey it supposed to cost pops too, iMaxConscript

"""def upkeep_modifier(self, civ4_target, name, value):
            modifier = {'ModifierId': f"MODIFIER_{name}_ADJUST_WAR_WEARINESS",
                        'ModifierType': ''}
            modifier_args = []
            for name, value in zip([('Amount', value), ('Overall', 1)]):
                modifier_args.append({'ModifierId': modifier['ModifierId'], 'Name': name, 'Type': 'ARGTYPE_IDENTITY',
                                      'Value': value})
            self.organize(modifier, modifier_args)"""
