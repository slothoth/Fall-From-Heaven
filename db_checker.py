import sqlite3
import re
import json
import os
import copy


def get_primary_keys():
    if os.path.exists('data/primary_keys.json'):
        with open('data/primary_keys.json', 'r') as file:
            table_primary_keys = json.load(file)
        return table_primary_keys
    conn = sqlite3.connect('data/DebugGameplay.sqlite')
    cursor = conn.cursor()
    # Query the sqlite_master table to get information about database objects
    cursor.execute("SELECT name, sql FROM sqlite_master WHERE type='table';")
    tables = cursor.fetchall()
    cursor.close()
    conn.close()

    table_primary_keys = {}
    for table in tables:
        table_name = table[0]
        table_sql = table[1]
        if 'PRIMARY KEY' in table_sql:
            split_sql = table_sql.split('PRIMARY KEY')
            if len(split_sql) > 1:
                match = re.search(r'\((.*?)\)', split_sql[1])
                if match:
                    value_inside_parentheses = match.group(1)
                    value_inside_parentheses = value_inside_parentheses.replace('"', '')
                    table_primary_keys[table_name] = value_inside_parentheses.split(', ')
                else:
                    print("No parentheses found")
            else:
                print(f'{table_name} had no primary key')
        else:
            print(f"Table '{table_name}' does not have any PRIMARY KEY")

    with open('data/primary_keys.json', 'w') as file:
        json.dump(table_primary_keys, file)

    return table_primary_keys


def get_foreign_keys():
    if os.path.exists('data/foreign_keys.json'):
        with open('data/foreign_keys.json', 'r') as file:
            table_foreign_keys = json.load(file)
        return table_foreign_keys

    conn = sqlite3.connect('data/DebugGameplay.sqlite')
    cursor = conn.cursor()
    # Query the sqlite_master table to get information about database objects
    cursor.execute("SELECT name, sql FROM sqlite_master WHERE type='table';")
    tables = cursor.fetchall()
    cursor.close()
    conn.close()

    table_foreign_keys = {}
    for table in tables:
        table_name = table[0]
        table_sql = table[1]
        if 'FOREIGN KEY' in table_sql:
            split_sql = table_sql.split('FOREIGN KEY')
            if len(split_sql) > 1:
                for i in split_sql[1:]:
                    match = re.search(r'\((.*?)\)', i)
                    if match:
                        value_inside_parentheses = match.group(1)
                        value_inside_parentheses = value_inside_parentheses.replace('"', '')
                        reference = i.split(' ')[3].split('(')
                        if table_name not in table_foreign_keys:
                            table_foreign_keys[table_name] = {}
                        table_foreign_keys[table_name][value_inside_parentheses] = {'table': reference[0],
                                                                                    'column':reference[1][:-1]}
                    else:
                        print("No parentheses found")
            else:
                print(f'{table_name} had no primary key')
        else:
            print(f"Table '{table_name}' does not have any PRIMARY KEY")

    with open('data/foreign_keys.json', 'w') as file:
        json.dump(table_foreign_keys, file)

    return table_foreign_keys

