def delete_rows(model_obj, kept):
    dict_insert(model_obj, 'RandomAgendaCivicTags', {'WHERE_COL': 'CivicType', 'WHERE_EQUALS': 'CIVIC_NATIONALISM',
                                                     'SET_COL': 'CivicType', 'SET_EQUALS': 'CIVIC_FEUDALISM'})

    dict_insert(model_obj, 'Resource_Harvests', {'WHERE_COL': 'PrereqTech', 'WHERE_EQUALS': 'TECH_POTTERY',
                                                 'SET_COL': 'PrereqTech', 'SET_EQUALS': 'SLTH_TECH_AGRICULTURE'})

    unit_military_engineer_issues = ['Route_ValidBuildUnits',
                                     'Building_BuildChargeProductions', 'District_BuildChargeProductions']
    for table in unit_military_engineer_issues:
        dict_insert(model_obj, table, {'WHERE_COL': 'UnitType', 'WHERE_EQUALS': 'UNIT_MILITARY_ENGINEER',
                                       'SET_COL': 'UnitType', 'SET_EQUALS': 'UNIT_BUILDER'})


    dict_insert(model_obj, 'Routes_XP2', {'WHERE_COL': 'PrereqTech', 'WHERE_EQUALS': 'TECH_STEAM_POWER'},
                sql_type='deletes')

    # dict_insert(model_obj, 'Beliefs', {'WHERE_COL': 'BeliefType', 'WHERE_EQUALS': 'BELIEF_WARRIOR_MONKS'},
    #            sql_type='deletes')

    dict_insert(model_obj, 'MajorStartingUnits', {'WHERE_COL': 'Unit', 'WHERE_EQUALS': 'UNIT_WARRIOR',
                                                  'SET_COL': 'Unit', 'SET_EQUALS': 'SLTH_UNIT_WARRIOR'})

    delete_full = ['Technologies', 'TechnologyPrereqs', 'Technologies_XP2', 'Civics', 'Boosts', 'Policies',
                   'CivicPrereqs', 'Civics_XP2', 'Building_GreatPersonPoints', 'Unit_BuildingPrereqs',
                   'UnitUpgrades', 'UnitPromotionPrereqs', 'UnitPromotionModifiers', 'UnitPromotions', 'Improvements',
                   'Improvement_ValidBuildUnits', 'Improvement_ValidTerrains', 'Improvement_ValidResources']
    for i in delete_full:
        dict_insert(model_obj, i, {'WHERE_COL': 1, 'WHERE_EQUALS': 1},
                    sql_type='deletes')

    dict_insert(model_obj, 'Units', {'WHERE_COL': 'UnitType', 'WHERE_EQUALS': kept['compat_for_VI']},
                sql_type='deletes')
    dict_insert(model_obj, 'Buildings',
                {'WHERE_COL': 'BuildingType', 'WHERE_EQUALS': model_obj['update_build'] + ['BUILDING_PALACE']},
                sql_type='deletes')
    dict_insert(model_obj, 'Building_YieldChanges', {'WHERE_COL': 'BuildingType', 'WHERE_EQUALS': 'BUILDING_PALACE'},
                sql_type='deletes')
    dict_insert(model_obj, 'UnitPromotionClasses',
                {'WHERE_COL': 'PromotionClassType', 'WHERE_EQUALS': ['PROMOTION_CLASS_MELEE', 'PROMOTION_CLASS_RANGED',
                                                                     'PROMOTION_CLASS_RECON',
                                                                     'PROMOTION_CLASS_LIGHT_CAVALRY',
                                                                     'PROMOTION_CLASS_NAVAL_MELEE',
                                                                     'PROMOTION_CLASS_SIEGE']},
                sql_type='deletes')
    dict_insert(model_obj, 'Projects',
                {'WHERE_COL': 'ProjectType',
                 'WHERE_EQUALS': ['PROJECT_ENHANCE_DISTRICT_ENCAMPMENT', 'PROJECT_ENHANCE_DISTRICT_HARBOR',
                                  'PROJECT_ENHANCE_DISTRICT_INDUSTRIAL_ZONE',
                                  'PROJECT_ENHANCE_DISTRICT_COMMERCIAL_HUB',
                                  'PROJECT_ENHANCE_DISTRICT_HOLY_SITE', 'PROJECT_ENHANCE_DISTRICT_CAMPUS',
                                  'PROJECT_ENHANCE_DISTRICT_THEATER', 'PROJECT_BREAD_AND_CIRCUSES']
                                 + ['PROJECT_LAUNCH_EARTH_SATELLITE', 'PROJECT_LAUNCH_MOON_LANDING']},
                sql_type='deletes')
    dict_insert(model_obj, 'Resources', {'WHERE_COL':
                                             'ResourceType',
                                         'WHERE_EQUALS': ['RESOURCE_COPPER', 'RESOURCE_IRON', 'RESOURCE_MARBLE',
                                                          'RESOURCE_DEER', 'RESOURCE_FISH',
                                                          'RESOURCE_RICE', 'RESOURCE_SHEEP', 'RESOURCE_WHEAT',
                                                          'RESOURCE_INCENSE', 'RESOURCE_IVORY',
                                                          'RESOURCE_SILK', 'RESOURCE_SUGAR', 'RESOURCE_WINE',
                                                          'RESOURCE_COTTON']},
                sql_type='deletes')
    dict_insert(model_obj, 'Governments', {'WHERE_COL': 'GovernmentType', 'WHERE_EQUALS': ['GOVERNMENT_CHIEFDOM']},
                sql_type='deletes')

    # delete_string += 'DELETE FROM Building_YieldChanges;'
    update_delete_generate(model_obj)


