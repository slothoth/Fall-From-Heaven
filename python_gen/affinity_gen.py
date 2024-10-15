mod_palace = "('BUILDING_PALACE', 'MODIFIER_GRANT_$1_DAMAGE_$3'),"

mod = "('MODIFIER_GRANT_$1_DAMAGE_$3', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 'PLAYER_HAS_$1_MANA_$3'),"

req_unit = "('UNIT_HAS_$1_AFFINITY_TAG', 'REQUIREMENT_UNIT_TAG_MATCHES'),"

req_arg_unit = "('UNIT_HAS_$1_AFFINITY_TAG', 'Tag', 'CLASS_AFFINITY_$1'),"

req_set_req_unit = "('UNIT_HAS_$1_AFFINITY', 'UNIT_HAS_$1_AFFINITY_TAG'),"

req_set_unit = "('UNIT_HAS_$1_AFFINITY', 'REQUIREMENTSET_TEST_ANY'),"

req_plot = "('$1_PLOT_PROP_MORE_THAN_$3', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),"

req_arg_plot = """('$1_PLOT_PROP_MORE_THAN_$3', 'PropertyName','$1_BINARY_$2'),
('$1_PLOT_PROP_MORE_THAN_$3', 'PropertyMinimum','1'),"""

req_set_req_plot = "('PLAYER_HAS_$1_MANA_$3', '$1_PLOT_PROP_MORE_THAN_$3'),"

req_set_plot = "('PLAYER_HAS_$1_MANA_$3', 'REQUIREMENTSET_TEST_ANY'),"

ability = """('ABILITY_$1_ADJUST_DAMAGE_4', 'LOC_ABILITY_ADJUST_DAMAGE_4_NAME', 'LOC_ABILITY_ADJUST_DAMAGE_4_DESCRIPTION', '1', '1'),
('ABILITY_$1_ADJUST_DAMAGE_8', 'LOC_ABILITY_ADJUST_DAMAGE_8_NAME', 'LOC_ABILITY_ADJUST_DAMAGE_8_DESCRIPTION', '1', '1'),
('ABILITY_$1_ADJUST_DAMAGE_16', 'LOC_ABILITY_ADJUST_DAMAGE_8_NAME', 'LOC_ABILITY_ADJUST_DAMAGE_8_DESCRIPTION', '1', '1'),
('ABILITY_$1_ADJUST_DAMAGE_32', 'LOC_ABILITY_ADJUST_DAMAGE_8_NAME', 'LOC_ABILITY_ADJUST_DAMAGE_8_DESCRIPTION', '1', '1'),
('ABILITY_$1_ADJUST_DAMAGE_64', 'LOC_ABILITY_ADJUST_DAMAGE_8_NAME', 'LOC_ABILITY_ADJUST_DAMAGE_8_DESCRIPTION', '1', '1'),"""

ability_mods = """('ABILITY_$1_ADJUST_DAMAGE_4', 'MODIFIER_PROMOTION_COMBAT1'),
('ABILITY_$1_ADJUST_DAMAGE_8', 'AFFINITY_STRENGTH_8'),
('ABILITY_$1_ADJUST_DAMAGE_16', 'AFFINITY_STRENGTH_16'),
('ABILITY_$1_ADJUST_DAMAGE_32', 'AFFINITY_STRENGTH_32'),
('ABILITY_$1_ADJUST_DAMAGE_64', 'AFFINITY_STRENGTH_64'),"""

type_tag = """('ABILITY_$1_ADJUST_DAMAGE_4', 'CLASS_AFFINITY_$1'),
('ABILITY_$1_ADJUST_DAMAGE_8', 'CLASS_AFFINITY_$1'),
('ABILITY_$1_ADJUST_DAMAGE_16', 'CLASS_AFFINITY_$1'),
('ABILITY_$1_ADJUST_DAMAGE_32', 'CLASS_AFFINITY_$1'),
('ABILITY_$1_ADJUST_DAMAGE_64', 'CLASS_AFFINITY_$1'),"""

type_tag_header = ["INSERT INTO TypeTags(Type, Tag) VALUES"]
ability_header = ["INSERT INTO UnitAbilities(UnitAbilityType, Name, Description, Inactive, Permanent) VALUES"]

ability_mod_header = ["INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES"]


jobs = [('AIR', '1'),
('BODY', '1'),
('CHAOS', '1'),
('DEATH', '1'),
('EARTH', '1'),
('ENCHANTMENT', '1'),
('ENTROPY', '1'),
('FIRE', '1'),
('ICE', '1'),
('LAW', '1'),
('LIFE', '1'),
('METAMAGIC', '1'),
('MIND', '1'),
('NATURE', '1'),
('SHADOW', '1'),
('SPIRIT', '1'),
('SUN', '1'),
('WATER', '1'),
('SUN', '2'),
('NATURE', '2')]

