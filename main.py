from civilizations import Civilizations
from units import Units
from techs import techs_sql, prereq_techs
from buildings import Buildings, districts_build
from delete_n_patch import delete_rows
from misc import build_resource_string, build_terrains_string, build_features_string, build_policies, build_improvements
from promotions import Promotions
from modifiers import Modifiers
from utils import Sql, setup_tables, make_or_add, update_sql_table
from localiser import Localizer, custom_loc
from db_checker import check_primary_keys, localize_check
from prebuilt_transfer import main as prebuilt_transfer
from artdef_wrangler import Artdef

import json
import logging


def main():
    logging.basicConfig(level=logging.INFO)
    setup_tables()
    civs = ['AMURITES', 'BALSERAPHS', 'BANNOR', 'CALABIM', 'CLAN_OF_EMBERS', 'DOVIELLO', 'ELOHIM', 'GRIGORI', 'HIPPUS',
            'ILLIANS', 'INFERNAL', 'KHAZAD', 'KURIOTATES', 'LANUN', 'LJOSALFAR', 'LUCHUIRP', 'MALAKIM', 'MERCURIANS',
            'SHEAIM', 'SIDAR', 'SVARTALFAR', 'BARBARIAN']

    with open("data/kept.json", 'r') as json_file:
        kept = json.load(json_file)
    model_obj = {'kinds': {}, 'traits': {}, 'sql_strings': [], 'sql_inserts': {}, 'sql_updates': {}, 'sql_config': {},
                 'civilizations': Civilizations(), 'modifiers': Modifiers(), 'sql': Sql(), 'units': Units(),
                 'select_civs': civs, 'loc': {}, 'updates': {}, 'deletes': {}, 'sql_deletes': {}, 'tags': {}}
    model_obj['custom_loc'] = custom_loc()
    techs_sql(model_obj, kept)
    model_obj['civilizations'].civilizations(model_obj)
    build_policies(model_obj)
    model_obj['units'].units_sql(model_obj, kept)
    Promotions().promotion_miner(model_obj)
    build_resource_string(model_obj)
    build_terrains_string(model_obj)
    build_features_string(model_obj)
    build_improvements(model_obj)
    prereq_techs(model_obj)

    Buildings(civs).buildings_sql(model_obj)
    districts_build(model_obj)
    make_or_add(model_obj['sql_inserts'], model_obj['traits'], 'Traits')
    model_obj['modifiers'].sql_convert(model_obj)
    make_or_add(model_obj['sql_inserts'], [{'Type': key, 'Kind': value} for key, value
                                           in model_obj['kinds'].items()], 'Types')
    make_or_add(model_obj['sql_inserts'], [{'Tag': key, 'Vocabulary': value} for key, value
                                           in model_obj['tags'].items()], 'Tags')
    # deprecated hash version
    # make_or_add(model_obj['sql_inserts'], [{'Type': key, 'Kind': value, 'Hash': hash(key)} for key, value
    #                                            in model_obj['kinds'].items()], 'Types')
    delete_rows(model_obj, kept)
    localise = Localizer()
    localise.localize(model_obj)
    artdef = Artdef().do_artdef()
    check_primary_keys(model_obj)
    for table, rows in model_obj['sql_inserts'].items():
        model_obj['sql_strings'].append(model_obj['sql'].old_build_sql_table(rows, table))
    for table, val in model_obj['sql_updates'].items():
        update = update_sql_table(val[0], table, val[1])
        if update is not None:
            model_obj['sql_strings'].append(update)

    total = ''
    for i in model_obj['sql_strings']:
        total += i

    # debug super palace
    if True:
        total += """UPDATE Building_YieldChanges SET YieldChange = 999 WHERE BuildingType = 'BUILDING_PALACE' AND YieldType = 'YIELD_CULTURE';
        UPDATE Building_YieldChanges SET YieldChange = 500 WHERE BuildingType = 'BUILDING_PALACE' AND YieldType = 'YIELD_GOLD';
        UPDATE Building_YieldChanges SET YieldChange = 999 WHERE BuildingType = 'BUILDING_PALACE' AND YieldType = 'YIELD_PRODUCTION';
        UPDATE Building_YieldChanges SET YieldChange = 999 WHERE BuildingType = 'BUILDING_PALACE' AND YieldType = 'YIELD_SCIENCE';
        INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES('BUILDING_PALACE', 'CONTRATACION_GOVERNOR_POINTS')"""

    total_with_null = total.replace("'NULL'", "NULL")
    with open('../FallFromHeaven/Core/main.sql', 'w') as file:
        file.write(total_with_null)

    model_obj['loc_full'] = []
    for table in model_obj['loc'].values():
        for record in table:
            model_obj['loc_full'].append(record)

    tuple_loc_list = [(i['Language'], i['Tag'], i['Text']) for i in model_obj['loc_full']]
    unique_tuple_loc_list = list(set(tuple_loc_list))
    model_obj['loc_full'] = [{'Language': i[0], 'Tag': i[1], 'Text': i[2]} for i in unique_tuple_loc_list]

    localize_check(model_obj)

    localization_file = model_obj['sql'].old_build_sql_table(model_obj['loc_full'], 'LocalizedText')

    with open('../FallFromHeaven/Core/localization.sql', 'w', encoding="utf-8") as file:
        file.write(localization_file)

    model_obj['civilizations'].config_builder(model_obj)

    config = 'DELETE FROM Players;\n'
    for table, rows in model_obj['sql_config'].items():
        config += model_obj['sql'].old_build_sql_table(rows, table)

    with open('../FallFromHeaven/Core/frontend_config.sql', 'w', encoding="utf-8") as file:
        file.write(config)

    prebuilt_transfer()


if __name__ == "__main__":
    main()
