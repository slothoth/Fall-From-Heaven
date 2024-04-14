from civilizations import Civilizations
from units import units_sql
from techs import techs_sql, prereq_techs
from buildings import Buildings, districts_build
from delete_n_patch import delete_rows, patch_string_generate
from misc import build_resource_string, build_terrains_string, build_features_string, build_policies
from promotions import Promotions
from modifiers import Modifiers
from utils import Sql, setup_tables, existing_types_checker, make_or_add
from db_checker import check_primary_keys

import json


def main():
    setup_tables()
    civs = ['AMURITES', 'BALSERAPHS', 'BANNOR', 'CALABIM', 'CLAN_OF_EMBERS', 'DOVIELLO', 'ELOHIM', 'GRIGORI', 'HIPPUS',
            'ILLIANS', 'INFERNAL', 'KHAZAD', 'KURIOTATES', 'LANUN', 'LJOSALFAR', 'LUCHUIRP', 'MALAKIM', 'MERCURIANS',
            'SHEAIM', 'SIDAR', 'SVARTALFAR', 'BARBARIAN']

    with open("data/kept.json", 'r') as json_file:
        kept = json.load(json_file)
    with open('../FallFromHeaven/Core/localization.sql', 'w') as file:
        file.write('INSERT OR REPLACE INTO LocalizedText (Language, Tag, Text)\nVALUES\n')
    model_obj = {'kinds': {}, 'traits': {}, 'sql_strings': [], 'sql_inserts': {}, 'sql_updates': {}, 'sql_config': {},
                 'civilizations': Civilizations(), 'modifiers': Modifiers(), 'sql': Sql(), 'select_civs': civs}
    model_obj['civilizations'].civilizations(model_obj)
    techs_sql(model_obj, kept)
    build_policies(model_obj)
    units_sql(model_obj, kept)
    Promotions().promotion_miner(model_obj)
    build_resource_string(model_obj)
    build_terrains_string(model_obj)
    build_features_string(model_obj)
    prereq_techs(model_obj)
    patch_string_generate(model_obj['sql_strings'])
    Buildings(civs).buildings_sql(model_obj)
    districts_build(model_obj)
    delete_rows(model_obj, kept)
    make_or_add(model_obj['sql_inserts'], model_obj['traits'], 'Traits')
    model_obj['modifiers'].big_get(model_obj)
    make_or_add(model_obj['sql_inserts'], [{'Type': key, 'Kind': value} for key, value
                                           in model_obj['kinds'].items()], 'Types')

    # deprecated hash version
    # make_or_add(model_obj['sql_inserts'], [{'Type': key, 'Kind': value, 'Hash': hash(key)} for key, value
    #                                            in model_obj['kinds'].items()], 'Types')

    check_primary_keys(model_obj)
    for table, rows in model_obj['sql_inserts'].items():
        model_obj['sql_strings'].append(model_obj['sql'].old_build_sql_table(rows, table))
    total = ''
    for i in model_obj['sql_strings']:
        total += i

    # debug super palace
    total += """UPDATE Building_YieldChanges SET YieldChange = 100 WHERE BuildingType = 'BUILDING_PALACE' AND YieldType = 'YIELD_CULTURE';
UPDATE Building_YieldChanges SET YieldChange = 500 WHERE BuildingType = 'BUILDING_PALACE' AND YieldType = 'YIELD_GOLD';
UPDATE Building_YieldChanges SET YieldChange = 200 WHERE BuildingType = 'BUILDING_PALACE' AND YieldType = 'YIELD_PRODUCTION';
UPDATE Building_YieldChanges SET YieldChange = 200 WHERE BuildingType = 'BUILDING_PALACE' AND YieldType = 'YIELD_SCIENCE';"""

    total_with_null = total.replace("'NULL'", "NULL")
    with open('../FallFromHeaven/Core/main.sql', 'w') as file:
        file.write(total_with_null)

    with open('../FallFromHeaven/Core/localization.sql', 'r') as file:
        localization_file = file.read()[:-2] + ';'
    with open('../FallFromHeaven/Core/localization.sql', 'w') as file:
        file.write(localization_file)

    model_obj['civilizations'].config_builder(model_obj)

    config = 'DELETE FROM Players;\n'
    for table, rows in model_obj['sql_config'].items():
        config += model_obj['sql'].old_build_sql_table(rows, table)

    with open('../FallFromHeaven/Core/frontend_config.sql', 'w') as file:
        file.write(config)

    existing_types_checker([i for i in model_obj['kinds']])


if __name__ == "__main__":
    main()
