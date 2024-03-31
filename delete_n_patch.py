import xmltodict
from utils import small_dict, build_sql_table


def delete_rows(kept, calculated_to_keep):
    delete_string = 'DELETE FROM Technologies;\nDELETE FROM TechnologyPrereqs;\n'
    delete_string += 'DELETE FROM Technologies_XP2;\nDELETE FROM Civics;\nDELETE FROM CivicPrereqs;\n'
    delete_string += 'DELETE FROM Civics_XP2;\n'
    delete_string += 'DELETE FROM Building_GreatPersonPoints;\nDELETE FROM Unit_BuildingPrereqs;\n'
    delete_string += 'DELETE FROM UnitUpgrades;\nDELETE FROM Boosts;\n'
    delete_string += delete_from_gen('Units', 'UnitType', kept['compat_for_VI'] + kept['units_as_is'])
    delete_string += delete_from_gen('Buildings', 'BuildingType', calculated_to_keep + ['BUILDING_PALACE'])
    delete_string += delete_from_gen('Building_YieldChanges', 'BuildingType', ['BUILDING_PALACE'])
    # delete_string += 'DELETE FROM Building_YieldChanges;'

    return delete_string


def patch_string_generate():
    patch_string = ("UPDATE RandomAgendaCivicTags SET CivicType = 'CIVIC_FEUDALISM' "
                    "WHERE CivicType = 'CIVIC_NATIONALISM';\n")
    patch_string += f"DELETE from Routes_XP2 WHERE PrereqTech is 'TECH_STEAM_POWER';\n"
    patch_string += f"UPDATE Resource_Harvests SET PrereqTech = 'TECH_AGRICULTURE' WHERE PrereqTech = 'TECH_POTTERY';\n"

    unit_military_engineer_issues = ['Improvement_ValidBuildUnits', "Route_ValidBuildUnits",
                                     "Building_BuildChargeProductions", "District_BuildChargeProductions"]
    for table in unit_military_engineer_issues:
        patch_string += f"UPDATE {table} SET UnitType = 'UNIT_BUILDER' WHERE UnitType = 'UNIT_MILITARY_ENGINEER';\n"

    return patch_string


def traits_string_generate(trait_types_to_define, kinds):
    traits_string = "INSERT INTO Traits(TraitType, Name, Description, InternalOnly) VALUES"
    for trait in trait_types_to_define:
        traits_string += f"\n('{trait}', '{'LOC_' + trait + '_NAME'}', NULL, 0),"
        kinds[trait] = 'KIND_TRAIT'
    traits_string = traits_string[:-1] + ";\n"

    return traits_string, kinds


def delete_from_gen(table, filter_column, kept_items):
    delete_from_string = f"DELETE FROM {table} WHERE {filter_column} NOT IN ("
    for unit in kept_items:
        delete_from_string += f"'{unit}', "
    return delete_from_string[:-2] + ');\n'
