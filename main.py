from civilizations import Civilizations
from units import units_sql
from techs import techs_sql, prereq_techs
from buildings import Buildings, districts_build
from delete_n_patch import delete_rows, patch_string_generate
from misc import build_resource_string, build_terrains_string, build_sql_table, build_features_string, build_policies
from db_checker import db_checker
from promotions import Promotions
from modifiers import Modifiers

import json


def main():
    civs = ['AMURITES', 'BALSERAPHS', 'BANNOR', 'CALABIM', 'CLAN_OF_EMBERS', 'DOVIELLO', 'ELOHIM', 'GRIGORI', 'HIPPUS',
            'ILLIANS', 'INFERNAL', 'KHAZAD', 'KURIOTATES', 'LANUN', 'LJOSALFAR', 'LUCHUIRP', 'MALAKIM', 'MERCURIANS',
            'SHEAIM', 'SIDAR', 'SVARTALFAR', 'BARBARIAN']
    kinds = {}
    with open("data/kept.json", 'r') as json_file:
        kept = json.load(json_file)
    with open('../FallFromHeaven/Core/localization.sql', 'w') as file:
        file.write('INSERT OR REPLACE INTO LocalizedText (Language, Tag, Text)\nVALUES\n')
    civilizations = Civilizations()
    modifiers = Modifiers()
    civ_string, civ_units, civ_buildings, kinds, traits = civilizations.civilizations(civs, kinds)
    tech_table_string, civic_table_string, civics, kinds = techs_sql(kinds, kept)
    policy_string, policy_mod_string, kinds = build_policies(civics, kinds, modifiers)
    unit_table_string, replacements_string, upgrades_string, traits, kinds = units_sql(civs, civ_units, civics, kinds,
                                                                                       traits, kept)
    promotions_string, kinds = Promotions().promotion_miner(kinds)
    resource_string, kinds = build_resource_string(civics, kinds)
    terrain_string, kinds = build_terrains_string(kinds)
    features_string, kinds = build_features_string(kinds)
    prereqs_string = prereq_techs()
    patch_string = patch_string_generate()
    building_table_string, kinds, calculated_to_keep = Buildings(civs).buildings_sql(civics, civ_buildings, kinds)
    districts_string = districts_build()
    delete_string = delete_rows(kept, calculated_to_keep)
    traits_string = build_sql_table(traits, 'Traits')
    modifier_string = modifiers.big_get()
    kind_string = build_sql_table([{'Type': key, 'Kind': value} for key, value in kinds.items()], 'Types')
    total = (delete_string + kind_string + '\n' + tech_table_string + civic_table_string + prereqs_string
             + building_table_string + districts_string + civ_string + traits_string + unit_table_string
             + replacements_string + upgrades_string + promotions_string + resource_string + terrain_string
             + features_string + policy_string + policy_mod_string + modifier_string + patch_string)

    # debug super palace
    total += """UPDATE Building_YieldChanges SET YieldChange = 100 WHERE BuildingType = 'BUILDING_PALACE' AND YieldType = 'YIELD_CULTURE';
UPDATE Building_YieldChanges SET YieldChange = 500 WHERE BuildingType = 'BUILDING_PALACE' AND YieldType = 'YIELD_GOLD';
UPDATE Building_YieldChanges SET YieldChange = 200 WHERE BuildingType = 'BUILDING_PALACE' AND YieldType = 'YIELD_PRODUCTION';
UPDATE Building_YieldChanges SET YieldChange = 200 WHERE BuildingType = 'BUILDING_PALACE' AND YieldType = 'YIELD_SCIENCE';"""

    frontend_config_string = civilizations.config_builder(civs)

    total_with_null = total.replace("'NULL'", "NULL")
    with open('../FallFromHeaven/Core/main.sql', 'w') as file:
        file.write(total_with_null)

    with open('../FallFromHeaven/Core/localization.sql', 'r') as file:
        localization_file = file.read()[:-2] + ';'
    with open('../FallFromHeaven/Core/localization.sql', 'w') as file:
        file.write(localization_file)

    with open('../FallFromHeaven/Core/frontend_config.sql', 'w') as file:
        file.write(frontend_config_string)

    db_checker([i for i in kinds])


if __name__ == "__main__":
    main()
