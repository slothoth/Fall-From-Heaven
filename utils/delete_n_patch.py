import xmltodict


def delete_rows(kept):
    delete_string = 'DELETE FROM Technologies;\nDELETE FROM TechnologyPrereqs;\n'
    delete_string += 'DELETE FROM Technologies_XP2;\nDELETE FROM Civics;\nDELETE FROM CivicPrereqs;\n'
    delete_string += 'DELETE FROM Civics_XP2;\nDELETE FROM Buildings;\nDELETE FROM Building_YieldChanges;\n'
    delete_string += 'DELETE FROM Building_GreatPersonPoints;\nDELETE FROM Unit_BuildingPrereqs;\n'
    delete_string += 'DELETE FROM UnitUpgrades;\nDELETE FROM Boosts;\n'
    delete_string += f"DELETE FROM Units WHERE UnitType NOT IN ("
    for unit in kept['compat_for_VI']:
        delete_string += f"'{unit}', "
    delete_string = delete_string[:-2] + ');\n'

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


def traits_string_generate(trait_types_to_define, kind_string):
    traits_string = "INSERT INTO Traits(TraitType, Name, Description, InternalOnly) VALUES"
    for trait in trait_types_to_define:
        traits_string += f"\n('{trait}', '{'LOC_' + trait + '_NAME'}', NULL, 0),"
        kind_string += f"\n('{trait}', 'KIND_TRAIT'),"
    traits_string = traits_string[:-1] + ";\n"

    return traits_string, kind_string


def resource_string():
    resource_renames = {'HORSE': 'HORSES', 'GUNPOWDER': 'NITER', 'BANANA': 'BANANAS', 'CORN': 'MAIZE', 'COW': 'CATTLE',
                        'GEMS': 'DIAMONDS', 'CRAB': 'CRABS', 'DYE': 'DYES', 'FUR': 'FURS', 'WHALE': 'WHALES',
                        'PEARL': 'PEARLS'}
    artdef_resources = {'PIG': 'TRUFFLES', 'MITHRIL': 'SILVER', 'FRUIT_OF_YGGDRASIL': 'CITRUS', 'REAGENTS': 'SPICES',
                        'SHEUT_STONE': 'JADE', 'RAZORWEED': 'OLIVES', 'GULAGARM': 'TOBACCO', 'GOLD': 'GYPSUM',
                        'CLAM': 'TURTLES', 'NIGHTMARE': 'AMBER', 'TOAD': 'HONEY'}

    with open('data/CIV4BonusInfos.xml', 'r') as file:
        bonuses_dict = xmltodict.parse(file.read())['Civ4BonusInfos']['BonusInfos']['BonusInfo']
