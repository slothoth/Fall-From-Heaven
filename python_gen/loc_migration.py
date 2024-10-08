import ast

category = {}
category['resources'] = []
category['city_names'] = []
category['improvement_names'] = []
category['improvement_descriptions'] = []
category['ability_names'] = []
category['ability_descriptions'] = []
category['promotion_names'] = []
category['promotion_descriptions'] = []
category['unit_names'] = []
category['unit_descriptions'] = []
category['equip_names'] = []
category['equip_descriptions'] = []
category['building_names'] = []
category['building_descriptions'] = []
category['policy_names'] = []
category['policy_descriptions'] = []
category['trait_names'] = []
category['trait_descriptions'] = []
category['tech_names'] = []
category['tech_descriptions'] = []
category['pedia_chapters'] = []
category['pedia_pages'] = []
category['civic_names'] = []
category['civic_descriptions'] = []
category['civ_names'] = []
category['civ_descriptions'] = []
category['civ_adjectives'] = []
category['leader_names'] = []
category['great_ppl_names'] = []
category['feature_names'] = []
category['terrain_names'] = []
category['nulls'] = []
I BROKE IT
for i in ['long_localization.sql', 'short_loc.sql', 'medium_localization.sql']:
    with open(f'../Localisation/{i}', encoding='cp1252',  errors='replace') as file:
        lines = file.readlines()

    category['resources'].extend([i for i in lines if 'LOC_RESOURCE' in i])
    lines = [i for i in lines if 'LOC_RESOURCE' not in i]
    category['city_names'].extend([i for i in lines if 'LOC_CITY' in i])
    lines = [i for i in lines if 'LOC_CITY' not in i]
    category['trait_names'].extend([i for i in lines if 'TRAIT' in i and 'NAME' in i])
    lines = [i for i in lines if not ('TRAIT' in i and 'NAME' in i)]
    category['trait_descriptions'].extend([i for i in lines if 'TRAIT' in i and 'DESCR' in i])
    lines = [i for i in lines if not ('TRAIT' in i and 'DESCR' in i)]
    category['improvement_names'].extend([i for i in lines if 'LOC_IMPROVEMENT' in i and 'NAME' in i])
    lines = [i for i in lines if not ('LOC_IMPROVEMENT' in i and 'NAME' in i)]
    category['improvement_descriptions'].extend([i for i in lines if 'LOC_IMPROVEMENT' in i and 'DESCR' in i])
    lines = [i for i in lines if not ('LOC_IMPROVEMENT' in i and 'DESCR' in i)]
    category['ability_names'].extend([i for i in lines if 'ABILITY' in i and 'NAME' in i])
    lines = [i for i in lines if not ('ABILITY' in i and 'NAME' in i)]
    category['ability_descriptions'].extend([i for i in lines if 'ABILITY' in i and 'DESCR' in i])
    lines = [i for i in lines if not ('ABILITY' in i and 'DESCR' in i)]
    category['promotion_names'].extend([i for i in lines if 'PROMOTION' in i and 'NAME' in i])
    lines = [i for i in lines if not ('PROMOTION' in i and 'NAME' in i)]
    category['promotion_descriptions'].extend([i for i in lines if 'PROMOTION' in i and 'DESCR' in i])
    lines = [i for i in lines if not ('PROMOTION' in i and 'DESCR' in i)]
    category['unit_names'].extend([i for i in lines if 'UNIT' in i and 'NAME' in i])
    lines = [i for i in lines if not('UNIT' in i and 'NAME' in i)]
    category['unit_descriptions'].extend([i for i in lines if 'UNIT' in i and 'DESCR' in i])
    lines = [i for i in lines if not('UNIT' in i and 'DESCR' in i)]
    category['equip_names'].extend([i for i in lines if 'EQUIPMENT' in i and 'NAME' in i])
    lines = [i for i in lines if not('EQUIPMENT' in i and 'NAME' in i)]
    category['equip_descriptions'].extend([i for i in lines if 'EQUIPMENT' in i and 'DESCR' in i])
    lines = [i for i in lines if not('EQUIPMENT' in i and 'DESCR' in i)]
    category['building_names'].extend([i for i in lines if 'BUILDING' in i and 'NAME' in i])
    lines = [i for i in lines if not('BUILDING' in i and 'NAME' in i)]
    category['building_descriptions'].extend([i for i in lines if 'BUILDING' in i and 'DESCR' in i])
    lines = [i for i in lines if not('BUILDING' in i and 'DESCR' in i)]
    category['policy_names'].extend([i for i in lines if 'POLICY' in i and 'NAME' in i])
    lines = [i for i in lines if not('POLICY' in i and 'NAME' in i)]
    category['policy_descriptions'].extend([i for i in lines if 'POLICY' in i and 'DESCR' in i])
    lines = [i for i in lines if not('POLICY' in i and 'DESCR' in i)]
    category['tech_names'].extend([i for i in lines if 'TECH' in i and 'NAME' in i])
    lines = [i for i in lines if not('TECH' in i and 'NAME' in i)]
    category['tech_descriptions'].extend([i for i in lines if 'TECH' in i and 'DESCR' in i])
    lines = [i for i in lines if not('TECH' in i and 'DESCR' in i)]
    category['pedia_chapters'].extend([i for i in lines if 'PEDIA' in i and 'PARA' in i])
    lines = [i for i in lines if not('PEDIA' in i and 'PARA' in i)]
    category['pedia_pages'].extend([i for i in lines if 'PEDIA' in i and 'PARA' not in i])
    lines = [i for i in lines if not('PEDIA' in i and 'PARA' not in i)]
    category['civic_names'].extend([i for i in lines if 'CIVIC' in i and 'NAME' in i])
    lines = [i for i in lines if not('CIVIC' in i and 'NAME' in i)]
    category['civic_descriptions'].extend([i for i in lines if 'CIVIC' in i and 'DESCR' in i])
    lines = [i for i in lines if not('CIVIC' in i and 'DESCR' in i)]
    category['civ_names'].extend([i for i in lines if '_CIV_' in i and 'NAME' in i])
    lines = [i for i in lines if not('_CIV_' in i and 'NAME' in i)]
    category['civ_descriptions'].extend([i for i in lines if '_CIV_' in i and 'DESCR' in i])
    lines = [i for i in lines if not('_CIV_' in i and 'DESCR' in i)]
    category['civ_adjectives'].extend([i for i in lines if '_CIV_' in i and 'ADJECTIVE' in i])
    lines = [i for i in lines if not('_CIV_' in i and 'ADJECTIVE' in i)]
    category['leader_names'].extend([i for i in lines if '_LEADER_' in i and 'NAME' in i])
    lines = [i for i in lines if not('_LEADER_' in i and 'NAME' in i)]
    category['great_ppl_names'].extend([i for i in lines if '_GREAT_' in i])
    lines = [i for i in lines if not('_GREAT_' in i )]
    category['feature_names'].extend([i for i in lines if '_FEATURE_' in i])
    lines = [i for i in lines if not('_FEATURE_' in i)]
    category['terrain_names'].extend([i for i in lines if '_TERRAIN_' in i])
    lines = [i for i in lines if not('_TERRAIN_' in i)]
    category['nulls'].extend([i for i in lines if '_NULL_' in i])
    lines = [i for i in lines if not('_NULL_' in i)]
    if len(lines) > 1:
        print('Warning: some lines left')
        print(lines)

for name, item in category.items():
    parsed_data = [ast.literal_eval(item_.replace(';', ',')) for item_ in item]
    parsed_data_ = [i[0] for i in parsed_data]
    sorted_data = sorted(parsed_data_, key=lambda x: x[1])
    converted_back = [(i[1], i[0], i[2]) for i in sorted_data]
    converted_back = [str(i) for i in converted_back]
    content = ",\n".join(converted_back)
    file_content = 'INSERT OR REPLACE INTO LocalizedText(Text, Tag, Language) VALUES\n' + content + ';'
    with open(f'../Localisation/{name}.sql', 'w') as file:
        file.write(file_content)

# separation script
short_lines = [i for i in lines if len(i) <= 200]
medium_lines = [i for i in lines if 600>= len(i) > 200]
long_lines = [i for i in lines if len(i) > 600]

long = "".join(long_lines)
medium = "".join(medium_lines)
short = "".join(short_lines)

print(long)
