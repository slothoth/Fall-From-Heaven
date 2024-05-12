from utils import make_or_add
from promotion_modifiers import PromotionModifiers
import logging
import os

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
        self.logger = logging.getLogger(__name__)
        self.promotion_modifiers = PromotionModifiers(self)
        self.civic_map = {}

        self.modifiers = {}
        self.dynamic_modifiers = {}
        self.modifier_arguments = []
        self.traits = {}
        self.trait_modifiers = []

        self.requirements = {}
        self.requirements_arguments = []
        self.requirement_set_reqs = []
        self.requirement_set = []

        self.abilities = {}
        self.ability_modifiers = []
        self.tags = {}
        self.type_tags = []

        self.complete_set = {}
        self.loc = {}
        self.mod_string = []

        self.count = 0
        self.not_implemented_count = 0

        self.modifier_map = {'CommerceModifiers': self.commerce_modifier,
                             'CapitalCommerceModifiers': self.capital_commerce_modifier,
                             'CapitalYieldModifiers': self.capital_yield_modifier,  # dummy
                             'YieldModifiers': self.yield_modifier_city,
                             'CommerceModifiers_City': self.commerce_modifier_city,
                             'iWarWearinessModifier': self.war_weariness_modifier,
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
                             'SeaPlotYieldChanges': self.plot_yield_modifier,
                             'GlobalSeaPlotYieldChanges': self.plot_yield_modifier_global,
                             'iTradeRouteModifier': self.trade_route_yield_modifier,
                             'GPP_flat_capital': self.gpp_in_capital,
                             'GPP_mult_capital': self.gpp_mult_in_capital,
                             'SLTH_Improvement_Bonus': self.improvement_bonus_when_worked
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
                           'iGlobalResistEnemyModifier': self.magicImplement,
                           'iGlobalResistModify': self.magicImplement,
                           'BlockAlignment': self.alignmentImplement,
                           'iLargestCityHappiness': self.otherSystemImplement,
                           'bNoDiplomacyWithEnemies': self.otherSystemImplement,
                           'iModifyGlobalCounter': self.otherSystemImplement,  # armageddon/CO2
                           'VictoryPrereq': self.otherSystemImplement,  # New victory type
                           'iFoodConsumptionPerPopulation': self.cantImplement,  # seems hardcoded
                           'Hurrys': self.cantImplement,  # just purchase
                           'iMaxConscript': self.cantImplement,  # units recruitable from city pop
                           'bMilitaryFoodProduction': self.cantImplement,  # food unused, added to prod
                           'iFoodKept': self.cantImplement,  # store food
                           'bUnhappyProduction': self.cantImplement,  # Gives prod equal to amenities required.
                           'bForceTeamVoteEligible': self.cantImplement,  # no way to limit congress
                           'bSeeInvisible': self.cantImplement,  # invis is barely a concept as is
                           'iBombardDefense': self.cantImplement,  # wall strength and wall hp seems same
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
                           'bNoCivicAnger': self.no_fucking_clue,  # WHAT IS civic anger
                           'iHappyPerMilitaryUnit': self.no_fucking_clue,  # cant stack city units, so retainers
                           'RemovePromotion': self.no_fucking_clue,  # implement temp effects first
                           'iAirlift': self.no_fucking_clue,  # airlift hardcoded, needs all airport buildings
                           'SpecialBuildingType': self.no_fucking_clue,
                           'iAreaHappiness': self.no_fucking_clue,  # its continent level modifier...
                           'FeatureHappinessChanges': self.feature_happiness_modifier,
                           'BonusYieldModifiers': self.bonus_requirementImplementation,
                           'BonusHappinessChanges': self.bonus_requirementImplementation,
                           'BonusHealthChanges': self.bonus_requirementImplementation,
                           'BonusProductionBuilding': self.bonus_production_modifier_building
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

        my_own_implemented = {'SLTH_GRANT_SPECIFIC_TECH': self.tech_grant_specific,
                              'SLTH_DEFAULT_RACE': self.promotion_builder,
                              'SLTH_BAN_UNIT': self.ban_unit,
                              'SLTH_PROMOTION': self.promotion_builder,
                              'SLTH_MANA': self.mana_modifier}

        self.modifier_map.update(not_implemented)
        self.modifier_map.update(somewhat_botched)
        self.modifier_map.update(my_own_implemented)

    def generate_modifier(self, civ4_target, name, civ6_target):
        modifier_id = self.modifier_map[name](civ4_target, civ6_target)
        return modifier_id

    def organize(self, modifier=None, modifier_arguments=None, dynamic_modifier=None, trait_modifiers=None, trait=None,
                 requirements=None, requirements_arguments=None, requirements_set=None, requirements_set_reqs=None,
                 ability=None, ability_modifiers=None, tags=None, type_tags=None, loc=None, mod_string=None):
        if isinstance(modifier, list):
            for mod in modifier:
                self.modifiers[mod['ModifierId']] = mod
            modifier = modifier[0]

        if modifier:
            self.modifiers[modifier['ModifierId']] = modifier

        if modifier is None:
            modifier = {'ModifierId': f'empty_mod_{self.count}'}
            self.count += 1

        including_nones = [modifier, modifier_arguments, dynamic_modifier, trait_modifiers,
                                                     trait, requirements, requirements_arguments, requirements_set,
                                                     requirements_set_reqs, tags, type_tags]

        self.complete_set[modifier['ModifierId']] = [i for i in including_nones if i is not None]

        if modifier_arguments:
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
        if ability:
            self.abilities[ability['UnitAbilityType']] = ability
        if ability_modifiers:
            if isinstance(ability_modifiers, list):
                for i in ability_modifiers:
                    self.ability_modifiers.append(i)
            else:
                self.ability_modifiers.append(ability_modifiers)
        if tags:
            self.tags[tags['Tag']] = tags['Vocabulary']
        if type_tags:
            if isinstance(type_tags, list):
                for i in type_tags:
                    self.type_tags.append(i)
            else:
                self.type_tags.append(type_tags)
        if loc:
            if isinstance(loc[0], str):
                if loc[0] in self.loc:
                    for i in loc[1]:
                        self.loc[loc[0]].append(i)
                else:
                    self.loc[loc[0]] = []
                    for i in loc[1]:
                        self.loc[loc[0]].append(i)

            else:
                for loc_ in loc:
                    if loc_[0] in self.loc:
                        for i in loc_[1]:
                            self.loc[loc_[0]].append(i)
                    else:
                        self.loc[loc_[0]] = loc_[1]
        if mod_string:
            if isinstance(mod_string, list):
                for i in mod_string:
                    self.mod_string.append(i)
            else:
                self.mod_string.append(mod_string)

    def sql_convert(self, model_obj):
        for i in [(self.modifier_arguments, 'ModifierArguments'),
                  (self.modifiers, 'Modifiers'),
                  (self.dynamic_modifiers, 'DynamicModifiers'),
                  (self.requirements, 'Requirements'),
                  (self.requirement_set, 'RequirementSets'),
                  (self.requirement_set_reqs, 'RequirementSetRequirements'),
                  (self.requirements_arguments, 'RequirementArguments'),
                  (self.abilities, 'UnitAbilities'),
                  (self.ability_modifiers, 'UnitAbilityModifiers'),
                  (self.type_tags, 'TypeTags'),
                  (self.mod_string, 'ModifierStrings'),]:

            make_or_add(model_obj['sql_inserts'], i[0], i[1])
        for modifier in self.dynamic_modifiers:
            model_obj['kinds'][modifier] = 'KIND_MODIFIER'
        for ability in self.abilities:
            model_obj['kinds'][ability] = 'KIND_ABILITY'
        for tag, vocab in self.tags.items():
            model_obj['tags'][tag] = vocab

        if os.path.exists('data/checklist.md'):
            with open('data/checklist.md', 'r') as file:
                checklist = file.read()
            for i in self.complete_set:
                if i in checklist:
                    continue
                else:
                    checklist += f'\n  - [ ] {i}'
            with open('data/checklist.md', 'w') as file:
                 file.write(checklist)
        else:
            checklist = '\n  - [ ] '.join([i for i in self.complete_set])
            checklist = '  - [ ] ' + checklist
            with open('data/checklist.md', 'w') as file:
                 file.write(checklist)

    def capital_commerce_modifier(self, civ4_target, name):
        return self.commerce_modifier(civ4_target, name,
                                      modifier_type='MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_YIELD_MODIFIER')

    def capital_yield_modifier(self, civ4_target, name):
        return self.commerce_modifier(civ4_target, name, mapper=yield_map,
                                      modifier_type='MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_YIELD_MODIFIER')

    def yield_modifier_city(self, civ4_target, name):
        return self.commerce_modifier(civ4_target, name, mapper=yield_map,
                                      modifier_type='MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER')

    def commerce_modifier_city(self, civ4_target, name):
        return self.commerce_modifier(civ4_target, name,
                                      modifier_type='MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER')

    def war_weariness_modifier(self, civ4_target, name):
        mod_name = f"MODIFIER_{name}_ADJUST_WAR_WEARINESS"
        if mod_name in self.modifiers:
            to_change = [idx for idx, i in enumerate(self.modifier_arguments) if i['ModifierId'] == mod_name
                         and i['Name'] == 'Amount'][0]
            if int(self.modifier_arguments[to_change]['Value']) > int(civ4_target):  # negative is better here
                self.modifier_arguments[to_change]['Value'] = civ4_target
            return [mod_name]
        modifier = {'ModifierId': mod_name,
                    'ModifierType': 'MODIFIER_PLAYER_ADJUST_WAR_WEARINESS'}
        modifier_args = []
        for name_, value in [('Amount', civ4_target), ('Overall', 1)]:
            modifier_args.append({'ModifierId': modifier['ModifierId'], 'Name': name_, 'Type': 'ARGTYPE_IDENTITY',
                                  'Value': value})
        loc = [name, [f'Accumulate {civ4_target}% less war weariness than usual.']]
        self.organize(modifier, modifier_args, loc=loc)
        return [modifier['ModifierId']]

    def commerce_modifier(self, civ4_target, name, mapper=None,
                          modifier_type='MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER'):
        if mapper is None:
            mapper = commerce_map
        if 'PLAYER_CITIES' in modifier_type:
            owner = 'in all Cities'
        elif 'CAPITAL' in modifier_type:
            owner = 'in Capital City'
        elif 'SINGLE_CITY' in modifier_type:
            owner = 'in this City'

        modifiers, modifier_args, loc = [], [], [name, []]
        yield_changes = next(iter(civ4_target.values()))
        for idx, amount in enumerate(yield_changes):
            if int(amount) != 0:
                modifier = {'ModifierId': f"MODIFIER_{name}_ADD_{mapper[idx][6:]}YIELD",
                            'ModifierType': modifier_type}
                modifiers.append(modifier)
                loc[1].append(f'{amount}% [ICON_{mapper[idx][6:].capitalize()}] {mapper[idx][6:].capitalize()} {owner}.')
                for name, value in [('Amount', amount), ('YieldType', mapper[idx])]:
                    modifier_args.append({'ModifierId': modifier['ModifierId'], 'Name': name,
                                          'Type': 'ARGTYPE_IDENTITY', 'Value': value})

        self.organize(modifiers, modifier_args, loc=loc)
        return [i['ModifierId'] for i in modifiers]

    def improvement_yield_modifier(self, civ4_target, name):
        improvement = civ4_target['ImprovementYieldChange']['ImprovementType'][12:]
        modifiers, modifier_args, loc = [], [], [name, []]

        yield_changes = civ4_target['ImprovementYieldChange']['ImprovementYields']['iYield']
        for idx, amount in enumerate(yield_changes):
            if int(amount) != 0:
                modifier = {'ModifierId': f"MODIFIER_{name}_{improvement}_{yield_map[idx][6:]}",
                            'ModifierType': 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',
                            'SubjectRequirementSetId': f'PLOT_HAS_{improvement}_REQUIREMENTS'}
                modifiers.append(modifier)
                loc[1].append(f'+{amount} [ICON_{yield_map[idx][6:].capitalize()}] {yield_map[idx][6:].capitalize()} for each {improvement}.')
                for name, value in [('Amount', amount), ('YieldType', yield_map[idx])]:
                    modifier_args.append({'ModifierId': modifier['ModifierId'], 'Name': name,
                                          'Type': 'ARGTYPE_IDENTITY', 'Value': value})

        self.organize(modifiers, modifier_args, loc=loc)
        return [i['ModifierId'] for i in modifiers]

    def gpp_rate_modifier(self, civ4_target, name):
        my_name = name.replace('SLTH_', '').replace('POLICY_', '').replace('BUILDING_', '')
        mod_id = f"MODIFIER_{my_name}_INCREASE_GPP_MULT"
        modifier_type = 'MODIFIER_PLAYER_CAPITAL_CITY_GPP_MULT'
        modifier = [{'ModifierId': mod_id,
                     'ModifierType': modifier_type}]
        modifier_args = [{'ModifierId': mod_id, 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target}]
        dynamic_modifiers = {'ModifierType': modifier_type, 'CollectionType': 'COLLECTION_PLAYER_CAPITAL_CITY',
                             'EffectType': 'EFFECT_ADJUST_CITY_GREAT_PERSON_POINTS_MODIFIER'}
        self.organize(modifier, modifier_args, dynamic_modifier=dynamic_modifiers,
                      loc=[name, [f'{civ4_target}% Great Person Great People points generated per turn.']])
        return [mod_id]

    def buildings_amenities_modifier(self, civ4_target, name, **kwargs):
        buildings = civ4_target['BuildingHappinessChange']
        modifiers, modifier_args, requirements, requirement_arguments, requirement_set = [], [], [], [], []
        loc = [name, []]
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
            loc_name = " ".join([i.capitalize() for i in building_name.replace('BUILDING', '').split('_')]).replace(' Of ', ' of ')
            loc[1].append(f"{loc_name} gives +{amount} [ICON_Amenities] Amenity.")
        self.organize(modifiers, modifier_args, requirements=requirements, requirements_arguments=requirement_arguments,
                      requirements_set=requirement_set, loc=loc)

        """RequirementSetRequirements(RequirementSetId, RequirementId)
                VALUES('BUILDING_IS_FACTORY', 'REQUIRES_CITY_HAS_FACTORY');"""
        return [i['ModifierId'] for i in modifiers]

    def military_prod_modifier(self, civ4_target, name):
        modifier = {'ModifierId': f"MODIFIER_{name}_MILITARY_PRODUCTION",
                    'ModifierType': 'MODIFIER_PLAYER_CITIES_ADJUST_MILITARY_UNITS_PRODUCTION'}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target}]
        self.organize(modifier, modifier_args, loc=[name, [f'+{civ4_target}% Bonus Production to Military Units.']])
        return [modifier['ModifierId']]

    def free_xp_modifier(self, civ4_target, name):
        modifier = {'ModifierId': f"MODIFIER_{name}_MILITARY_EXPERIENCE",
                    'ModifierType': 'MODIFIER_CITY_TRAINED_UNITS_ADJUST_GRANT_EXPERIENCE'}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': -1}]
        self.organize(modifier, modifier_args, loc=[name, [f'City gives free promotion, as cannot work out how to grant experience']])  # this just gives promo, cant seem to find method for part xp
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
        self.organize(modifiers, modifier_args, loc=[name, [f'All units start with a free promotion, as cannot work out how to grant experience']])  # this just gives promo, cant seem to find method for part xp
        return [i['ModifierId'] for i in modifiers]

    def free_xp_modifier_promo_class_specific(self, civ4_target, name):
        target_name = civ4_target['DomainFreeExperience']['DomainType']
        modifier = {'ModifierId': f"MODIFIER_MILITARY_EXPERIENCE_DOMAIN_{target_name}",
                    'ModifierType': 'MODIFIER_CITY_TRAINED_UNITS_ADJUST_GRANT_EXPERIENCE',
                    'SubjectRequirementSetId': f'UNIT_IS_{target_name}'}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': -1}]

        requirements = {'RequirementId': f'REQUIRES_UNIT_IS_{target_name}',
                        'RequirementType': 'REQUIREMENT_UNIT_PROMOTION_CLASS_MATCHES', 'ProgressWeight': '1'}

        requirements_arguments = {'RequirementId': modifier['SubjectRequirementSetId'], 'Name': 'UnitDomain',
                                  'Type': 'ARGTYPE_IDENTITY', 'Value': f'{target_name}'}

        requirements_set = {'RequirementSetId': modifier['SubjectRequirementSetId'],
                            'RequirementSetType': 'REQUIREMENTSET_TEST_ALL'}

        requirement_set_requirements = {'RequirementSetId': requirements_set['RequirementSetId'],
                                        'RequirementId': requirements['RequirementId']}

        self.organize(modifier, modifier_args, requirements=[requirements],
                      requirements_arguments=[requirements_arguments],
                      requirements_set=[requirements_set], requirements_set_reqs=[requirement_set_requirements],
                      loc=[name, [f'City gives free promotion to {target_name}, as cannot work out how to grant experience']])
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
        self.organize(modifiers, modifier_args, loc=[name, [f'Units now have a chance of capturing a builder from defeating major civilization units.']])
        return [modifiers[1]['ModifierId']]

    def builder_charge_modifier(self, civ4_target, name):
        # closest thing to worker speed modifier
        modifier = {'ModifierId': f"MODIFIER_{name}_BUILD_CHARGES",
                    'ModifierType': 'MODIFIER_PLAYER_TRAINED_UNITS_ADJUST_BUILDER_CHARGES', 'Permanent': '1',
                    'SubjectRequirementSetId': 'UNIT_IS_BUILDER'}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': 2}]  # hardcoded value at the moment, unless we see other instances
        self.organize(modifier, modifier_args, loc=[name, [f"Builders start with +{2} charges."]])
        return [modifier['ModifierId']]

    def housing_modifier(self, civ4_target, name):
        modifier = {'ModifierId': f"MODIFIER_{name}_ADJUST_HOUSING",
                    'ModifierType': 'MODIFIER_PLAYER_CITIES_ADJUST_POLICY_HOUSING'}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target}]  # hardcoded value at the moment, unless we see other instances
        self.organize(modifier, modifier_args, loc=[name, [f"+{civ4_target} Housing in all cities."]])
        return [modifier['ModifierId']]

    def no_foreign_trade(self, civ4_target, name):
        # cant ban them, can set them to 0
        modifier = {'ModifierId': f"MODIFIER_{name}_FOREIGN_TRADE_SET_TO_ZERO",
                    'ModifierType': 'MODIFIER_PLAYER_ADJUST_INTERNATIONAL_TRADE_ROUTE_YIELD_MODIFIER_WARLORDS'}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'YieldType', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': 'YIELD_PRODUCTION, YIELD_FOOD, YIELD_SCIENCE, YIELD_CULTURE, YIELD_GOLD, YIELD_FAITH'},
                         {'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': '-100, -100, -100, -100, -100, -100'}]
        self.organize(modifier, modifier_args, loc=[name, [f"Foreign Trade provides 0 yields."]])
        return [modifier['ModifierId']]

    def trade_route_count_modifier(self, civ4_target, name):
        modifier = {'ModifierId': f"MODIFIER_{name}_ADJUST_TRADE_ROUTE_CAPACITY",
                    'ModifierType': 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY'}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target}]  # hardcoded value at the moment, unless we see other instances
        self.organize(modifier, modifier_args, loc=[name, [f"+{civ4_target} Trade Route Capacity."]])
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
        self.organize(modifiers, modifier_args, loc=[name, [f"+{civ4_target} Trade Route Capacity per coastal city."]])
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
        self.organize(modifier, modifier_args, dynamic_modifier=dynamic_modifier, loc=[name, [f"+{civ4_target} to all international Trade Route yields."]])
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
        self.organize(modifiers, modifier_args, loc=[name, [f"+{civ4_target} Amenities per city."]])

        return [i['ModifierId'] for i in modifiers]

    def global_housing_modifier(self, civ4_target, name):
        modifier = {'ModifierId': f"MODIFIER_{name}_ADJUST_HOUSING",
                    'ModifierType': 'MODIFIER_PLAYER_CITIES_ADJUST_POLICY_HOUSING'}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target}]  # hardcoded value at the moment, unless we see other instances
        self.organize(modifier, modifier_args, loc=[name, [f"+{civ4_target} Housing per city."]])
        return [modifier['ModifierId']]

    def free_bonus_modifier(self, civ4_target, name):
        if 'IRON' in civ4_target['FreeBonus']:
            modifier_type = 'MODIFIER_FREE_RESOURCE_EXTRACTION_IN_CAPITAL'
            effect_type = 'EFFECT_ADJUST_PLAYER_FREE_RESOURCE_IMPORT_EXTRACTION'
        else:
            modifier_type = 'MODIFIER_FREE_RESOURCE_IN_CAPITAL'
            effect_type = 'EFFECT_ADJUST_PLAYER_FREE_RESOURCE_IMPORT'
        modifier = {'ModifierId': f"MODIFIER_{name}_GRANT_{civ4_target['FreeBonus'][6:]}",
                    'ModifierType': modifier_type}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target['iNumFreeBonuses']},
                         {'ModifierId': modifier['ModifierId'], 'Name': 'ResourceType', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': f"RESOURCE_{civ4_target['FreeBonus'][6:]}"}]
        if 'MANA' in civ4_target['FreeBonus']:
            spl = civ4_target['FreeBonus'].split('_')
            spl[1], spl[2] = spl[2], spl[1]
            free_bonus_text = " ".join([i.capitalize() for i in spl[1:]])
        else:
            free_bonus_text = " ".join([i.capitalize() for i in civ4_target['FreeBonus'].split('_')[1:]])
        if modifier_type not in self.dynamic_modifiers:
            dynamic_modifier = {'ModifierType': modifier_type,
                                'CollectionType': 'COLLECTION_PLAYER_CAPITAL_CITY',
                                'EffectType': effect_type}
        else:
            dynamic_modifier = None
        self.organize(modifier, modifier_args,
                      loc=[name, [f"+{civ4_target['iNumFreeBonuses']} {free_bonus_text} from city."]],
                      dynamic_modifier=dynamic_modifier)
        return [modifier['ModifierId']]

    def free_building_modifier(self, civ4_target, name):
        # gives free building in all cities
        civ4_target = civ4_target.replace('BUILDINGCLASS', 'SLTH_BUILDING')
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
        self.organize(modifiers, modifier_args, loc=[name, [f"Grant free ###{civ4_target}### in all cities."]])
        return [i['ModifierId'] for i in modifiers]

    def project_prod_mult_modifier(self, civ4_target, name):
        modifier = {'ModifierId': f"MODIFIER_{name}_PROJECT_PROD_MULT",
                    'ModifierType': 'MODIFIER_PLAYER_CITIES_ADJUST_ALL_PROJECTS_PRODUCTION'}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target}]
        self.organize(modifier, modifier_args, loc=[name, [f"{civ4_target}% Production Bonus to Projects in all cities"]])
        return [modifier['ModifierId']]

    def plot_yield_modifier(self, civ4_target, name, modifier_type='MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',
                            requirement='PLOT_HAS_COAST_REQUIREMENTS'):
        yield_changes = civ4_target['iYield']
        if 'CITY' in modifier_type:
            owner = ' in this city.'
        else:
            owner = '.'
        modifiers, modifier_args, loc = [], [], [name, []]
        for idx, amount in enumerate(yield_changes):
            if int(amount) != 0:
                mod_name = f"MODIFIER_{name}_PLOT_YIELD_CHANGE_{yield_map[idx][6:]}"
                modifier = {'ModifierId': mod_name,
                            'ModifierType': modifier_type,
                            'SubjectRequirementSetId': requirement}
                modifiers.append(modifier)
                modifier_args.extend(
                    [{'ModifierId': modifier['ModifierId'], 'Name': 'YieldType', 'Type': 'ARGTYPE_IDENTITY',
                      'Value': yield_map[idx]},
                     {'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                      'Value': amount}])
                loc[1].append(f"+{amount} {yield_map[idx][6:]} on plots of type unspecified{owner}")
        self.organize(modifiers, modifier_args, loc=loc)
        return [i['ModifierId'] for i in modifiers]

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
        self.organize(modifier, modifier_args, loc=[name, [f"+{civ4_target['DomainProductionModifier']['iProductionModifier']} towards {domain} production in this city."]])
        return [modifier['ModifierId']]

    def free_tech_grant(self, civ4_target, name):
        modifier = {'ModifierId': f"MODIFIER_{name}_FREE_TECH",
                    'ModifierType': 'MODIFIER_PLAYER_GRANT_RANDOM_TECHNOLOGY',
                    'RunOnce': 1, 'Permanent': 1}
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target}]
        self.organize(modifier, modifier_args, loc=[name, [f'Grant a random technology.']])
        return [modifier['ModifierId']]

    def tech_grant_specific(self, civ4_target, name):
        tree_type = 'TechType'
        if civ4_target[5:] in self.civic_map:
            civ4_target = 'SLTH_' + self.civic_map[civ4_target[5:]]
            tree_type = 'CivicType'
            # NEVERMIND THIS DOESNT WORK BECAUSE WE NEED TO DO IT IN LUA AGHHH. CHECK SCENARIOS for examples
        mod_name = f"MODIFIER_{name}_GRANT_{civ4_target}"
        mod_type_name = 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY'
        modifier = {'ModifierId': mod_name, 'ModifierType': mod_type_name, 'RunOnce': 1, 'Permanent': 1}
        modifier_args = [{'ModifierId': mod_name, 'Name': tree_type, 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target}]
        dynamic_modifier = {'ModifierType': mod_type_name, 'CollectionType': 'COLLECTION_OWNER',
                            'EffectType': 'EFFECT_GRANT_PLAYER_SPECIFIC_TECHNOLOGY'}
        self.organize(modifier, modifier_args, dynamic_modifier=dynamic_modifier, loc=[name, [f"Grant ###{civ4_target}###."]])
        return modifier['ModifierId']

    def mana_modifier(self, civ4_target, name):
        target_name = name
        mod_id = f"MODIFIER_{name}"
        require_id = f'REQUIRES_PLAYER_HAS_{target_name}'
        require_set = f'PLAYER_HAS_{target_name}'
        modifier = [{'ModifierId': mod_id,
                     'ModifierType': 'MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_YIELD_MODIFIER',
                     'SubjectRequirementSetId': require_set}]
        modifier_args = [{'ModifierId': mod_id, 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target},
                         {'ModifierId': mod_id, 'Name': 'YieldType', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': 'YIELD_PRODUCTION'}]
        requirements = [{'RequirementId': require_id,
                         'RequirementType': 'REQUIREMENT_PLAYER_HAS_RESOURCE_OWNED', 'ProgressWeight': '1'}]

        requirements_arguments = [{'RequirementId': require_id, 'Name': 'ResourceType',
                                  'Type': 'ARGTYPE_IDENTITY', 'Value': f'{target_name}'}]
        requirements_set = [{'RequirementSetId': require_set,
                             'RequirementSetType': 'REQUIREMENTSET_TEST_ALL'}]

        requirement_set_requirements = [{'RequirementSetId': require_set,
                                        'RequirementId':require_id}]

        self.organize(modifier, modifier_args, requirements=requirements,
                      requirements_arguments=requirements_arguments,
                      requirements_set=requirements_set, requirements_set_reqs=requirement_set_requirements)
        return mod_id

    def gpp_in_capital(self, civ4_target, name):
        great_person = gpp_map[name]
        mod_id = f"MODIFIER_{name}_INCREASE_GPP_POINT_BONUS"
        modifier_type = 'MODIFIER_PLAYER_CAPITAL_CITY_GPP_INCREASE'
        modifier = [{'ModifierId': mod_id,
                     'ModifierType': modifier_type}]
        modifier_args = [{'ModifierId': mod_id, 'Name': 'GreatPersonClassType', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': great_person},
                         {'ModifierId': mod_id, 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target}]
        dynamic_modifier = {'ModifierType': modifier_type, 'CollectionType': 'COLLECTION_PLAYER_CAPITAL_CITY',
                            'EffectType': 'EFFECT_ADJUST_GREAT_PERSON_POINTS'}
        self.organize(modifier, modifier_args, dynamic_modifier=dynamic_modifier)
        return [mod_id]

    def gpp_mult_in_capital(self, civ4_target, name):
        mod_id = f"MODIFIER_{name[14:]}_INCREASE_GPP_MULT"
        modifier_type = 'MODIFIER_PLAYER_CAPITAL_CITY_GPP_MULT'
        modifier = [{'ModifierId': mod_id,
                     'ModifierType': modifier_type}]
        modifier_args = [{'ModifierId': mod_id, 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target}]
        dynamic_modifiers = {'ModifierType': modifier_type, 'CollectionType': 'COLLECTION_PLAYER_CAPITAL_CITY',
                            'EffectType': 'EFFECT_ADJUST_CITY_GREAT_PERSON_POINTS_MODIFIER'}

    def improvement_bonus_when_worked(self, civ4_target, improvement):
        bonus, yield_type, amount = civ4_target['bonus'], civ4_target['yield_type'], civ4_target['amount']
        mod_attach_id = f"MODIFIER_{bonus}_{yield_type}_TAG_CITY_ATTACH"
        mod_id = f"MODIFIER_{bonus}_{yield_type}_TAG"
        req_id = f"PLOT_HAS_{bonus}_{yield_type}_TAG"
        set_req = f"PLOT_HAS_{bonus}_{yield_type}_TAG_IMPROVED"
        req_improvement = f"REQUIRES_PLOT_HAS_{improvement['ImprovementType'][12:]}"
        tag = f"CLASS_{bonus}_{yield_type}"
        modifiers = [{"ModifierId": mod_attach_id,
                     "ModifierType": "MODIFIER_ALL_CITIES_ATTACH_MODIFIER"}]
        modifier_args = [{"ModifierId": mod_attach_id, "Name": "ModifierId",
                          "Type": "ARGTYPE_IDENTITY",
                          "Value": mod_id}]
        modifiers.append({"ModifierId": mod_id,
                          "ModifierType": "MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD",
                          "SubjectRequirementSetId": set_req})
        modifier_args.append({"ModifierId": mod_id, "Name": "YieldType",
                              "Type": "ARGTYPE_IDENTITY", "Value": yield_type})
        modifier_args.append({"ModifierId": mod_id,
                              "Name": "Amount", "Type": "ARGTYPE_IDENTITY", "Value": amount})
        requires = [{"RequirementId": req_id, "RequirementType": "REQUIREMENT_PLOT_RESOURCE_TAG_MATCHES"},
                    {"RequirementId": req_improvement, "RequirementType": "REQUIREMENT_PLOT_IMPROVEMENT_TYPE_MATCHES"}]
        require_args = [{"RequirementId": req_id, "Name": "Tag", "Type": "ARGTYPE_IDENTITY", "Value": tag},
                        {"RequirementId": req_improvement, "Name": "ImprovementType", "Type": "ARGTYPE_IDENTITY",
                         "Value": improvement['ImprovementType']}]
        require_set = [{"RequirementSetId": set_req, "RequirementSetType": "REQUIREMENTSET_TEST_ALL"}]

        req_set_reqs = [{"RequirementSetId": set_req, "RequirementId": req_improvement},
                        {"RequirementSetId": set_req, "RequirementId": req_id}]
        tags = {"Tag": tag, "Vocabulary": "RESOURCE_CLASS"}
        type_tags = {'Type': f"RESOURCE_{bonus}", 'Tag': tag}
        self.organize(modifiers, modifier_args, requirements=requires,
                      requirements_arguments=require_args,
                      requirements_set=require_set, requirements_set_reqs=req_set_reqs, tags=tags, type_tags=type_tags)
        return mod_attach_id

    def promotion_builder(self, civ4_target, name):
        return self.promotion_modifiers.choose_promo(civ4_target, name)

    def ban_unit(self, civ4_target, name):
        mod_name = f"MODIFIER_BAN_{civ4_target}"
        modifier = {'ModifierId': mod_name, 'ModifierType': 'MODIFIER_PLAYER_UNIT_BUILD_DISABLED'}
        modifier_args = [{'ModifierId': mod_name, 'Name': 'UnitType', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_target}]
        self.organize(modifier, modifier_args)
        return modifier['ModifierId']

    def damage_type_Implementation(self, civ4_target, name):
        self.logger.debug(f"{name}'s {civ4_target} not implemented as needs Damage type module, probably handled in Magic")
        self.not_implemented_count += 1

    def bonus_requirementImplementation(self, civ4_target, name):
        self.logger.debug(f"{name}'s {civ4_target} not implemented")
        self.logger.debug('If we have apply a modifier to the city, with secondary requirement that we have x resource')
        self.not_implemented_count += 1

    def bonus_production_modifier_building(self, civ4_target, name):
        print('MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION')
        self.not_implemented_count += 1

    def apply_to_unit_if_in_cityImplement(self, civ4_target, name):
        modifier = {'ModifierId': 'MEDIC_INCREASE_HEAL_RATE',
                    'ModifierType': 'MODIFIER_PLAYER_UNITS_ADJUST_HEAL_PER_TURN',
                    'SubjectRequirementSetId': 'MEDIC_HEALING_REQUIREMENTS'}
        requirement_set = {'RequirementSetId': 'MEDIC_HEALING_REQUIREMENTS',
                           'RequirementSetType': 'REQUIREMENTSET_TEST_ALL'}
        requirement_set_requirements = {'RequirementSetId': 'MEDIC_HEALING_REQUIREMENTS',
                                        'RequirementId': 'ADJACENT_UNIT_REQUIREMENT'}
        self.logger.debug(f"{name} with {civ4_target} seems possible, but awkward")
        self.not_implemented_count += 1

    def feature_happiness_modifier(self, civ4_target, name):
        self.logger.debug(f"{name}'s {civ4_target} not implemented")
        self.not_implemented_count += 1

    def specialistImplement(self, civ4_target, name):
        self.logger.debug(f"{name}'s {civ4_target} not implemented")
        self.not_implemented_count += 1
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
        self.logger.debug(f"{name}'s {civ4_target} not implemented, who knows")
        self.not_implemented_count += 1

    def magicImplement(self, civ4_target, name):
        self.logger.debug(f"{name}'s {civ4_target} not implemented as needs Magic module")

    def maintenanceImplement(self, civ4_target, name):
        self.logger.debug(f"{name}'s {civ4_target} not implemented as needs Maintenance Rework")
        self.not_implemented_count += 1

    def religionImplement(self, civ4_target, name):
        self.logger.debug(f"{name}'s {civ4_target} not implemented as needs Religion Rework")
        self.not_implemented_count += 1

    def alignmentImplement(self, civ4_target, name):
        self.logger.debug(f"{name}'s {civ4_target} not implemented as needs Alignment Rework")
        self.not_implemented_count += 1

    def otherSystemImplement(self, civ4_target, name):
        self.logger.debug(f"{name}'s {civ4_target} not implemented as needs some other thing")
        self.not_implemented_count += 1
        # Stuck on SpecialistValids, iLargestCityHappiness as no concept of largest cities in civ,
        # bNoDiplomacyWithEnemies, bPrereqWar

    def prereqImplement(self, civ4_target, name):
        self.logger.debug(f"{name}'s {civ4_target} not implemented as it is a prerequisite, how can we apply this to a policy")
        self.not_implemented_count += 1

    def cantImplement(self, civ4_target, name):
        self.logger.debug(f"{name}'s {civ4_target} not implemented as it is a concept too far outside of civ vi")
        self.not_implemented_count += 1
        # half food requirements GlobalParameters (Name: 'CITY_FOOD_CONSUMPTION_PER_POPULATION', "Value": '2.0')
