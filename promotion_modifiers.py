import pandas as pd

class PromotionModifiers:
    def __init__(self, modifier_obj):
        self.modifier_obj = modifier_obj
        self.promo_map = {'PROMOTION_COMMANDO': self.existsalready,
                          'PROMOTION_LOYALTY': self.not_implemented_effect,
                          'PROMOTION_FLYING': self.existsalready,
                          'PROMOTION_DIVINE': self.hardimplement,
                          'PROMOTION_POTENCY': self.hardimplement,
                          'PROMOTION_MUTATED': self.not_implemented_effect,
                          'PROMOTION_MORALE': self.not_implemented_effect,
                          'PROMOTION_COMMAND2': self.hardimplement,
                          'PROMOTION_COURAGE': self.not_implemented_effect,
                          'PROMOTION_VALOR': self.not_implemented_effect,
                          'PROMOTION_PLAGUE_CARRIER': self.hardimplement,
                          'PROMOTION_BOARDING': self.hardimplement,
                          'PROMOTION_HIDDEN': self.easyimplement,
                          'PROMOTION_MEDIC2': self.easyimplement,
                          'PROMOTION_CRAZED': self.hardimplement,
                          'PROMOTION_STEALTH': self.easyimplement,
                          'PROMOTION_VAMPIRE': self.no_clue,
                          'PROMOTION_ILLUSIONIST': self.no_clue,
                          'PROMOTION_PERFECT_SIGHT': self.no_clue,
                          'PROMOTION_PRECISION': self.no_clue,
                          'PROMOTION_SPIRIT_GUIDE': self.hardimplement,
                          'PROMOTION_HIDDEN_NATIONALITY': self.no_clue,
                          'PROMOTION_BLITZ': self.easyimplement,
                          'PROMOTION_MEDIC1': self.easyimplement,
                          'PROMOTION_DEFENSIVE': self.easyimplement,
                          'PROMOTION_PUPPET': self.no_clue,
                          'PROMOTION_STIGMATA': self.no_clue,
                          'PROMOTION_DISEASED': self.effect_conditional_end,
                          'PROMOTION_PLAGUED': self.effect_conditional_end,
                          'PROMOTION_WITHERED': self.effect_conditional_end,
                          'PROMOTION_VILE_TOUCH': self.easyimplement,
                          'PROMOTION_WEREWOLF': self.easyimplement,
                          'PROMOTION_AVATAR': self.easyimplement,
                          'PROMOTION_INQUISITOR': self.easyimplement,
                          'PROMOTION_WATER_WALKING': self.easyimplement,
                          'PROMOTION_MEDIC3': self.easyimplement,
                          'PROMOTION_UNDEAD': self.hardimplement,
                          'PROMOTION_SENTRY': self.easyimplement,
                          'PROMOTION_DRAGON_SLAYING': self.easyimplement,
                          'PROMOTION_IMMUNE_DISEASE': self.not_implemented_effect,
                          'PROMOTION_ENRAGED': self.hardimplement,
                          'PROMOTION_DEMON_SLAYING': self.easyimplement,
                          'PROMOTION_MARKSMAN': self.concept_out_of_civ_implement,
                          'PROMOTION_RECRUITER': self.concept_out_of_civ_implement,
                          'PROMOTION_GUARDSMAN': self.concept_out_of_civ_implement,
                          'PROMOTION_DRILL1': self.concept_out_of_civ_implement,
                          'PROMOTION_DRILL2': self.concept_out_of_civ_implement,
                          'PROMOTION_DRILL3': self.concept_out_of_civ_implement,
                          'PROMOTION_DRILL4': self.concept_out_of_civ_implement,
                          'PROMOTION_FLANKING1': self.concept_out_of_civ_implement,
                          'PROMOTION_FLANKING2': self.concept_out_of_civ_implement,
                          'PROMOTION_FLANKING3': self.concept_out_of_civ_implement,
                          'iCollateralDamageChange': self.concept_out_of_civ_implement,
                          'PROMOTION_AERONS_CHOSEN': self.concept_out_of_civ_implement,
                          'PROMOTION_GREAT_COMMANDER': self.concept_out_of_civ_implement,
                          'PROMOTION_INVISIBLE': self.easyimplement,
                          'PROMOTION_HERO': self.easyimplement,
                          'PROMOTION_HOMELAND': self.easyimplement,
                          'PROMOTION_COMMAND1': self.hardimplement,
                          'PROMOTION_COMMAND3': self.hardimplement,
                          'PROMOTION_COMMAND4': self.hardimplement,
                          'PROMOTION_ILLUSION': self.hardimplement,
                          'PROMOTION_IMMORTAL': self.hardimplement,
                          'PROMOTION_UNHOLY_TAINT': self.hardimplement,
                          'PROMOTION_STARTING_SETTLER': self.easyimplement,
                          'PROMOTION_WOODSMAN1': self.easyimplement,
                          'PROMOTION_STONESKIN': self.effect_conditional_end,
                          'PROMOTION_DANCE_OF_BLADES': self.not_implemented_effect,
                          'PROMOTION_BLUR': self.not_implemented_effect,
                          'PROMOTION_FAIR_WINDS': self.not_implemented_effect,
                          'PROMOTION_HASTED': self.not_implemented_effect,
                          'PROMOTION_HELD': self.not_implemented_effect,
                          'PROMOTION_FATIGUED': self.not_implemented_effect,
                          'PROMOTION_SHADOWWALK': self.not_implemented_effect,
                          'PROMOTION_SLOW': self.not_implemented_effect,
                          'PROMOTION_WARCRY': self.not_implemented_effect,
                          'PROMOTION_BURNING_BLOOD': self.not_implemented_effect,
                          'PROMOTION_CHARMED': self.not_implemented_effect,
                          'PROMOTION_BLESSED': self.effect_conditional_end,
                          'PROMOTION_SHIELD_OF_FAITH': self.effect_conditional_end,
                          'PROMOTION_POISONED': self.effect_conditional_end,
                          'PROMOTION_REGENERATION': self.effect_conditional_end,
                          'PROMOTION_ENCHANTED_BLADE': self.easyimplement,
                          'PROMOTION_CROWN_OF_BRILLANCE': self.effect_conditional_end,
                          'PROMOTION_RUSTED': self.effect_conditional_end,
                          'PROMOTION_POISONED_BLADE': self.easyimplement,
                          'PROMOTION_FLAMING_ARROWS': self.easyimplement,
                          'PROMOTION_IMMUNE_COLD': self.not_implemented_damage_types,
                          'PROMOTION_VULNERABLE_TO_FIRE': self.not_implemented_damage_types,
                          'PROMOTION_IMMUNE_LIGHTNING': self.not_implemented_damage_types,
                          'PROMOTION_MAGIC_IMMUNE': self.not_implemented_damage_types,
                          'PROMOTION_FIRE_RESISTANCE': self.not_implemented_damage_types,
                          'PROMOTION_MAGIC_RESISTANCE': self.not_implemented_damage_types,
                          'PROMOTION_IMMUNE_FIRE': self.not_implemented_damage_types,
                          'PROMOTION_COLD_RESISTANCE': '#self.tosort#',
                          'PROMOTION_LIGHTNING_RESISTANCE': '#self.tosort#',
                          'PROMOTION_POISON_RESISTANCE': '#self.tosort#',
                          'PROMOTION_NOMAD': self.race,
                          'PROMOTION_ANGEL': self.race,
                          'PROMOTION_DRAGON': self.race,
                          'PROMOTION_DARK_ELF': self.race,
                          'PROMOTION_GOLEM': self.race,
                          'PROMOTION_FROSTLING': self.race,
                          'PROMOTION_ORC': self.race,
                          'PROMOTION_DWARF': self.race,
                          'PROMOTION_ELF': self.race,
                          'PROMOTION_WINTERBORN': self.race,
                          'PROMOTION_LIZARDMAN': self.race,
                          'PROMOTION_CENTAUR': self.race,
                          'PROMOTION_ELEMENTAL': self.race,
                          'PROMOTION_DEMON': self.race,
                          'PROMOTION_HORSELORD': '#self.tosort#', 'PROMOTION_SINISTER': '#self.tosort#',
                          'PROMOTION_CHANNELING1': self.channeling,
                          'PROMOTION_CHANNELING2': self.channeling,
                          'PROMOTION_CHANNELING3': self.channeling,
                          'PROMOTION_ICE1': self.not_implemented_sphere,
                          'PROMOTION_ICE2': self.not_implemented_sphere,
                          'PROMOTION_ICE3': self.not_implemented_sphere,
                          'PROMOTION_SPIRIT1': self.not_implemented_sphere,
                          'PROMOTION_FIRE1': self.not_implemented_sphere,
                          'PROMOTION_BODY1': self.not_implemented_sphere,
                          'PROMOTION_BODY2': self.not_implemented_sphere,
                          'PROMOTION_BODY3': self.not_implemented_sphere,
                          'PROMOTION_LIFE1': self.not_implemented_sphere,
                          'PROMOTION_FIRE3': self.not_implemented_sphere,
                          'PROMOTION_LIFE2': self.not_implemented_sphere,
                          'PROMOTION_NATURE1': self.not_implemented_sphere,
                          'PROMOTION_MIND1': self.not_implemented_sphere,
                          'PROMOTION_DEATH1': self.not_implemented_sphere,
                          'PROMOTION_DEATH2': self.not_implemented_sphere,
                          'PROMOTION_DEATH3': self.not_implemented_sphere,
                          'PROMOTION_EARTH1': self.not_implemented_sphere,
                          'PROMOTION_EARTH2': self.not_implemented_sphere,
                          'PROMOTION_EARTH3': self.not_implemented_sphere,
                          'PROMOTION_FIRE2': self.not_implemented_sphere,
                          'PROMOTION_SPIRIT2': self.not_implemented_sphere,
                          'PROMOTION_ENCHANTMENT1': self.not_implemented_sphere,
                          'PROMOTION_ENCHANTMENT2': self.not_implemented_sphere,
                          'PROMOTION_ENCHANTMENT3': self.not_implemented_sphere,
                          'PROMOTION_SUN1': self.not_implemented_sphere,
                          'PROMOTION_ENTROPY1': self.not_implemented_sphere,
                          'PROMOTION_ENTROPY2': self.not_implemented_sphere,
                          'PROMOTION_ENTROPY3': self.not_implemented_sphere,
                          'PROMOTION_CHAOS1': self.not_implemented_sphere,
                          'PROMOTION_CHAOS2': self.not_implemented_sphere,
                          'PROMOTION_CHAOS3': self.not_implemented_sphere,
                          'PROMOTION_MIND2': self.not_implemented_sphere,
                          'PROMOTION_MIND3': self.not_implemented_sphere,
                          'PROMOTION_METAMAGIC1': self.not_implemented_sphere,
                          'PROMOTION_METAMAGIC2': self.not_implemented_sphere,
                          'PROMOTION_METAMAGIC3': self.not_implemented_sphere,
                          'PROMOTION_NATURE2': self.not_implemented_sphere,
                          'PROMOTION_NATURE3': self.not_implemented_sphere,
                          'PROMOTION_LAW1': self.not_implemented_sphere,
                          'PROMOTION_SUN2': self.not_implemented_sphere,
                          'PROMOTION_AIR1': self.not_implemented_sphere, 'PROMOTION_AIR2': self.not_implemented_sphere,
                          'PROMOTION_AIR3': self.not_implemented_sphere,
                          'PROMOTION_SHADOW1': self.not_implemented_sphere,
                          'PROMOTION_SHADOW2': self.not_implemented_sphere,
                          'PROMOTION_SHADOW3': self.not_implemented_sphere,
                          'PROMOTION_SPIRIT3': self.not_implemented_sphere,
                          'PROMOTION_WATER1': self.not_implemented_sphere,
                          'PROMOTION_WATER2': self.not_implemented_sphere,
                          'PROMOTION_WATER3': self.not_implemented_sphere,
                          'PROMOTION_LAW2': self.not_implemented_sphere,
                          'PROMOTION_LAW3': self.not_implemented_sphere, 'PROMOTION_LIFE3': self.not_implemented_sphere,
                          'PROMOTION_SUN3': self.not_implemented_sphere,
                          'PROMOTION_SPELLSTAFF': self.not_implemented_equipment,
                          'PROMOTION_WAR': self.not_implemented_equipment,
                          'PROMOTION_ORTHUSS_AXE': self.not_implemented_equipment,
                          'PROMOTION_BLACK_MIRROR': self.not_implemented_equipment,
                          'PROMOTION_ATHAME': self.not_implemented_equipment,
                          'PROMOTION_GELA': self.not_implemented_equipment,
                          'PROMOTION_EMPTY_BIER': self.not_implemented_equipment,
                          'PROMOTION_NETHER_BLADE': self.not_implemented_equipment,
                          'PROMOTION_CROWN_OF_COMMAND': self.not_implemented_equipment,
                          'PROMOTION_STAFF_OF_SOULS': self.not_implemented_equipment,
                          'PROMOTION_PIECES_OF_BARNAXUS': self.not_implemented_equipment,
                          'PROMOTION_CROWN_OF_AKHARIEN': self.not_implemented_equipment,
                          'PROMOTION_DRAGONS_HORDE': self.not_implemented_equipment,
                          'PROMOTION_GODSLAYER': self.not_implemented_equipment,
                          'PROMOTION_GOLDEN_HAMMER': self.not_implemented_equipment,
                          'PROMOTION_HEALING_SALVE': self.not_implemented_equipment,
                          'PROMOTION_INFERNAL_GRIMOIRE': self.not_implemented_equipment,
                          'PROMOTION_JADE_TORC': self.not_implemented_equipment,
                          'PROMOTION_POTION_OF_INVISIBILITY': self.not_implemented_equipment,
                          'PROMOTION_ROD_OF_WINDS': self.not_implemented_equipment,
                          'PROMOTION_POTION_OF_RESTORATION': self.not_implemented_equipment,
                          'PROMOTION_SCORCHED_STAFF': self.not_implemented_equipment,
                          'PROMOTION_SYLIVENS_PERFECT_LYRE': self.not_implemented_equipment,
                          'PROMOTION_TIMOR_MASK': self.not_implemented_equipment,
                          'PROMOTION_COMBAT1': self.combat,
                          'PROMOTION_COMBAT2': self.combat, 'PROMOTION_COMBAT3': self.combat,
                          'PROMOTION_COMBAT4': self.combat, 'PROMOTION_COMBAT5': self.combat,
                          'PROMOTION_EMPOWER1': self.combat,
                          'PROMOTION_EMPOWER2': self.combat, 'PROMOTION_EMPOWER3': self.combat,
                          'PROMOTION_EMPOWER4': self.combat, 'PROMOTION_EMPOWER5': self.combat,
                          'PROMOTION_COVER': self.cover_ability,
                          'PROMOTION_COVER2': self.cover_ability,
                          'PROMOTION_FORMATION': self.formation_ability, 'PROMOTION_FORMATION2': self.formation_ability,
                          'PROMOTION_SHOCK': self.shock_ability, 'PROMOTION_SHOCK2': self.shock_ability,
                          'PROMOTION_SUBDUE_ANIMAL': self.subdue_animal, 'PROMOTION_SUBDUE_BEASTS': self.subdue_beast,
                          'PROMOTION_UNDEAD_SLAYING': self.undead_slaying, 'PROMOTION_SCOURGE': self.scourge_ability,
                          'PROMOTION_MOBILITY1': self.pursuit, 'PROMOTION_MOBILITY2': self.redeploy,
                          'PROMOTION_NAVIGATION1': self.helmsman, 'PROMOTION_NAVIGATION2': self.pursuit,
                          'iBombardRateChange': self.shells,
                          'PROMOTION_HEROIC_DEFENSE': self.on_defense_bonus,
                          'PROMOTION_HEROIC_DEFENSE2': self.on_defense_bonus,
                          'PROMOTION_HEROIC_STRENGTH': self.on_attack_bonus,
                          'PROMOTION_HEROIC_STRENGTH2': self.on_attack_bonus,
                          'PROMOTION_CITY_GARRISON1': self.garrison,
                          'PROMOTION_CITY_GARRISON2': self.garrison,
                          'PROMOTION_CITY_GARRISON3': self.garrison,
                          'PROMOTION_CITY_RAIDER1': self.marauding,
                          'PROMOTION_CITY_RAIDER2': self.marauding, 'PROMOTION_CITY_RAIDER3': self.marauding,
                          'PROMOTION_HEAVY': self.easyimplement, 'PROMOTION_LIGHT': self.easyimplement,
                          'PROMOTION_GUERILLA1': self.easyimplement,
                          'PROMOTION_GUERILLA2': self.easyimplement,
                          'PROMOTION_STRONG': self.easyimplement, 'PROMOTION_WEAK': self.easyimplement,
                          'PROMOTION_BOUNTY_HUNTER': self.easyimplement,
                          'PROMOTION_BRONZE_WEAPONS': self.buff_by_resource,
                          'PROMOTION_IRON_WEAPONS': self.buff_by_resource,
                          'PROMOTION_MITHRIL_WEAPONS': self.buff_by_resource,
                          'PROMOTION_NIGHTMARE': self.buff_by_resource, 'PROMOTION_SHEUT_STONE': self.buff_by_resource,
                          'PROMOTION_LONGSHOREMEN': self.ship_refitting, 'PROMOTION_SKELETON_CREW': self.ship_refitting,
                          'PROMOTION_EXPANDED_HULL': self.ship_refitting, 'PROMOTION_BUCCANEERS': self.ship_refitting,
                          'PROMOTION_PROPHECY_MARK': self.armageddon,
                          'TerrainDoubleMove': self.ability_terrain_movebuff,
                          'FeatureDoubleMove': self.ability_feature_movebuff,
                          'TerrainAttack': self.ability_terrain_or_feature_combat,
                          'TerrainDefense': self.ability_terrain_defense,
                          'Terrain_Strength': self.ability_terrain_all,
                          'FeatureAttack': self.ability_feature_attack,
                          'FeatureDefense': self.ability_feature_defense,
                          'DamageTypeResist': self.not_implemented_damage_types,
                          'bHillsDoubleMove': self.ability_hills_movebuff,
                          'SLTH_TRAIT_SPRAWLING': self.concept_out_of_civ_implement,  # yaxchilan mod
                          'SLTH_TRAIT_AGNOSTIC': self.trait_agnostic,
                          'SLTH_TRAIT_SUNDERED': self.ability_sundered,
                          'SLTH_TRAIT_FALLOW': self.trait_fallow,
                          'SLTH_TRAIT_GUARDSMAN': self.concept_out_of_civ_implement,
                          'SLTH_TRAIT_DEXTEROUS': self.ability_ranged_buff,
                          'SLTH_TRAIT_SINISTER': self.ability_scout_buff,
                          'SLTH_TRAIT_HORSELORD': self.trait_horselord,
                          'SLTH_ONLY_UNIT': self.one_of_unit_setter,
                          'iWorkRateModify': self.concept_out_of_civ_implement,
                          # difficult as build charges, would need to apply to only units with buld chargs already
                          'bImmuneToFear': self.concept_out_of_civ_implement,  # no fear in civ6 as no tile stack
                          'bNotAlive': self.concept_out_of_civ_implement,
                          'bAmphib': self.amphibious,
                          'bRiver': self.river,
                          'UnitCombatMods': self.combat,
                          'bBlitz': self.blitz,
                          'iGoldFromCombat': self.gold_from_combat,
                          'iCombatHealPercent': self.combat_heal_after,
                          'iCityDefense': self.garrison,
                          'iCityAttack': self.marauding,
                          'DamageTypeResists': self.not_implemented_damage_types,
                          'iCombatPercent': self.combat,
                          'iCombatPercentDefense': self.on_defense_bonus,
                          'iSpellDamageModify': self.not_implemented_damage_types,
                          'PromotionSummonPerk': self.not_implemented_sphere,
                          'iCombatCapturePercent': self.hardimplement,
                          'bEnemyRoute': self.hardimplement,
                          'iChanceFirstStrikesChange': self.concept_out_of_civ_implement,
                          'bDoubleFortifyBonus': self.hardimplement,
                          'iPromotionCombatMod': self.hardimplement,
                          'iDefensiveStrikeChance': self.concept_out_of_civ_implement,
                          'iDefensiveStrikeDamage': self.concept_out_of_civ_implement,
                          'iFirstStrikesChange': self.concept_out_of_civ_implement,
                          'iCollateralDamageProtection': self.concept_out_of_civ_implement,
                          'iCargoChange': self.concept_out_of_civ_implement,
                          'bFear': self.force_retreat,
                          'iWithdrawalChange':  self.concept_out_of_civ_implement,
                          'bImmuneToFirstStrikes': self.concept_out_of_civ_implement,
                          'bTargetWeakestUnitCounter': self.concept_out_of_civ_implement,
                          'iBetterDefenderThanPercent': self.concept_out_of_civ_implement,
                          'bTargetWeakestUnit': self.concept_out_of_civ_implement,
                          'iHillsDefense': self.hill_defense,
                          'iExtraCombatDefense': self.on_defense_bonus,
                          'iExtraCombatStr': self.on_attack_bonus,
                          'iResistMagic': self.not_implemented_damage_types,
                          'bAlwaysHeal': self.heal_every_move,
                          'iEnemyHealChange': self.heal_territory,
                          'iAdjacentTileHealChange': self.heal_allies,
                          'iSameTileHealChange': self.heal_allies,
                          'iMovesChange': self.pursuit,
                          'bSeeInvisible': self.hardimplement,
                          'iVisibilityChange': self.spyglass,
                          'CaptureUnitCombat': self.capture_ability_with_class,
                          'bTwincast': self.not_implemented_sphere,
                          'FeatureAttacks': self.ability_feature_attack,
                          'FeatureDefenses': self.ability_feature_defense,
                          'FeatureDoubleMoves': self.ability_feature_movebuff,
                          'iCasterResistModify': self.not_implemented_sphere,
                          'iCombatPercentGlobalCounter': self.concept_out_of_civ_implement,
                          'SLTH_MANA_ABILITY': self.grant_ability_mana
                          }

    def choose_promo(self, civ4_target, name):
        civ4_name = list(civ4_target.keys())[0]
        return self.promo_map[civ4_name](civ4_target, name)


    def channeling(self, civ4_target, name):
        civ4_name, civ4_ability = list(civ4_target.keys())[0], list(civ4_target.values())[0]
        mod_name = f"MODIFIER_{name}_EXPERIENCE_PER_TURN"
        modifier = {'ModifierId': mod_name,
                    'ModifierType': 'MODIFIER_PLAYER_UNIT_ADJUST_GRANT_EXPERIENCE'
                    #,"RunOnce": "1", "Permanent": "1"
                    }
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': 20}]
        ability_name = f'{name}_ABILITY_{civ4_name.upper()}'
        ability = {'UnitAbilityType': ability_name, 'Name': f'LOC_SLTH_{ability_name}_NAME',
                   'Description': f'LOC_{ability_name}_DESCRIPTION', 'Inactive': 1,
                   'ShowFloatTextWhenEarned': 0, 'Permanent': 1}
        ability_modifier = {'UnitAbilityType': ability_name, 'ModifierId': modifier['ModifierId']}
        type_tags = {'Type': ability_name, 'Tag': 'CLASS_ADEPT'}
        self.modifier_obj.organize(modifier=modifier, modifier_arguments=modifier_args, ability=ability,
                                   ability_modifiers=ability_modifier, type_tags=type_tags)

    def combat(self, civ4_target, name, promoclass=None, require=None, requireset=None, loc_info=''):
        civ4_ability = list(civ4_target.values())[0]
        if isinstance(civ4_ability, dict):
            deplatted = list(civ4_target.values())[0].get('UnitCombatMod', {})
            civ4_ability, promoclass = deplatted.get('iUnitCombatMod'), deplatted.get('UnitCombatType')
            if promoclass is not None:
                promoclass = promoclass.replace('UNITCOMBAT', 'PROMOTION_CLASS')
                civ4_ability = int(int(civ4_ability) / 4)
                loc_info = f'against {promoclass.replace("PROMOTION_CLASS_", "").capitalize()} units'
        mod_name = f"MODIFIER_{name}"
        modifiers = [{'ModifierId': mod_name, 'ModifierType': 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH'}]
        modifier_args = [{'ModifierId': mod_name, 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY', 'Value': civ4_ability}]
        loc = [f'LOC_{name}_DESCRIPTION', [f'+{civ4_ability} [ICON_Strength] Combat Strength {loc_info}']]
        if promoclass is not None:
            req_id = f'OPPONENT_{promoclass}_REQUIREMENT'
            master_req_set = f'{req_id}_SET'
            modifiers[0]['SubjectRequirementSetId'] = master_req_set
            requirements = [{'RequirementId': req_id,
                             'RequirementType': 'REQUIREMENT_OPPONENT_UNIT_PROMOTION_CLASS_MATCHES'}]
            requirement_arguments = [{'RequirementId': req_id, 'Name': 'UnitPromotionClass',
                                      'Type': 'ARGTYPE_IDENTITY', 'Value': f'PROMOTION_CLASS_{promoclass}'}]
            requirement_sets = [{'RequirementSetId': master_req_set, 'RequirementSetType': 'REQUIREMENTSET_TEST_ALL'}]
            req_set_reqs = [{'RequirementSetId': master_req_set, 'RequirementId': req_id}]
            self.modifier_obj.organize(modifiers, modifier_args, requirements=requirements,
                                       requirements_set=requirement_sets,
                                       requirements_arguments=requirement_arguments, requirements_set_reqs=req_set_reqs,
                                       loc=loc)

        elif require is not None:
            modifiers[0]['SubjectRequirementSetId'] = require
            self.modifier_obj.organize(modifiers, modifier_args, loc=loc)
        elif requireset is not None:
            req_id = f'REQUIREMENT_{name}'
            master_req_set = f'{req_id}_SET'
            requirement_sets = [{'RequirementSetId': master_req_set, 'RequirementSetType': 'REQUIREMENTSET_TEST_ALL'}]
            req_set_reqs = [{'RequirementSetId': master_req_set, 'RequirementId': requireset}]
            modifiers[0]['SubjectRequirementSetId'] = master_req_set
            self.modifier_obj.organize(modifiers, modifier_args, requirements_set=requirement_sets,
                                       requirements_set_reqs=req_set_reqs, loc=loc)
        else:
            self.modifier_obj.organize(modifiers, modifier_args, loc=loc)
        return mod_name

    def cover_ability(self, civ4_target, name):
        return self.combat(civ4_target, name, 'RANGED')

    def shock_ability(self, civ4_target, name):
        return self.combat(civ4_target, name, 'MELEE')

    def formation_ability(self, civ4_target, name):
        return self.combat(civ4_target, name, 'LIGHT_CAVALRY')

    def scourge_ability(self, civ4_target, name):
        return self.combat(civ4_target, name, 'DISCIPLE')

    def combat_against_promotion(self, civ4_target, name, promotion):
        return

    def undead_slaying(self, civ4_target, name):
        return self.combat_against_promotion(civ4_target, name, 'SLTH_PROMOTION_UNDEAD')

    def capture_ability_with_class(self, civ4_target, name):
        civ4_name, civ4_ability = list(civ4_target.keys())[0], list(civ4_target.values())[0]
        civ4_ability = civ4_ability.replace('UNITCOMBAT', 'PROMOTION_CLASS')
        mod_name = f"MODIFIER_{name}_SLAVE_TAKING_MODIFIER"
        modifiers = [{'ModifierId': mod_name,
                      'ModifierType': 'MODIFIER_UNIT_ADJUST_PROPERTY'}]
        modifier_args = [{'ModifierId': modifiers[0]['ModifierId'], 'Name': 'Key', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': 'HeroResurrectKill'},
                         {'ModifierId': modifiers[0]['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': 1}]
        req_id = f'OPPONENT_{civ4_ability}_REQUIREMENT'
        master_req_set = f'{req_id}_SET'
        modifiers[0]['SubjectRequirementSetId'] = master_req_set
        requirements = [{'RequirementId': req_id,
                         'RequirementType': 'REQUIREMENT_OPPONENT_UNIT_PROMOTION_CLASS_MATCHES'}]
        requirement_arguments = [{'RequirementId': req_id, 'Name': 'UnitPromotionClass',
                                  'Type': 'ARGTYPE_IDENTITY', 'Value': f'PROMOTION_CLASS_{civ4_ability}'}]
        requirement_sets = [{'RequirementSetId': master_req_set, 'RequirementSetType': 'REQUIREMENTSET_TEST_ALL'}]
        req_set_reqs = [{'RequirementSetId': master_req_set, 'RequirementId': req_id}]
        loc = [f'LOC_{name}_DESCRIPTION', [f'Captures defeated {civ4_ability.replace("PROMOTION_CLASS_","").capitalize()} units']]
        self.modifier_obj.organize(modifiers, modifier_args, requirements=requirements,
                                   requirements_set=requirement_sets, loc=loc,
                                   requirements_arguments=requirement_arguments, requirements_set_reqs=req_set_reqs)
        return mod_name

    def subdue_beast(self, civ4_target, name):
        return self.capture_ability_with_class(civ4_target, name, 'BEAST')

    def subdue_animal(self, civ4_target, name):
        return self.capture_ability_with_class(civ4_target, name, 'ANIMAL')

    def pursuit(self, civ4_target, name):
        civ4_name, civ4_ability = list(civ4_target.keys())[0], list(civ4_target.values())[0]
        mod_name = f"MODIFIER_{name}_MOVEMENT"
        modifier = {'ModifierId': mod_name,
                    'ModifierType': 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT'
                    }
        modifier_args = [{'ModifierId': modifier['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_ability}]
        loc = [f'LOC_{name}_DESCRIPTION', [f'+{civ4_ability}[ICON_Movement] Movement.']]
        self.modifier_obj.organize(modifier=modifier, modifier_arguments=modifier_args, loc=loc)
        return mod_name

    def helmsman(self, civ4_target, name):
        return self.pursuit(civ4_target, name)

    def redeploy(self, civ4_target, name):
        return self.pursuit(civ4_target, name)

    def shells(self, civ4_target, name):
        return self.combat(civ4_target, name, require='SHELLS_REQUIREMENTS', loc_info='against District Defenses.')

    def on_attack_bonus(self, civ4_target, name):
        return self.combat(civ4_target, name, require='UNIT_STRONG_WHEN_ATTACKING_REQUIREMENTS', loc_info='while attacking')

    def on_defense_bonus(self, civ4_target, name):
        return self.combat(civ4_target, name, requireset='PLAYER_IS_DEFENDER_REQUIREMENTS', loc_info='while defending')

    def garrison(self, civ4_target, name):
        return self.combat(civ4_target, name, require='GARRISON_REQUIREMENTS', loc_info='while in a District')

    def marauding(self, civ4_target, name):
        return self.combat(civ4_target, name, require='URBAN_RAIDER_REQUIREMENTS', loc_info= 'while fighting in a District')

    def ability_terrain_all(self, civ4_target, name):
        civ4_name, civ4_ability = list(civ4_target.keys())[0], list(civ4_target.values())[0]
        amount, modifiers, modifier_args, requirements, requirement_arguments, req_set_reqs = 0, [], [], [], [], []
        ability_modifiers = []
        requirement_sets = []
        if not isinstance(civ4_ability, list):
            civ4_ability = [civ4_ability]
        attacks = set([i['iTerrainAttack'] for i in civ4_ability])
        if len(attacks) > 1:
            print(' do some iterated versionahh')
        else:
            amount = attacks.pop()
        ability_name = f'{name}_ABILITY_{civ4_name.upper()}'

        for idx, i in enumerate(civ4_ability):
            terrain = i['TerrainType'].split('_')[1]
            modifiers.append({'ModifierId': f"MODIFIER_{ability_name}_{terrain}",
                              'ModifierType': 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH',
                              'SubjectRequirementSetId': f'{ability_name}_REQS'})
            modifier_args.append(
                {'ModifierId': modifiers[idx]['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                 'Value': amount})
            requirements.append({'RequirementId': f'PLOT_IS_{terrain}_REQUIREMENT',
                                 'RequirementType': 'REQUIREMENT_PLOT_TERRAIN_TYPE_MATCHES'})

            requirement_arguments.append(
                {'RequirementId': requirements[idx]['RequirementId'], 'Name': 'TerrainType',
                 'Type': 'ARGTYPE_IDENTITY',
                 'Value': i['TerrainType']})
            requirement_sets.append({'RequirementSetId': modifiers[idx]['SubjectRequirementSetId'],
                                     'RequirementSetType': 'REQUIREMENTSET_TEST_ANY'})
            for req in requirements:
                req_set_reqs.append({'RequirementSetId': modifiers[idx]['SubjectRequirementSetId'],
                                     'RequirementId': req['RequirementId']})

        ability, ability_modifiers, type_tags = ability_and_modifier_attach(ability_name, modifiers, modifier_args)
        loc = [f'LOC_{name}_DESCRIPTION', [f'+{amount}[ICON_Strength] Combat Strength while on {terrain.capitalize()}.']]
        # BUG for plural abilities this will only attach first!
        self.modifier_obj.organize(modifiers, modifier_args, requirements=requirements, requirements_arguments=requirement_arguments,
                      requirements_set=requirement_sets, requirements_set_reqs=req_set_reqs, ability=ability,
                      ability_modifiers=ability_modifiers, type_tags=type_tags, loc=loc)
        return modifiers[-1]['ModifierId']

    def ability_terrain_movebuff(self, civ4_target, name):                      # MOVEBUFFS HAVE FAILED REQS
        civ4_name, civ4_ability = list(civ4_target.keys())[0], list(civ4_target.values())[0]
        ability_name = f'{name}_ABILITY_{civ4_name.upper()}'
        amount = 1
        ability_modifiers = []
        terrain = civ4_ability['TerrainType'].split('_')[1]
        # set up ability
        modifiers = [{'ModifierId': f"MODIFIER_{ability_name}",
                      'ModifierType': 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT',
                      'SubjectRequirementSetId': f'{ability_name}_REQS'}]
        modifier_args = [{'ModifierId': modifiers[0]['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': amount}]

        requirements = [{'RequirementId': f'PLOT_IS_{terrain}_REQUIREMENT',
                         'RequirementType': 'REQUIREMENT_PLOT_TERRAIN_TYPE_MATCHES'},
                        {'RequirementId': f'PLOT_IS_{terrain}_HILLS_REQUIREMENT',
                         'RequirementType': 'REQUIREMENT_PLOT_TERRAIN_TYPE_MATCHES'}
                        ]

        requirement_arguments = [
            {'RequirementId': requirements[0]['RequirementId'], 'Name': 'TerrainType', 'Type': 'ARGTYPE_IDENTITY',
             'Value': civ4_ability['TerrainType']},
            {'RequirementId': requirements[1]['RequirementId'], 'Name': 'TerrainType', 'Type': 'ARGTYPE_IDENTITY',
             'Value': f"{civ4_ability['TerrainType']}_HILLS"}
        ]

        requirement_sets = [{'RequirementSetId': modifiers[0]['SubjectRequirementSetId'],
                             'RequirementSetType': 'REQUIREMENTSET_TEST_ANY'}]

        req_set_reqs = [{'RequirementSetId': modifiers[0]['SubjectRequirementSetId'],
                         'RequirementId': requirements[0]['RequirementId']},
                        {'RequirementSetId': modifiers[0]['SubjectRequirementSetId'],
                        'RequirementId': requirements[1]['RequirementId']}]

        # set modifiers on ability
        ability, ability_modifiers, type_tags = ability_and_modifier_attach(ability_name, modifiers, modifier_args)
        loc = [f'LOC_{name}_DESCRIPTION', [f'+{amount}[ICON_Movement] Movement while on {terrain.capitalize()}.']]
        self.modifier_obj.organize(modifiers, modifier_args, requirements=requirements, requirements_arguments=requirement_arguments,
                      requirements_set=requirement_sets, requirements_set_reqs=req_set_reqs, ability=ability,
                      ability_modifiers=ability_modifiers, type_tags=type_tags, loc=loc)
        return modifiers[-1]['ModifierId']

    def ability_feature_movebuff(self, civ4_target, name):                      # MOVEBUFFS HAVE FAILED REQS
        civ4_name, civ4_ability = list(civ4_target.keys())[0], list(civ4_target.values())[0]
        amount, modifiers, modifier_args, requirements, requirement_arguments, req_set_reqs = 1, [], [], [], [], []
        requirement_sets = []
        ability_name = f'{name}_ABILITY_{civ4_name.upper()}'
        if 'FeatureDoubleMove' in civ4_ability:
            civ4_ability = civ4_ability['FeatureDoubleMove']
        for idx, i in enumerate(civ4_ability):
            feature = i['FeatureType'].split('_')[1]
            if 'ANCIENT' in i['FeatureType']:
                feature = 'ANCIENT_FOREST'

            modifiers.append({'ModifierId': f"MODIFIER_{ability_name}_{feature}",
                              'ModifierType': 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT',
                              'SubjectRequirementSetId': f'{ability_name}_{feature}_REQS'})
            modifier_args.append(
                {'ModifierId': modifiers[idx]['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                 'Value': amount})
            requirements.append({'RequirementId': f'PLOT_IS_{feature}_REQUIREMENT',
                                 'RequirementType': 'REQUIREMENT_PLOT_FEATURE_TYPE_MATCHES'})
            requirement_arguments.append(
                {'RequirementId': requirements[idx]['RequirementId'], 'Name': 'FeatureType', 'Type': 'ARGTYPE_IDENTITY',
                 'Value': i['FeatureType']})
            requirement_sets.append({'RequirementSetId': modifiers[idx]['SubjectRequirementSetId'],
                                     'RequirementSetType': 'REQUIREMENTSET_TEST_ANY'})
            for req in requirements:
                req_set_reqs.append({'RequirementSetId': modifiers[idx]['SubjectRequirementSetId'],
                                     'RequirementId': req['RequirementId']})

        ability, ability_modifiers, type_tags = ability_and_modifier_attach(ability_name, modifiers, modifier_args)
        loc = [f'LOC_{name}_DESCRIPTION', [f'+{amount}[ICON_Movement] Movement while on {feature.capitalize()}.']]
        self.modifier_obj.organize(modifiers, modifier_args, requirements=requirements, requirements_arguments=requirement_arguments,
                      requirements_set=requirement_sets, requirements_set_reqs=req_set_reqs, ability=ability,
                      ability_modifiers=ability_modifiers, type_tags=type_tags, loc=loc)
        return modifiers[-1]['ModifierId']

    def ability_hills_movebuff(self, civ4_target, name):
        civ4_name, civ4_ability = list(civ4_target.keys())[0], list(civ4_target.values())[0]
        ability_name = f'{name}_ABILITY_{civ4_name.upper()}'
        amount = 5
        # set up ability
        modifiers = [{'ModifierId': f"MODIFIER_{ability_name}",
                      'ModifierType': 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT',
                      'SubjectRequirementSetId': f'{ability_name}_REQS'}]
        modifier_args = [{'ModifierId': modifiers[0]['ModifierId'], 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': amount}]
        terrains = ['GRASS_HILLS', 'PLAINS_HILLS', 'DESERT_HILLS', 'TUNDRA_HILLS', 'SNOW_HILLS']
        requirements = [{'RequirementId': f'PLOT_IS_{i}_TERRAIN_REQUIREMENT',
                         'RequirementType': 'REQUIREMENT_PLOT_TERRAIN_TYPE_MATCHES'} for i in terrains]

        requirement_arguments = [
            {'RequirementId': i['RequirementId'], 'Name': 'TerrainType', 'Type': 'ARGTYPE_IDENTITY',
             'Value': f'TERRAIN_{terrains[idx]}'}
            for idx, i in enumerate(requirements)]

        requirement_sets = [{'RequirementSetId': modifiers[0]['SubjectRequirementSetId'],
                             'RequirementSetType': 'REQUIREMENTSET_TEST_ANY'}]

        req_set_reqs = [{'RequirementSetId': modifiers[0]['SubjectRequirementSetId'],
                         'RequirementId': i['RequirementId']} for i in requirements]

        # set up attachment
        ability, ability_modifiers, type_tags = ability_and_modifier_attach(ability_name, modifiers, modifier_args)
        loc = [f'LOC_{name}_DESCRIPTION', [f'+{amount}[ICON_Movement] Movement while on Hills.']]
        self.modifier_obj.organize(modifiers, modifier_args, requirements=requirements, requirements_arguments=requirement_arguments,
                      requirements_set=requirement_sets, requirements_set_reqs=req_set_reqs, ability=ability,
                      ability_modifiers=ability_modifiers, type_tags=type_tags, loc=loc)
        return modifiers[-1]['ModifierId']

    def ability_terrain_or_feature_combat(self, civ4_target, name, combat='ATTACKER', plot_req_type='TerrainType'):
        name = name[10:]
        civ4_name, civ4_ability = list(civ4_target.keys())[0], list(civ4_target.values())[0]
        amount, modifiers, modifier_args, requirements, requirement_arguments, req_set_reqs = 0, [], [], [], [], []
        requirement_sets = []
        if isinstance(civ4_ability, str) or isinstance(civ4_ability, int):
            amount = civ4_ability
        else:
            if not isinstance(civ4_ability, list):
                if 'FeatureAttack' in civ4_ability:
                    civ4_ability = civ4_ability['FeatureAttack']
                    attacks = set([i['iFeatureAttack'] for i in civ4_ability])
                elif 'FeatureDefense' in civ4_ability:
                    civ4_ability = civ4_ability['FeatureDefense']
                    attacks = set([i['iFeatureDefense'] for i in civ4_ability])
                else:
                    civ4_ability = [civ4_ability]
                    attacks = set([i['iFeatureAttack'] for i in civ4_ability])
            else:
                attacks = set([i['iFeatureAttack'] for i in civ4_ability])
            if len(attacks) > 1:
                self.logger.debug(' do some iterated versionahh')
            else:
                amount = attacks.pop()
        ability_name = f'{name}_ABILITY_{civ4_name.upper()}'
        mod_ability = f"MODIFIER_{ability_name}"
        master_req_set = f'{ability_name}_REQS'
        modifiers.append({'ModifierId': mod_ability, 'ModifierType': 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH',
                          'SubjectRequirementSetId': master_req_set})
        modifier_args.append({'ModifierId': mod_ability, 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY', 'Value': amount})
        for idx, i in enumerate(civ4_ability):
            plot_type = i[plot_req_type].split('_')[1]
            requirements.append({'RequirementId': f'PLOT_IS_{plot_type}_REQUIREMENT',
                                 'RequirementType': 'REQUIREMENT_PLOT_FEATURE_TYPE_MATCHES'})
            requirement_arguments.append(
                {'RequirementId': requirements[idx]['RequirementId'], 'Name': 'FeatureType',
                 'Type': 'ARGTYPE_IDENTITY', 'Value': i['FeatureType']})

        terrain_satisfied = f"{master_req_set}_TERRAIN_SATISFIED"
        requirement_sets.append({'RequirementSetId': terrain_satisfied,
                                 'RequirementSetType': 'REQUIREMENTSET_TEST_ANY'})
        for req in requirements:
            req_set_reqs.append({'RequirementSetId': terrain_satisfied,
                                 'RequirementId': req['RequirementId']})

        requirement_terrain_satisfied = f'{terrain_satisfied}_SET'
        requirements.append({'RequirementId': requirement_terrain_satisfied,
                             'RequirementType': 'REQUIREMENT_IS_MET'})
        requirement_arguments.append({'RequirementId': requirement_terrain_satisfied, 'Name': 'RequirementSetId',
                                      'Type': 'ARGTYPE_IDENTITY', 'Value': terrain_satisfied})

        requirement_sets.append({'RequirementSetId': master_req_set, 'RequirementSetType': 'REQUIREMENTSET_TEST_ALL'})
        req_set_reqs.extend([{'RequirementSetId': master_req_set, 'RequirementId': f'PLAYER_IS_{combat}_REQUIREMENTS'},
                             {'RequirementSetId': master_req_set, 'RequirementId': requirement_terrain_satisfied}])

        ability, ability_modifiers, type_tags = ability_and_modifier_attach(ability_name, modifiers, modifier_args)
        loc = [f'LOC_{name}_DESCRIPTION', [f'+{amount}[ICON_Strength] Combat Strength while on {plot_type.capitalize()}.']]

        self.modifier_obj.organize(modifiers, modifier_args, requirements=requirements, requirements_arguments=requirement_arguments,
                      requirements_set=requirement_sets, requirements_set_reqs=req_set_reqs, ability=ability,
                      ability_modifiers=ability_modifiers, type_tags=type_tags, loc=loc)
        return modifiers[-1]['ModifierId']

    def ability_terrain_defense(self, civ4_target, name):
        return self.ability_terrain_or_feature_combat(civ4_target, name, combat='DEFENDER')

    def ability_feature_attack(self, civ4_target, name):
        return self.ability_terrain_or_feature_combat(civ4_target, name, plot_req_type='FeatureType')

    def ability_feature_defense(self, civ4_target, name):
        return self.ability_terrain_or_feature_combat(civ4_target, name, combat='DEFENDER', plot_req_type='FeatureType')

    def ability_buff_unit_type(self, ability_name, buff_type, amount):
        mod_name = f"MODIFIER_{ability_name}"
        modifiers = [{'ModifierId': mod_name,
                      'ModifierType': buff_type}]
        modifier_args = [{'ModifierId': mod_name, 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': amount}]
        return modifiers, modifier_args

    def ability_trait(self, ability_name, trait_name):
        ability = {'UnitAbilityType': ability_name, 'Name': f'LOC_SLTH_{ability_name}_NAME',
                   'Description': f'LOC_{ability_name}_DESCRIPTION', 'Inactive': 1,
                   'ShowFloatTextWhenEarned': 0, 'Permanent': 1}
        modifiers = [{'ModifierId': trait_name,
                          'ModifierType': 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY'}]
        modifier_args = [{"ModifierId": trait_name, "Name": "AbilityType",
                              "Type": "ARGTYPE_IDENTITY", "Value": ability_name}]
        return ability, modifiers, modifier_args

    def ability_scout_buff(self, civ4_target, name, promoclass='CLASS_RECON'):
        civ4_name, civ4_ability = list(civ4_target.keys())[0], list(civ4_target.values())[0]
        ability_name = f'{name}_ABILITY_{civ4_name.upper()}'
        trait_mod_name = f"TRAIT_{ability_name}"
        amount = 5
        modifiers, modifier_args = self.ability_buff_unit_type(ability_name, 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', amount)
        ability, ab_modifiers, ab_mod_args = self.ability_trait(ability_name, trait_mod_name)
        modifiers, modifier_args = modifiers + ab_modifiers, modifier_args + ab_mod_args
        ability_modifiers = []
        for i in modifiers[:-1]:
            ability_modifiers.append({'UnitAbilityType': ability_name, 'ModifierId': i['ModifierId']})
        type_tags = {'Type': ability_name, 'Tag': promoclass}
        loc = [f'LOC_{name}_DESCRIPTION', [f'+{amount}[ICON_STRENGTH] Combat Strength.']]

        self.modifier_obj.organize(modifiers, modifier_args, ability=ability, ability_modifiers=ability_modifiers,
                                   type_tags=type_tags, loc=loc)
        return trait_mod_name

    def ability_ranged_buff(self, civ4_target, name):
        return self.ability_scout_buff(civ4_target, name, promoclass='CLASS_RANGED')

    def trait_agnostic(self, civ4_target, name):
        print(f"{name}'s {civ4_target} not implemented, use Mvemba? + NULL replace religious units")

    def trait_horselord(self, civ4_target, name):
        civ4_name, civ4_ability = list(civ4_target.keys())[0], list(civ4_target.values())[0]
        ability_name = f'{name}_ABILITY_{civ4_name.upper()}'
        trait_mod_name = f"TRAIT_{ability_name}"
        combat_amount, move_amount = 5, 1
        modifiers, modifier_args = self.ability_buff_unit_type(ability_name, 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', combat_amount)
        mod_move, mod_move_args = self.ability_buff_unit_type(f'{ability_name}_MOVE', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', move_amount)
        ability, ab_modifiers, ab_mod_args = self.ability_trait(ability_name, trait_mod_name)
        modifiers, modifier_args = modifiers + mod_move + ab_modifiers, modifier_args + mod_move_args + ab_mod_args
        type_tags = {'Type': ability_name, 'Tag': 'CLASS_LIGHT_CAVALRY'}
        ability_modifiers = []
        for i in modifiers[:-1]:
            ability_modifiers.append({'UnitAbilityType': ability_name, 'ModifierId': i['ModifierId']})
        loc = [f'LOC_{name}_DESCRIPTION', [f'+{move_amount}[ICON_Movement] Movement, +{combat_amount}[ICON_Strength] Combat Strength.']]
        self.modifier_obj.organize(modifiers, modifier_args, ability=ability, ability_modifiers=ability_modifiers,
                      type_tags=type_tags, loc=loc)
        return modifiers[-1]['ModifierId']

    def one_of_unit_setter(self, civ4_target, name):
        # give unit an ability.
        # the ability on spawning attachs a modifier to all players, permananent, once.
        # that modifier bans players from using it.
        civ4_name = list(civ4_target.values())[0]
        ability_name = f'{name}_ABILITY_{civ4_name.upper()}'
        modifiers = [{'ModifierId': f"MODIFIER_{ability_name}", 'ModifierType': 'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER',
                      'RunOnce': 1, 'Permanent': 1},
                     {'ModifierId': f'TRAIT_CANT_BUILD_HERO_{civ4_name.upper()}', 'ModifierType': 'MODIFIER_PLAYER_UNIT_BUILD_DISABLED'}]
        modifier_args = [{'ModifierId': modifiers[0]['ModifierId'], 'Name': 'ModifierId', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': modifiers[1]['ModifierId']},
                         {'ModifierId': modifiers[1]['ModifierId'], 'Name': 'UnitType', 'Type': 'ARGTYPE_IDENTITY',
                          'Value': civ4_name}]
        ability = {'UnitAbilityType': ability_name, 'Name': f'LOC_SLTH_{ability_name}_NAME',
                   'Description': f'LOC_{ability_name}_DESCRIPTION', 'Inactive': 0,
                   'ShowFloatTextWhenEarned': 0, 'Permanent': 0}
        ability_modifier = {'UnitAbilityType': ability_name, 'ModifierId': modifiers[0]['ModifierId']}
        tags = {'Tag': f'SLTH_CLASS_{civ4_name.upper()}', 'Vocabulary': 'ABILITY_CLASS'}
        type_tags = [{'Type': ability_name, 'Tag': tags['Tag']},
                     {'Type': civ4_name, 'Tag': tags['Tag']}]

        self.modifier_obj.organize(modifiers, modifier_args, ability=ability, ability_modifiers=ability_modifier, tags=tags,
                      type_tags=type_tags)
        return

    def amphibious(self, civ4_target, name):
        return 'AMPHIBIOUS_BONUS_IGNORE_SHORES'

    def river(self, civ4_target, name):
        return 'AMPHIBIOUS_BONUS_IGNORE_RIVERS'

    def blitz(self, civ4_target, name):
        return 'ELITE_GUARD_ADDITIONAL_ATTACK'

    def gold_from_combat(self, civ4_target, name):
        return 'BOARDING_GOLD_FROM_NAVAL_VICTORY'

    def combat_heal_after(self, civ4_target, name):
        promo_mod = f'MODIFIER_{name}'
        self.remake_modifier(promo_mod, 'TOMYRIS_HEAL_AFTER_DEFEATING_UNIT', {'ModifierArguments': {'Value': civ4_target['iCombatHealPercent']}})
        return promo_mod

    def force_retreat(self, civ4_target, name):
        return 'HUSSAR_FORCE_RETREAT'

    def hill_defense(self, civ4_target, name):
        civ4_name, civ4_ability = list(civ4_target.keys())[0], list(civ4_target.values())[0]
        promo_mod = f'MODIFIER_{name}'
        master_req_set = f'{name}_REQS'
        modifiers = [{'ModifierId': promo_mod, 'ModifierType': 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH',
                          'SubjectRequirementSetId': master_req_set}]
        modifier_args = [{'ModifierId': promo_mod, 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY', 'Value': civ4_ability}]

        requirement_sets = [{'RequirementSetId': master_req_set, 'RequirementSetType': 'REQUIREMENTSET_TEST_ALL'}]
        req_set_reqs = [{'RequirementSetId': master_req_set, 'RequirementId': 'PLAYER_IS_DEFENDER_REQUIREMENTS'},
                        {'RequirementSetId': master_req_set, 'RequirementId': 'PLOT_IS_HILLS_REQUIREMENT'}]
        loc = [f'LOC_{name}_DESCRIPTION', [f'+{civ4_ability}[ICON_Strength] Combat Strength while on Hills.']]
        self.modifier_obj.organize(modifiers, modifier_args, requirements_set=requirement_sets,
                                   requirements_set_reqs=req_set_reqs, loc=loc)
        return promo_mod

    def remake_modifier(self, modifier, original, change):
        modifier_table = pd.read_csv('data/tables/modifiers.csv')
        modifier_table_args = pd.read_csv('data/tables/modifierArguments.csv')
        modifier_strings = pd.read_csv('data/tables/modifierStrings.csv')
        mod_existing = modifier_table[modifier_table['ModifierId'] == original]
        mod_arg_existing = modifier_table_args[modifier_table_args['ModifierId'] == original]
        modifier_object = {'Modifiers': [], 'ModifierArguments': []}
        for index, row in mod_existing.iterrows():
            row['ModifierId'] = modifier
            row.fillna('NULL', inplace=True)
            modifier_object['Modifiers'].append(row.to_dict())
        for index, row in mod_arg_existing.iterrows():
            row['ModifierId'] = modifier
            row.fillna('NULL', inplace=True)
            modifier_object['ModifierArguments'].append(row.to_dict())
        for table, ch in change.items():
            for col, val in ch.items():
                for j in modifier_object[table]:
                    j[col] = val
        #loc = [f'LOC_{name}_DESCRIPTION', [f'+{amount}[ICON_Movement] Movement while on {feature.capitalize()}.']]
        self.modifier_obj.organize(modifier_object['Modifiers'], modifier_object['ModifierArguments'])

    def heal_every_move(self, civ4_target, name):
        promo_mod = f'MODIFIER_{name}'
        modifiers = [{"ModifierId": promo_mod, "ModifierType": "MODIFIER_PLAYER_UNIT_GRANT_HEAL_AFTER_ACTION"}]
        loc = [f'LOC_{name}_DESCRIPTION', ['Always heal at end of turn.']]
        self.modifier_obj.organize(modifiers, loc=loc)
        return promo_mod

    def spyglass(self, civ4_target, name):
        return 'SPYGLASS_BONUS_SIGHT'

    def heal_allies(self, civ4_target, name):
        return 'MEDIC_INCREASE_HEAL_RATE'

    def heal_territory(self, civ4_target, name):
        value = civ4_target['iEnemyHealChange']
        promo_mod = f'MODIFIER_{name}'
        modifiers = [{"ModifierId": promo_mod, "ModifierType": "MODIFIER_PLAYER_UNIT_GRANT_HEAL_AFTER_ACTION"}]
        modifier_args = [{"ModifierId": promo_mod, "Name": "Type",
                          "Type": "ARGTYPE_IDENTITY", "Value": "ALL"},
                         {"ModifierId": promo_mod,
                          "Name": "Amount", "Type": "ARGTYPE_IDENTITY", "Value": value}]
        loc = [f'LOC_{name}_DESCRIPTION', [f'+{value} Healing in any territory.']]
        self.modifier_obj.organize(modifiers, modifier_args, loc=loc)
        return promo_mod

    def grant_ability_mana(self, civ4_target, name):
        civ4_name, civ4_ability = list(civ4_target.keys())[0], list(civ4_target.values())[0]
        ability_name = f'{name}_ABILITY_GRANT_SPELL'
        trait_mod_name = f"TRAIT_{ability_name}"
        require_id = f'REQUIRES_PLAYER_HAS_{name}'
        require_set = f'PLAYER_HAS_{name}'
        modifiers, modifier_args = self.ability_buff_unit_type(ability_name, 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 1)
        ability, ab_modifiers, ab_mod_args = self.ability_trait(ability_name, trait_mod_name)
        modifiers, modifier_args = modifiers + ab_modifiers, modifier_args + ab_mod_args
        ability_modifiers = []
        for i in modifiers[:-1]:
            ability_modifiers.append({'UnitAbilityType': ability_name, 'ModifierId': i['ModifierId']})
        type_tags = {'Type': ability_name, 'Tag': 'CLASS_ADEPT'}
        modifiers[1]['SubjectRequirementSetId'] = require_set
        requirements = [{'RequirementId': require_id,
                         'RequirementType': 'REQUIREMENT_PLAYER_HAS_RESOURCE_OWNED', 'ProgressWeight': '1'}]
        requirements_arguments = [{'RequirementId': require_id, 'Name': 'ResourceType',
                                   'Type': 'ARGTYPE_IDENTITY', 'Value': f'{name}'}]
        requirements_set = [{'RequirementSetId': require_set,
                             'RequirementSetType': 'REQUIREMENTSET_TEST_ALL'}]
        requirement_set_requirements = [{'RequirementSetId': require_set,
                                         'RequirementId': require_id}]

        self.modifier_obj.organize(modifiers, modifier_args, ability=ability, ability_modifiers=ability_modifiers,
                                   type_tags=type_tags, requirements=requirements,
                                   requirements_arguments=requirements_arguments, requirements_set=requirements_set,
                                   requirements_set_reqs=requirement_set_requirements)
        return trait_mod_name


    def not_implemented_effect(self, civ4_target, name):
        print('not implemented as is a temporary spell effect. Use Requirement Likeliness?')


    def not_implemented_sphere(self, civ4_target, name):
        print('not implemented as is a magic sphere')

    def not_implemented_equipment(self, civ4_target, name):
        print('not implemented as is a a part of equipment module')

    def not_implemented_damage_types(self, civ4_target, name):
        print(f"{name}'s {civ4_target} not implemented as needs Magic module")

    def race(self, civ4_target, name):
        print(f"{name}'s {civ4_target} already made in civilizatins kinda, we should port to here")

    def easyimplement(self, civ4_target, name):
        print(f"{name}'s {civ4_target} should be easy to make")

    def hardimplement(self, civ4_target, name):
        print(f"{name}'s {civ4_target} should be hard to make")

    def ability_sundered(self, civ4_target, name):
        print(f"{name}'s {civ4_target} not implemented, as needs argageddon module to function")

    def trait_fallow(self, civ4_target, name):
        print(f"{name}'s {civ4_target} not implemented, as no food growth/loss seems hard to do. Maybe just SETS food to 0, not negative, not positive?")

    def concept_out_of_civ_implement(self, civ4_target, name):
        print(f"{name}'s {civ4_target} doesnt make sense in civ vi")

    def existsalready(self, civ4_target, name):
        print(f"{name}'s {civ4_target} already has a feature in base game")

    def ship_refitting(self, civ4_target, name):
        print(f"{name}'s {civ4_target}, Not implemented, ship refitting stuff module")

    def armageddon(self, civ4_target, name):
        print(f"{name}'s {civ4_target}, Not implemented, armageddon module")

    def effect_conditional_end(self, civ4_target, name):
        print(f"{name}'s {civ4_target}, Not implemented, effect module but needs detached")

    def buff_by_resource(self, civ4_target, name):
        print(f"{name}'s {civ4_target}, Not implemented, resource buff module")

    def no_clue(self, civ4_target, name):
        print(f"{name}'s {civ4_target}, uhhh no idea")



def ability_and_modifier_attach(ability_name, modifiers, modifier_args):
    # set modifiers on ability
    ability, ability_modifiers, type_tags = ability_set(ability_name, modifiers)
    grant_modifier = {'ModifierId': f"TRAIT_GRANT_{ability_name}",
                      'ModifierType': 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY_GRANCOLOMBIA_MAYA'}
    modifiers.append(grant_modifier)
    modifier_args.append({'ModifierId': grant_modifier['ModifierId'], 'Name': 'AbilityType',
                          'Type': 'ARGTYPE_IDENTITY', 'Value': ability_name})
    return ability, ability_modifiers, type_tags


def ability_set(ability_name, modifiers):
    ability = {'UnitAbilityType': ability_name, 'Name': f'LOC_SLTH_{ability_name}_NAME',
               'Description': f'LOC_{ability_name}_DESCRIPTION', 'Inactive': 1,
               'ShowFloatTextWhenEarned': 0, 'Permanent': 1}
    ability_modifiers = []
    for mod_ in modifiers:
        ability_modifiers.append({'UnitAbilityType': ability_name, 'ModifierId': mod_['ModifierId']})
    type_tags = {'Type': ability_name, 'Tag': 'CLASS_ALL_UNITS'}
    return ability, ability_modifiers, type_tags
