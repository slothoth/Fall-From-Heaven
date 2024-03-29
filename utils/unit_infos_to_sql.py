from civilizations import civilizations
from units import units_sql
from techs import techs_sql, prereq_techs
from buildings import buildings_sql
from delete_n_patch import delete_rows, patch_string_generate, traits_string_generate

import json


def main():
    civs = ['AMURITES', 'CALABIM', 'LUCHUIRP', 'BARBARIAN']
    kind_string = ''
    with open("data/kept.json", 'r') as json_file:
        kept = json.load(json_file)
    with open('../Core/localization.sql', 'w') as file:
        file.write('INSERT OR REPLACE INTO LocalizedText (Language, Tag, Text)\nVALUES\n')
    unique_units_to_remove, unique_buildings_to_remove = civilizations(civs)
    tech_table_string, civic_table_string, civics, kind_string = techs_sql(kind_string, kept)
    unit_table_string, replacements_string, upgrades_string, trait_types_to_define, kind_string = units_sql(civs, unique_units_to_remove, civics, kind_string, kept)
    prereqs_string = prereq_techs()
    delete_string = delete_rows(kept)
    patch_string = patch_string_generate()
    traits_string, kind_string = traits_string_generate(trait_types_to_define, kind_string)
    building_table_string, kind_string = buildings_sql(civics, kind_string)

    kind_string = kind_string[:-1] + ';'
    total = (delete_string + kind_string + '\n' + tech_table_string + civic_table_string + prereqs_string
             + building_table_string + traits_string + unit_table_string + replacements_string
             + upgrades_string + patch_string)

    total_with_null = total.replace("'NULL'", "NULL")
    with open('../Core/techs_civics.sql', 'w') as file:
        file.write(total_with_null)

    with open('../Core/localization.sql', 'a') as file:
        file.write(';')


if __name__ == "__main__":
    main()