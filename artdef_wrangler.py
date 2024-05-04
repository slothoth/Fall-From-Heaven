import xmltodict
import json
import glob

def assign_artdef(artdef, name):
    artdef_cpy = artdef.copy()
    artdef_cpy['m_Name'] = {'@text': name}
    return artdef_cpy

# Example usage
folder = "E:\Steam\steamapps\common\Sid Meier's Civilization VI"
string = 'Units.artdef'
artdefs = [f for f in glob.glob(f'{folder}/**/*{string}*', recursive=True)]

with open(artdefs[0], 'r') as file:
    artdef_info = xmltodict.parse(file.read())
artdef_info_ = artdef_info['AssetObjects..ArtDefSet']['m_RootCollections']['Element']
full_artdef = {i['m_CollectionName']['@text']: i.get('Element', []) for i in artdef_info_}

for artdef in artdefs[1:]:
    with open(artdef, 'r') as file:
        artdef_info = xmltodict.parse(file.read())
    artdef_info_ = artdef_info['AssetObjects..ArtDefSet']['m_RootCollections']['Element']
    artdef_dict = {i['m_CollectionName']['@text']:i['Element'] for i in artdef_info_ if i.get('Element', None) is not None}
    for i, j in artdef_dict.items():
        if isinstance(j, dict):
            full_artdef[i].append(j)
        elif isinstance(j, list):
            full_artdef[i].extend(j)
        else:
            print('weird collection')

dhs = xmltodict.unparse({'Element': full_artdef['Units'][1]})
print(dhs)
uniques = []
not_uniques = []
drop_indices = []
for idx, i in enumerate(full_artdef['Units']):
    if i['m_Name']['@text'] not in uniques:
        uniques.append(i['m_Name']['@text'])
    else:
        not_uniques.append(i['m_Name']['@text'])
        drop_indices.append(idx)

drop_indices.reverse()
for i in drop_indices:
    del full_artdef['Units'][i]

artdef_total = {i['m_Name']['@text']:i for i in full_artdef['Units']}

with open("plans/asset_map_plan.json", 'r') as json_file:
    artdef_map = json.load(json_file)

with open('Gen_ArtDefs/Units.artdef', 'r') as file:
    artdef_template = xmltodict.parse(file.read())

artdef_template['AssetObjects::ArtDefSet']['m_RootCollections'] = []
root = artdef_template['AssetObjects::ArtDefSet']['m_RootCollections']

artdef_units = artdef_map['Units']

root.append(assign_artdef(artdef_total['UNIT_SCOUT'], 'SLTH_UNIT_BLOODPET'))
with open('prebuilt/Artdefs/Units.artdef', 'w') as file:
    xmltodict.unparse(artdef_template, output=file, pretty=True)

failed = {'multsearch': [], 'nosearch': []}
search_found = []
for mod_ref, vanilla_ref in artdef_units.items():
    if any([vanilla_ref in i for i in ['CUSTOM', 'IRRELEVANT', 'LIKELY_SUKRITACT_WILDLIFE?']]):
        continue
    if 'ADAPTED' in vanilla_ref:
        vanilla_ref = vanilla_ref.replace('ADAPTED', 'UNIT')
    if artdef_total.get(vanilla_ref) is None:
        search = [i for i in artdef_total if vanilla_ref.replace('UNIT_', '') in i]
        if len(search) > 1:
            root.append(assign_artdef(artdef_total[search[0]], mod_ref))
            print(f'found more than one match for {vanilla_ref}')
            failed['multsearch'].append(artdef_units[mod_ref])
        elif len(search) == 0:
            print(f'no match for {vanilla_ref}')
            failed['nosearch'].append(artdef_units[mod_ref])
        else:
            root.append(assign_artdef(artdef_total[search[0]], mod_ref))
            search_found.append(artdef_units[mod_ref])
    else:
        root.append(assign_artdef(artdef_total[vanilla_ref], mod_ref))

with open('prebuilt/Artdefs/Units.artdef', 'w') as file:
    xmltodict.unparse(artdef_template, output=file, pretty=True)
print(artdef_map)