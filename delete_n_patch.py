import xmltodict
from utils import small_dict


def delete_rows(model_obj, kept):
    delete_string = ''
    delete_string += f"UPDATE MajorStartingUnits SET Unit = 'SLTH_UNIT_WARRIOR' WHERE Unit = 'UNIT_WARRIOR';\n"
    delete_string += 'DELETE FROM Technologies WHERE 1=1;\nDELETE FROM TechnologyPrereqs WHERE 1=1;\n'
    delete_string += 'DELETE FROM Technologies_XP2 WHERE 1=1;\nDELETE FROM Civics WHERE 1=1;\n'
    delete_string += 'DELETE FROM CivicPrereqs WHERE 1=1;\nDELETE FROM Civics_XP2 WHERE 1=1;\n'
    delete_string += 'DELETE FROM Building_GreatPersonPoints WHERE 1=1;\nDELETE FROM Unit_BuildingPrereqs WHERE 1=1;\n'
    delete_string += 'DELETE FROM UnitUpgrades WHERE 1=1;\nDELETE FROM Boosts WHERE 1=1;\n'
    delete_string += 'DELETE FROM UnitPromotionPrereqs WHERE 1=1;\nDELETE FROM UnitPromotionModifiers WHERE 1=1;\n'
    delete_string += 'DELETE FROM Policies WHERE 1=1;\nDELETE FROM UnitPromotions WHERE 1=1;\n'
    delete_string += delete_from_gen('Units', 'UnitType', kept['compat_for_VI'])
    delete_string += delete_from_gen('Buildings', 'BuildingType', model_obj['update_build'] + ['BUILDING_PALACE'])
    delete_string += delete_from_gen('Building_YieldChanges', 'BuildingType', ['BUILDING_PALACE'])
    delete_string += delete_from_gen('UnitPromotionClasses', 'PromotionClassType',
                                     ['PROMOTION_CLASS_MELEE', 'PROMOTION_CLASS_RANGED',
                                      'PROMOTION_CLASS_RECON', 'PROMOTION_CLASS_LIGHT_CAVALRY',
                                      'PROMOTION_CLASS_NAVAL_MELEE', 'PROMOTION_CLASS_SIEGE'])
    delete_string += delete_from_gen('Projects', 'ProjectType',
                                     ['PROJECT_ENHANCE_DISTRICT_ENCAMPMENT', 'PROJECT_ENHANCE_DISTRICT_HARBOR',
                                      'PROJECT_ENHANCE_DISTRICT_INDUSTRIAL_ZONE',
                                      'PROJECT_ENHANCE_DISTRICT_COMMERCIAL_HUB',
                                      'PROJECT_ENHANCE_DISTRICT_HOLY_SITE', 'PROJECT_ENHANCE_DISTRICT_CAMPUS',
                                      'PROJECT_ENHANCE_DISTRICT_THEATER', 'PROJECT_BREAD_AND_CIRCUSES',
                                      'PROJECT_LAUNCH_EARTH_SATELLITE', 'PROJECT_LAUNCH_MOON_LANDING'])         #DEBUG
    delete_string += delete_from_gen('Resources', 'ResourceType', ['RESOURCE_COPPER', 'RESOURCE_IRON', 'RESOURCE_MARBLE', 'RESOURCE_DEER', 'RESOURCE_FISH',
                    'RESOURCE_RICE', 'RESOURCE_SHEEP', 'RESOURCE_WHEAT', 'RESOURCE_INCENSE', 'RESOURCE_IVORY',
                    'RESOURCE_SILK', 'RESOURCE_SUGAR', 'RESOURCE_WINE', 'RESOURCE_COTTON'])
    delete_string += delete_from_gen('Governments', 'GovernmentType', ['GOVERNMENT_AUTOCRACY',
                                                                       'GOVERNMENT_CHIEFDOM'])
    # delete_string += 'DELETE FROM Building_YieldChanges;'
    model_obj['sql_strings'].append(delete_string)
    return delete_string


def patch_string_generate(model_obj_str):
    patch_string = ("UPDATE RandomAgendaCivicTags SET CivicType = 'CIVIC_FEUDALISM' "
                    "WHERE CivicType = 'CIVIC_NATIONALISM';\n")
    patch_string += f"DELETE from Routes_XP2 WHERE PrereqTech is 'TECH_STEAM_POWER';\n"
    patch_string += f"UPDATE Resource_Harvests SET PrereqTech = 'TECH_AGRICULTURE' WHERE PrereqTech = 'TECH_POTTERY';\n"

    unit_military_engineer_issues = ['Improvement_ValidBuildUnits', "Route_ValidBuildUnits",
                                     "Building_BuildChargeProductions", "District_BuildChargeProductions"]
    for table in unit_military_engineer_issues:
        patch_string += f"UPDATE {table} SET UnitType = 'UNIT_BUILDER' WHERE UnitType = 'UNIT_MILITARY_ENGINEER';\n"
    model_obj_str.append(patch_string)


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