def dict_insert(model_obj, table, update, sql_type='updates'):
    if table not in model_obj[sql_type]:
        model_obj[sql_type][table] = [update]
    else:
        model_obj[sql_type][table].append(update)


def update_delete_generate(model_obj):
    for table_name, table in model_obj['updates'].items():
        for updates in table:
            where_eq = updates['WHERE_EQUALS']
            set_eq = updates['SET_EQUALS']
            if isinstance(where_eq, list):
                where_eq = "NOT IN ('" + "', '".join(where_eq) + "')"
            elif isinstance(where_eq, int):
                where_eq = f"= {where_eq}"
            else:
                where_eq = f"= '{where_eq}'"
            if isinstance(set_eq, list):
                update_list = ', '.join([f'{col} = {val}' for col, val in zip(updates['SET_COL'], set_eq)])
                model_obj['sql_strings'].append(f"UPDATE {table_name} SET {update_list}"
                                                f" WHERE {updates['WHERE_COL']} {where_eq};\n")
            elif isinstance(set_eq, int):
                set_eq = f"= {set_eq}"
                model_obj['sql_strings'].append(f"UPDATE {table_name} SET {updates['SET_COL']} {set_eq}"
                                                f" WHERE {updates['WHERE_COL']} {where_eq};\n")
            else:
                set_eq = f"= '{set_eq}'"
                model_obj['sql_strings'].append(f"UPDATE {table_name} SET {updates['SET_COL']} {set_eq}"
                                                f" WHERE {updates['WHERE_COL']} {where_eq};\n")


    for table_name, table in model_obj['deletes'].items():
        for deletes in table:
            where_eq = deletes['WHERE_EQUALS']
            if isinstance(where_eq, list):
                where_eq = "NOT IN ('" + "', '".join(where_eq) + "')"
            elif isinstance(where_eq, int):
                where_eq = f"= {where_eq}"
            else:
                where_eq = f"!= '{where_eq}'"
            model_obj['sql_strings'].append(
                f"DELETE FROM {table_name} WHERE {deletes['WHERE_COL']} {where_eq};\n")
