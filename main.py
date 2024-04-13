import os

from civilizations import Civilizations
from units import units_sql
from techs import techs_sql, prereq_techs
from buildings import Buildings, districts_build
from delete_n_patch import delete_rows, patch_string_generate
from misc import build_resource_string, build_terrains_string, build_features_string, build_policies
from promotions import Promotions
from modifiers import Modifiers
from utils import Sql, setup_tables, db_checker

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
    model_obj = {'kinds': {}, 'traits': {}, 'sql_strings': [],
                 'civilizations': Civilizations(), 'modifiers': Modifiers(), 'sql': Sql(), 'select_civs': civs}
    model_obj['civilizations'].civilizations(model_obj)
    techs_sql(model_obj, kept)
    build_policies(model_obj)
    units_sql(model_obj, kept)
    Promotions().promotion_miner(model_obj)
    build_resource_string(model_obj)
    build_terrains_string(model_obj)
    build_features_string(model_obj)
    prereq_techs(model_obj['sql_strings'])
    patch_string_generate(model_obj['sql_strings'])
    Buildings(civs).buildings_sql(model_obj)
    districts_build(model_obj)
    model_obj['sql_strings'].append(delete_rows(model_obj, kept))
    model_obj['sql_strings'].append(model_obj['sql'].build_sql_table(model_obj['traits'], 'Traits'))
    model_obj['sql_strings'].append(model_obj['modifiers'].big_get(model_obj))
    model_obj['sql_strings'].append(model_obj['sql'].old_build_sql_table(
        [{'Type': key, 'Kind': value, 'Hash': hash(key)} for key, value in model_obj['kinds'].items()], 'Types'))
    total = ''
    for i in model_obj['sql_strings']:
        total+= i

    # debug super palace
    total += """UPDATE Building_YieldChanges SET YieldChange = 100 WHERE BuildingType = 'BUILDING_PALACE' AND YieldType = 'YIELD_CULTURE';
UPDATE Building_YieldChanges SET YieldChange = 500 WHERE BuildingType = 'BUILDING_PALACE' AND YieldType = 'YIELD_GOLD';
UPDATE Building_YieldChanges SET YieldChange = 200 WHERE BuildingType = 'BUILDING_PALACE' AND YieldType = 'YIELD_PRODUCTION';
UPDATE Building_YieldChanges SET YieldChange = 200 WHERE BuildingType = 'BUILDING_PALACE' AND YieldType = 'YIELD_SCIENCE';"""

    frontend_config_string = model_obj['civilizations'].config_builder(model_obj)

    total_with_null = total.replace("'NULL'", "NULL")
    with open('../FallFromHeaven/Core/main.sql', 'w') as file:
        file.write(total_with_null)

    with open('../FallFromHeaven/Core/localization.sql', 'r') as file:
        localization_file = file.read()[:-2] + ';'
    with open('../FallFromHeaven/Core/localization.sql', 'w') as file:
        file.write(localization_file)

    with open('../FallFromHeaven/Core/frontend_config.sql', 'w') as file:
        file.write(frontend_config_string)

    db_checker([i for i in model_obj['kinds']])


if __name__ == "__main__":
    main()