mod_palace_header = "INSERT INTO BuildingModifiers(BuildingType, ModifierId) VALUES"

mod_header = "INSERT INTO Modifiers(ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) VALUES"

mod_arg_header = "INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES"

req_unit_header = "INSERT INTO Requirements(RequirementId, RequirementType) VALUES"

req_arg_unit_header = "INSERT INTO RequirementArguments(RequirementId, Name, Value) VALUES"

req_set_req_unit_header = "INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES"

req_set_unit_header = "INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES"

req_plot_header = req_unit_header

req_arg_plot_header = req_arg_unit_header

req_set_req_plot_header = req_set_req_unit_header

req_set_plot_header = req_set_unit_header

typetags = "INSERT INTO TypeTags(Type, Tag) VALUES"

contained_abilities = []
for i in jobs:
    resource = i[0]
    affinity_amount = i[1]
    if affinity_amount == '2':
        mod_arg = "('MODIFIER_GRANT_$1_DAMAGE_$3', 'AbilityType', 'ABILITY_ADJUST_DAMAGE_$4'),"
        mult = 2
    else:
        mod_arg = "('MODIFIER_GRANT_$1_DAMAGE_$3', 'AbilityType', 'ABILITY_ADJUST_DAMAGE_$4'),"
        mult=1

    for binary in ['1', '2', '4', '8']:
        affinity_tag = f'{affinity_amount}_{binary}'
        mod_palace_header += '\n' + mod_palace.replace('$1', resource).replace('$2', binary).replace('$3', affinity_tag)
        mod_header += '\n' + mod.replace('$1', resource).replace('$2', binary).replace('$3', affinity_tag)
        mod_arg_header += '\n' + mod_arg.replace('$1', resource).replace('$2', binary).replace('$3', affinity_tag).replace('$4', str(int(binary) * 4 * mult))
        if binary == '1':
            req_unit_header += '\n' + req_unit.replace('$1', resource).replace('$2', binary).replace('$3', affinity_tag)
            req_arg_unit_header += '\n' + req_arg_unit.replace('$1', resource).replace('$2', binary).replace('$3', affinity_tag)
            req_set_req_unit_header += '\n' + req_set_req_unit.replace('$1', resource).replace('$2', binary).replace('$3', affinity_tag)
            req_set_unit_header += '\n' + req_set_unit.replace('$1', resource).replace('$2', binary).replace('$3', affinity_tag)
        req_plot_header += '\n' + req_plot.replace('$1', resource).replace('$2', binary).replace('$3', affinity_tag)
        req_arg_plot_header += '\n' + req_arg_plot.replace('$1', resource).replace('$2', binary).replace('$3', affinity_tag)
        req_set_req_plot_header += '\n' + req_set_req_plot.replace('$1', resource).replace('$2', binary).replace('$3', affinity_tag)
        req_set_plot_header += '\n' + req_set_plot.replace('$1', resource).replace('$2', binary).replace('$3', affinity_tag)
        new_ab = ability.replace('$1', resource)
        new_ab_mod = ability_mods.replace('$1', resource)
        new_ab_typetag = type_tag.replace('$1', resource)

        if new_ab not in ability_header:
            ability_header.append(new_ab)
        if new_ab_mod not in ability_mod_header:
            ability_mod_header.append(new_ab_mod)
        if new_ab_typetag not in type_tag_header:
            type_tag_header.append(new_ab_typetag)



full_ab = "\n".join(ability_header) + ";" + "\n".join(ability_mod_header) + ";" + "\n".join(type_tag_header) + ";"
mod_palace_header = mod_palace_header[:-1] + ';\n'
mod_header = mod_header[:-1] +  ';\n'
mod_arg_header = mod_arg_header[:-1] +  ';\n'
req_unit_header = req_unit_header[:-1] +  ';\n'
req_arg_unit_header = req_arg_unit_header[:-1] +  ';\n'
req_set_req_unit_header = req_set_req_unit_header[:-1] +  ';\n'
req_set_unit_header = req_set_unit_header[:-1] +  ';\n'
req_plot_header = req_plot_header[:-1] + ';\n'
req_arg_plot_header = req_arg_plot_header[:-1] +  ';\n'
req_set_req_plot_header = req_set_req_plot_header[:-1] +  ';\n'
req_set_plot_header = req_set_plot_header[:-1] + ';\n'

full_string = mod_palace_header + mod_header + mod_arg_header + req_unit_header + req_arg_unit_header

full_string += req_set_req_unit_header + req_set_unit_header + req_plot_header + req_arg_plot_header

full_string += req_set_req_plot_header + req_set_req_plot_header

print('')
