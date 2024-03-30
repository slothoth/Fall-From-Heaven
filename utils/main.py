from civilizations import civilizations
from units import units_sql
from techs import techs_sql, prereq_techs
from buildings import Buildings, districts_build
from delete_n_patch import delete_rows, patch_string_generate, traits_string_generate
from misc import build_resource_string, build_terrains_string, build_sql_table, build_features_string
from db_checker import db_checker

import json


def main():
    civs = ['AMURITES', 'CALABIM', 'LUCHUIRP', 'BARBARIAN']
    kinds = {}
    with open("data/kept.json", 'r') as json_file:
        kept = json.load(json_file)
    with open('../Core/localization.sql', 'w') as file:
        file.write('INSERT OR REPLACE INTO LocalizedText (Language, Tag, Text)\nVALUES\n')
    unique_units_to_remove, unique_buildings_to_remove = civilizations(civs)
    tech_table_string, civic_table_string, civics, kinds = techs_sql(kinds, kept)
    unit_table_string, replacements_string, upgrades_string, trait_types_to_define, kinds = units_sql(civs, unique_units_to_remove, civics, kinds, kept)
    resource_string, kinds = build_resource_string(civics, kinds)
    terrain_string, kinds = build_terrains_string(kinds)
    features_string, kinds = build_features_string(kinds)
    prereqs_string = prereq_techs()
    delete_string = delete_rows(kept)
    patch_string = patch_string_generate()
    traits_string, kinds = traits_string_generate(trait_types_to_define, kinds)
    building_table_string, kinds = Buildings().buildings_sql(civics, kinds)
    districts_string = districts_build()
    kind_string = build_sql_table([{'Type': key, 'Kind': value} for key, value in kinds.items()], 'Types')
    total = (delete_string + kind_string + '\n' + tech_table_string + civic_table_string + prereqs_string
             + building_table_string + districts_string + traits_string + unit_table_string + replacements_string
             + upgrades_string + resource_string + terrain_string + features_string + patch_string)

    total_with_null = total.replace("'NULL'", "NULL")
    with open('../Core/techs_civics.sql', 'w') as file:
        file.write(total_with_null)

    with open('../Core/localization.sql', 'r') as file:
        localization_file = file.read()[:-2] + ';'
    with open('../Core/localization.sql', 'w') as file:
        file.write(localization_file)

    db_checker([i for i in kinds])


if __name__ == "__main__":
    main()