def check_primary_keys(model_obj):
    primary_keys = get_primary_keys()
    foreign_keys = get_foreign_keys()
    pre_existing = {'Yields': [{'YieldType': 'YIELD_GOLD'}, {'YieldType': 'YIELD_SCIENCE'}, {'YieldType': 'YIELD_FOOD'},
                               {'YieldType': 'YIELD_CULTURE'}, {'YieldType': 'YIELD_FAITH'},
                               {'YieldType': 'YIELD_PRODUCTION'}],
                    'Terrains': [{'TerrainType': 'TERRAIN_GRASS'}, {'TerrainType': 'TERRAIN_PLAINS'},
                                 {'TerrainType': 'TERRAIN_DESERT'}, {'TerrainType': 'TERRAIN_TUNDRA'},
                                 {'TerrainType': 'TERRAIN_SNOW'}, {'TerrainType': 'TERRAIN_GRASS_HILLS'},
                                 {'TerrainType': 'TERRAIN_PLAINS_HILLS'}, {'TerrainType': 'TERRAIN_DESERT_HILLS'},
                                 {'TerrainType': 'TERRAIN_TUNDRA_HILLS'}, {'TerrainType': 'TERRAIN_SNOW_HILLS'}],
                    'Features': [{'FeatureType': 'FEATURE_FOREST'}, {'FeatureType': 'FEATURE_JUNGLE'}],
                    'Resources': [{'ResourceType': 'RESOURCE_COPPER'}, {'ResourceType': 'RESOURCE_IRON'},
                                  {'ResourceType': 'RESOURCE_MARBLE'}, {'ResourceType': 'RESOURCE_WINE'},
                                  {'ResourceType': 'RESOURCE_INCENSE'}, {'ResourceType': 'RESOURCE_DEER'},
                                  {'ResourceType': 'RESOURCE_SILK'}, {'ResourceType': 'RESOURCE_SUGAR'},
                                  {'ResourceType': 'RESOURCE_RICE'}],
                    'GreatPersonClasses': [{'GreatPersonClassType': 'GREAT_PERSON_CLASS_PROPHET'},
                                           {'GreatPersonClassType': 'GREAT_PERSON_CLASS_GENERAL'},
                                           {'GreatPersonClassType': 'GREAT_PERSON_CLASS_MERCHANT'},
                                           {'GreatPersonClassType': 'GREAT_PERSON_CLASS_ENGINEER'},
                                           {'GreatPersonClassType': 'GREAT_PERSON_CLASS_SCIENTIST'},
                                           {'GreatPersonClassType': 'GREAT_PERSON_CLASS_WRITER'},
                                           {'GreatPersonClassType': 'GREAT_PERSON_CLASS_ARTIST'}],
                    'Leaders': [{'LeaderType': 'LEADER_DEFAULT'}],
                    'Traits': [{'TraitType': 'TRAIT_BARBARIAN_BUT_SHOWS_UP_IN_PEDIA'}],
                    'Eras': [{'EraType': 'ERA_ANCIENT'}, {'EraType': 'ERA_MEDIEVAL'}, {'EraType': 'ERA_CLASSICAL'},
                             {'EraType': 'ERA_MODERN'}, {'EraType': 'ERA_INDUSTRIAL'}, {'EraType': 'ERA_RENAISSANCE'},
                             {'EraType': 'ERA_INFORMATION'}, {'EraType': 'ERA_ATOMIC'}],
                    'GovernmentSlots': [{'GovernmentSlotType': 'SLOT_DIPLOMATIC'},
                                        {'GovernmentSlotType': 'SLOT_ECONOMIC'},
                                        {'GovernmentSlotType': 'SLOT_MILITARY'},
                                        {'GovernmentSlotType': 'SLOT_GREAT_PERSON'}],
                    'CivilizationLevels': [{'CivilizationLevelType': 'CIVILIZATION_LEVEL_FULL_CIV'}],
                    'Districts': [{'DistrictType': 'DISTRICT_CITY_CENTER'}, {'DistrictType': 'DISTRICT_CAMPUS'},
                                  {'DistrictType': 'DISTRICT_HOLY_SITE'}, {'DistrictType': 'DISTRICT_COMMERCIAL_HUB'},
                                  {'DistrictType': 'DISTRICT_THEATER'}, {'DistrictType': 'DISTRICT_INDUSTRIAL_ZONE'}],
                    'UnitPromotionClasses': [{'PromotionClassType': 'PROMOTION_CLASS_RECON'},
                                             {'PromotionClassType': 'PROMOTION_CLASS_MELEE'},
                                             {'PromotionClassType': 'PROMOTION_CLASS_NAVAL_MELEE'},
                                             {'PromotionClassType': 'PROMOTION_CLASS_RANGED'},
                                             {'PromotionClassType': 'PROMOTION_CLASS_LIGHT_CAVALRY'},
                                             {'PromotionClassType': 'PROMOTION_CLASS_SIEGE'}],
                    'Kinds': [{'Kind': 'KIND_TRAIT'}, {'Kind': 'KIND_CIVILIZATION'}, {'Kind': 'KIND_LEADER'},
                              {'Kind': 'KIND_TECH'}, {'Kind': 'KIND_CIVIC'}, {'Kind': 'KIND_POLICY'},
                              {'Kind': 'KIND_UNIT'}, {'Kind': 'KIND_BUILDING'}, {'Kind': 'KIND_MODIFIER'},
                              {'Kind': 'KIND_PROMOTION_CLASS'}, {'Kind': 'KIND_PROMOTION'}, {'Kind': 'KIND_RESOURCE'},
                              {'Kind': 'KIND_TERRAIN'}, {'Kind': 'KIND_FEATURE'}],
                    'Types': [{'Type': 'COLLECTION_OWNER'},
                              {'Type': 'MODIFIER_CITY_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL'},
                              {'Type': 'EFFECT_ADJUST_CITY_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL'}],

                    'Units': [{'UnitType': 'UNIT_BUILDER'}],
                    'RequirementSets': [{'RequirementSetId': 'PLOT_HAS_FARM_REQUIREMENTS'},
                                        {'RequirementSetId': 'PLOT_HAS_COAST_REQUIREMENTS'},
                                        {'RequirementSetId': 'PLOT_IS_ADJACENT_TO_COAST'},
                                        {'RequirementSetId': 'PLOT_HAS_QUARRY_REQUIREMENTS'},
                                        {'RequirementSetId': 'PLOT_HAS_MINE_REQUIREMENTS'},
                                        {'RequirementSetId': 'REQUIREMENT_UNIT_IS_RANGED'},
                                        {'RequirementSetId': 'UNIT_IS_BUILDER'},]}
    constraints = {}
    succeeded_constraints, failed_constraints = 0, 0
    for name, insert in model_obj['sql_inserts'].items():
        # primary_inserts = [[i[j] for j in primary_keys[name]] for i in insert]
        if isinstance(insert, dict):
            prim = []
            for key, val in insert.items():
                    prim.append([val[j] for j in primary_keys[name]])

            fk = [{j: val.get(j, None) for j in foreign_keys.get(name, [])} for key, val in insert.items()]

        elif isinstance(insert, list):
            prim = [[i[j] for j in primary_keys[name]] for i in insert]
            fk = [{j: i.get(j, None) for j in foreign_keys.get(name, [])} for i in insert]
        else:
            print(f'malformed insert data structure {name}')

        uniques = []
        for i in prim:
            if i in uniques:
                print(f"Duplicate in {name}: {i}")
            else:
                uniques.append(i)


        for i in fk:
            for native_col, constraint_req in i.items():
                if constraint_req is None or constraint_req == 'NULL':
                    continue
                constraint_table = foreign_keys[name][native_col]['table']
                constraint_col = foreign_keys[name][native_col]['column']
                if constraint_table not in constraints:
                    constraints[constraint_table] = {}
                if constraint_col not in constraints[constraint_table]:
                    constraints[constraint_table][constraint_col] = {}
                if constraint_req not in constraints[constraint_table][constraint_col]:
                    constraints[constraint_table][constraint_col][constraint_req] = [False, [i]]
                else:
                    constraints[constraint_table][constraint_col][constraint_req][1].append(i)

    # second pass to set bools
    transient_extras = copy.deepcopy(model_obj['sql_inserts'])
    for i in pre_existing:
        if i in transient_extras:
            if isinstance(transient_extras[i], list):
                transient_extras[i].extend(pre_existing[i])
            else:
                transient_extras[i].update({list(i.values())[0]: i for i in pre_existing[i]})
        else:
            transient_extras[i] = pre_existing[i]
    for name, insert in transient_extras.items():
        if isinstance(insert, dict):
            search = insert.values()
        elif isinstance(insert, list):
            search = insert
        else:
            raise ValueError('search was not a dict or list')
        for col_name, column_reqs in constraints.get(name, {}).items():
            for fk_name, constraint in column_reqs.items():
                if fk_name in [i[col_name] for i in search] + ['NULL', None]:
                    constraint[0] = True

    for table_name, table in constraints.items():
        for col_name, columns in table.items():
            for value_needed, checker in columns.items():
                if not checker[0]:
                    print(f'CONSTRAINT FAILED: need table {table_name}, column {col_name} to have value {value_needed}'
                          f'\nfor rows {checker[1]}\n')
                    failed_constraints += 1
                else:
                    succeeded_constraints += 1

    print(f'Constraints -- Failed: {failed_constraints}, Succeeded: {succeeded_constraints}')
