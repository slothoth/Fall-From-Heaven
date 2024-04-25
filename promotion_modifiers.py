class PromotionModifiers:
    def __init__(self, modifier_obj):
        self.modifier_obj = modifier_obj
        self.promo_map = {'PROMOTION_COMMANDO': self.existsalready,
                          'PROMOTION_AMPHIBIOUS': self.existsalready,
                          'PROMOTION_LOYALTY': self.not_implemented_effect,
                          'PROMOTION_FLYING': self.existsalready,
                          'PROMOTION_DIVINE': self.hardimplement,
                          'PROMOTION_POTENCY': self.hardimplement,
                          'PROMOTION_SENTRY2': self.existsalready,
                          'PROMOTION_KEEN_SIGHT': self.existsalready,
                          'PROMOTION_MARCH': self.existsalready,
                          'PROMOTION_MUTATED': self.not_implemented_effect,
                          'PROMOTION_MORALE': self.not_implemented_effect,
                          'PROMOTION_COMMAND2': self.hardimplement,
                          'PROMOTION_FEAR': self.existsalready,
                          'PROMOTION_DEXTEROUS': self.existsalready,
                          'PROMOTION_CANNIBALIZE': self.easyimplement,
                          'PROMOTION_COURAGE': self.not_implemented_effect,
                          'PROMOTION_VALOR': self.not_implemented_effect,
                          'PROMOTION_PLAGUE_CARRIER': self.hardimplement,
                          'PROMOTION_WOODSMAN2': self.easyimplement,
                          'PROMOTION_EXTENSION1': self.not_implemented_sphere,
                          'PROMOTION_EXTENSION2': self.not_implemented_sphere,
                          'PROMOTION_SUMMONER': self.not_implemented_sphere,
                          'PROMOTION_SUNDERED': self.not_implemented_sphere,
                          'PROMOTION_TWINCAST': self.not_implemented_sphere,
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
                          'PROMOTION_BARRAGE1': self.concept_out_of_civ_implement,
                          'PROMOTION_BARRAGE2': self.concept_out_of_civ_implement,
                          'PROMOTION_BARRAGE3': self.concept_out_of_civ_implement,
                          'PROMOTION_AERONS_CHOSEN': self.concept_out_of_civ_implement,
                          'PROMOTION_GREAT_COMMANDER': self.concept_out_of_civ_implement,
                          'PROMOTION_INVISIBLE': self.easyimplement,
                          'PROMOTION_HERO': self.easyimplement,
                          'PROMOTION_HOMELAND':  self.easyimplement,
                          'PROMOTION_COMMAND1': self.hardimplement,
                          'PROMOTION_COMMAND3': self.hardimplement,
                          'PROMOTION_COMMAND4': self.hardimplement,
                          'PROMOTION_ILLUSION': self.hardimplement,
                          'PROMOTION_IMMORTAL': self.hardimplement,
                          'PROMOTION_UNHOLY_TAINT': self.hardimplement,
                          'PROMOTION_STARTING_SETTLER': self.easyimplement,
                          'PROMOTION_WOODSMAN1': self.easyimplement,
                          'PROMOTION_STONESKIN': self.effect_conditional_end,
                          'PROMOTION_DANCE_OF_BLADES': self.not_implemented_effect, 'PROMOTION_BLUR': self.not_implemented_effect,
                          'PROMOTION_FAIR_WINDS': self.not_implemented_effect, 'PROMOTION_HASTED': self.not_implemented_effect,
                          'PROMOTION_HELD': self.not_implemented_effect, 'PROMOTION_FATIGUED': self.not_implemented_effect,
                          'PROMOTION_SHADOWWALK': self.not_implemented_effect,
                          'PROMOTION_SLOW': self.not_implemented_effect, 'PROMOTION_WARCRY': self.not_implemented_effect,
                          'PROMOTION_BURNING_BLOOD': self.not_implemented_effect, 'PROMOTION_CHARMED': self.not_implemented_effect,
                          'PROMOTION_BLESSED': self.effect_conditional_end,
                          'PROMOTION_SHIELD_OF_FAITH': self.effect_conditional_end,
                          'PROMOTION_POISONED': self.effect_conditional_end,
                          'PROMOTION_REGENERATION': self.effect_conditional_end,
                          'PROMOTION_ENCHANTED_BLADE': self.easyimplement,
                          'PROMOTION_CROWN_OF_BRILLANCE': self.effect_conditional_end, 'PROMOTION_RUSTED': self.effect_conditional_end,
                          'PROMOTION_POISONED_BLADE': self.easyimplement, 'PROMOTION_FLAMING_ARROWS': self.easyimplement,
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
                          'PROMOTION_DEATH2': self.not_implemented_sphere, 'PROMOTION_DEATH3': self.not_implemented_sphere,
                          'PROMOTION_EARTH1': self.not_implemented_sphere,
                          'PROMOTION_EARTH2': self.not_implemented_sphere,
                          'PROMOTION_EARTH3': self.not_implemented_sphere,
                          'PROMOTION_FIRE2': self.not_implemented_sphere,
                          'PROMOTION_SPIRIT2': self.not_implemented_sphere,
                          'PROMOTION_ENCHANTMENT1': self.not_implemented_sphere,
                          'PROMOTION_ENCHANTMENT2': self.not_implemented_sphere, 'PROMOTION_ENCHANTMENT3': self.not_implemented_sphere,
                          'PROMOTION_SUN1': self.not_implemented_sphere,
                          'PROMOTION_ENTROPY1': self.not_implemented_sphere,
                          'PROMOTION_ENTROPY2': self.not_implemented_sphere, 'PROMOTION_ENTROPY3': self.not_implemented_sphere,
                          'PROMOTION_CHAOS1': self.not_implemented_sphere,
                          'PROMOTION_CHAOS2': self.not_implemented_sphere,
                          'PROMOTION_CHAOS3': self.not_implemented_sphere,
                          'PROMOTION_MIND2': self.not_implemented_sphere,
                          'PROMOTION_MIND3': self.not_implemented_sphere,
                          'PROMOTION_METAMAGIC1': self.not_implemented_sphere,
                          'PROMOTION_METAMAGIC2': self.not_implemented_sphere, 'PROMOTION_METAMAGIC3': self.not_implemented_sphere,
                          'PROMOTION_NATURE2': self.not_implemented_sphere, 'PROMOTION_NATURE3': self.not_implemented_sphere,
                          'PROMOTION_LAW1': self.not_implemented_sphere,
                          'PROMOTION_SUN2': self.not_implemented_sphere,
                          'PROMOTION_AIR1': self.not_implemented_sphere, 'PROMOTION_AIR2': self.not_implemented_sphere,
                          'PROMOTION_AIR3': self.not_implemented_sphere,
                          'PROMOTION_SHADOW1': self.not_implemented_sphere, 'PROMOTION_SHADOW2': self.not_implemented_sphere,
                          'PROMOTION_SHADOW3': self.not_implemented_sphere,
                          'PROMOTION_SPIRIT3': self.not_implemented_sphere,
                          'PROMOTION_WATER1': self.not_implemented_sphere, 'PROMOTION_WATER2': self.not_implemented_sphere,
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
                          'PROMOTION_GODSLAYER': self.not_implemented_equipment, 'PROMOTION_GOLDEN_HAMMER': self.not_implemented_equipment,
                          'PROMOTION_HEALING_SALVE': self.not_implemented_equipment, 'PROMOTION_INFERNAL_GRIMOIRE': self.not_implemented_equipment,
                          'PROMOTION_JADE_TORC': self.not_implemented_equipment, 'PROMOTION_POTION_OF_INVISIBILITY': self.not_implemented_equipment,
                          'PROMOTION_ROD_OF_WINDS': self.not_implemented_equipment, 'PROMOTION_POTION_OF_RESTORATION': self.not_implemented_equipment,
                          'PROMOTION_SCORCHED_STAFF': self.not_implemented_equipment,
                          'PROMOTION_SYLIVENS_PERFECT_LYRE': self.not_implemented_equipment,
                          'PROMOTION_TIMOR_MASK': self.not_implemented_equipment,
                          'PROMOTION_ACCURACY': self.easyimplement,
                          'PROMOTION_BOUNTY_HUNTER': self.easyimplement,
                          'PROMOTION_CITY_GARRISON1': self.easyimplement,'PROMOTION_CITY_GARRISON2': self.easyimplement,
                          'PROMOTION_CITY_GARRISON3': self.easyimplement,
                          'PROMOTION_CITY_RAIDER1': self.easyimplement,
                          'PROMOTION_CITY_RAIDER2': self.easyimplement, 'PROMOTION_CITY_RAIDER3': self.easyimplement,
                          'PROMOTION_COMBAT1': self.easyimplement,
                          'PROMOTION_COMBAT2': self.easyimplement, 'PROMOTION_COMBAT3': self.easyimplement,
                          'PROMOTION_COMBAT4': self.easyimplement, 'PROMOTION_COMBAT5': self.easyimplement,
                          'PROMOTION_COVER': self.easyimplement,
                          'PROMOTION_COVER2': self.easyimplement,
                          'PROMOTION_HEROIC_DEFENSE': self.easyimplement,
                          'PROMOTION_HEROIC_DEFENSE2': self.easyimplement, 'PROMOTION_HEROIC_STRENGTH': self.easyimplement,
                          'PROMOTION_HEROIC_STRENGTH2': self.easyimplement,
                          'PROMOTION_STRONG': self.easyimplement, 'PROMOTION_WEAK': self.easyimplement,
                          'PROMOTION_MOBILITY1': self.easyimplement, 'PROMOTION_MOBILITY2': self.easyimplement,
                          'PROMOTION_NAVIGATION1': self.easyimplement, 'PROMOTION_NAVIGATION2': self.easyimplement,
                          'PROMOTION_FORMATION': self.easyimplement, 'PROMOTION_FORMATION2': self.easyimplement,
                          'PROMOTION_SHOCK': self.easyimplement, 'PROMOTION_SHOCK2': self.easyimplement,
                          'PROMOTION_SUBDUE_ANIMAL': self.easyimplement, 'PROMOTION_SUBDUE_BEASTS': self.easyimplement,
                          'PROMOTION_UNDEAD_SLAYING': self.easyimplement,'PROMOTION_SCOURGE': self.easyimplement,
                          'PROMOTION_HEAVY': self.easyimplement, 'PROMOTION_LIGHT': self.easyimplement,
                          'PROMOTION_EMPOWER1': self.easyimplement,
                          'PROMOTION_EMPOWER2': self.easyimplement, 'PROMOTION_EMPOWER3': self.easyimplement,
                          'PROMOTION_EMPOWER4': self.easyimplement, 'PROMOTION_EMPOWER5': self.easyimplement,
                          'PROMOTION_GUERILLA1': self.easyimplement,
                          'PROMOTION_GUERILLA2': self.easyimplement,
                          'PROMOTION_BRONZE_WEAPONS': self.buff_by_resource, 'PROMOTION_IRON_WEAPONS': self.buff_by_resource,
                          'PROMOTION_MITHRIL_WEAPONS': self.buff_by_resource,
                          'PROMOTION_NIGHTMARE': self.buff_by_resource, 'PROMOTION_SHEUT_STONE': self.buff_by_resource,
                          'PROMOTION_LONGSHOREMEN': self.ship_refitting, 'PROMOTION_SKELETON_CREW': self.ship_refitting,
                          'PROMOTION_EXPANDED_HULL': self.ship_refitting, 'PROMOTION_BUCCANEERS': self.ship_refitting,
                          'PROMOTION_PROPHECY_MARK': self.armageddon,
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
                   'Description': f'LOC_{ability_name}_DESCRIPTION', 'Inactive': 0,
                   'ShowFloatTextWhenEarned': 0, 'Permanent': 1}
        ability_modifier = {'UnitAbilityType': ability_name, 'ModifierId': modifier['ModifierId']}
        type_tags = {'Type': ability_name, 'Tag': 'CLASS_ADEPT'}
        self.modifier_obj.organize(modifier=modifier, modifier_arguments=modifier_args, ability=ability,
                                   ability_modifiers=ability_modifier, type_tags=type_tags)

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
