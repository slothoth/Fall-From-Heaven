import glob
import json
from xml_handler import dict_to_xml, xml_to_string, pretty_print_xml, save_pretty_xml_to_file, read_xml
from utils import make_or_add
import os


def make_colors(model_obj):
    with open("data/config.json", 'r') as json_file:
        config = json.load(json_file)
    folder = config.get('civ_install', None)
    if folder == "YOUR_DIRECTORY_HERE":
        folder = os.environ.get('CIV_INSTALL', None)
        if folder is None:
            raise FileNotFoundError(
                "Set your civ VI install filepath in config.json.")
    map_set = get_colors(folder, None)
    make_or_add(model_obj['sql_inserts'], map_set, 'PlayerColors')


def get_colors(folder, config):
    artdef_name = 'Colors.xml'
    artdefs = [f for f in glob.glob(f'{folder}/**/*{artdef_name}*', recursive=True)]
    if len(artdefs) == 0:
        raise FileNotFoundError(
            f'No files were found that match Units.artdef. Make sure your config.json points to your civ VI directory.')

    artdef_info = read_xml(artdefs[0])
    root_1, root_2, root_3 = navigate_xml(artdef_info)
    full_artdef = {i['Type']: i for i in artdef_info[root_1][root_2][root_3]}

    for artdef in artdefs[1:]:
        artdef_info = read_xml(artdef)
        if 'GameInfo' in artdef_info:
            root_1 = 'GameInfo'
        elif 'Database' in artdef_info:
            root_1 = 'Database'
        else:
            raise ValueError
        if 'PlayerColors' in artdef_info[root_1]:
            root_2 = 'PlayerColors'
        elif 'Colors' in artdef_info[root_1]:
            root_2 = 'Colors'
        else:
            raise ValueError
        if 'Row' in artdef_info[root_1][root_2]:
            root_3 = 'Row'
        elif 'Replace' in artdef_info[root_1][root_2]:
            root_3 = 'Replace'
        else:
            raise ValueError
        color_info = artdef_info[root_1][root_2][root_3]
        if isinstance(color_info, dict):
            color_info = [color_info]
        artdef_dict = {i['Type']: i for i in color_info}
        if any(['STANDARD' in i for i in artdef_dict]):
            print('aa')
        full_artdef.update(artdef_dict)

    with open("data/asset_map.json", 'r') as json_file:
        assets = json.load(json_file)['leaders']
    new_color_set = {}
    failed = {'multsearch': [], 'nosearch': []}
    search_found = []
    used = []
    for mod_ref, vanilla_ref in assets.items():
        if full_artdef.get(vanilla_ref) is None:
            if ' AND ' in vanilla_ref:
                items = [i.strip().split(' AND ') for i in vanilla_ref.split(',')]
                new_color = {'Type': mod_ref, 'Usage': 'Unique', 'PrimaryColor': items[0][0],
                             'SecondaryColor': items[0][1], 'Alt1PrimaryColor': items[1][0],
                             'Alt1SecondaryColor': items[1][1], 'Alt2PrimaryColor': items[2][0],
                             'Alt2SecondaryColor': items[2][1], 'Alt3PrimaryColor': items[3][0],
                             'Alt3SecondaryColor': items[3][1]}
                new_color_set[mod_ref] = new_color
            else:
                search = [i for i in full_artdef if vanilla_ref.replace('LEADER_', '') in i]
                if len(search) > 1:
                    new_color_set[mod_ref] = full_artdef[search[0]].copy()
                    new_color_set[mod_ref]['Type'] = mod_ref
                    print(f'found more than one match for {vanilla_ref}, using the first found.')
                    failed['multsearch'].append(assets[mod_ref])
                    used.append(vanilla_ref)
                elif len(search) == 0:
                    print(f'no match for {vanilla_ref}')
                    failed['nosearch'].append(assets[mod_ref])
                else:
                    new_color_set[mod_ref] = full_artdef[search[0]].copy()
                    new_color_set[mod_ref]['Type'] = mod_ref
                    search_found.append(assets[mod_ref])
                    used.append(vanilla_ref)
                    print(f'Found partial match for specified {vanilla_ref}. {mod_ref} now uses {search[0]} colours')
        else:
            new_color_set[mod_ref] = full_artdef[vanilla_ref].copy()
            new_color_set[mod_ref]['Type'] = mod_ref
            used.append(vanilla_ref)
            print(f"Success! {mod_ref} now uses {full_artdef[vanilla_ref]['Type']} colours")

    new_colors = []
    for d in new_color_set.values():
        new_colors.extend([i for key, i in d.items() if key != 'Type' and key != 'Usage'])
    new_colors = list(set(new_colors))
    color_rgb_map = [{"Type": i, "Color": full_artdef[i]} for i in new_colors]
    [(i.pop('Alt3PrimaryColor'), i.pop('Alt3SecondaryColor'), i.pop('Alt2PrimaryColor'), i.pop('Alt2SecondaryColor'),
      i.pop('Alt1PrimaryColor'), i.pop('Alt1SecondaryColor')) for i in new_color_set.values()]
    return new_color_set


def navigate_xml(artdef_info):
    if 'GameInfo' in artdef_info:
        root_1 = 'GameInfo'
    elif 'Database' in artdef_info:
        root_1 = 'Database'
    else:
        raise ValueError
    if 'PlayerColors' in artdef_info[root_1]:
        root_2 = 'PlayerColors'
    elif 'Colors' in artdef_info[root_1]:
        root_2 = 'Colors'
    else:
        raise ValueError
    if 'Row' in artdef_info[root_1][root_2]:
        root_3 = 'Row'
    elif 'Replace' in artdef_info[root_1][root_2]:
        root_3 = 'Replace'
    else:
        raise ValueError
    return root_1, root_2, root_3

"""
INSERT INTO LoadingInfo
			(LeaderType,			ForegroundImage,				BackgroundImage,					PlayDawnOfManAudio	)
VALUES		('LEADER_IPG_EMHYR',	'LEADER_IPG_EMHYR_NEUTRAL',		'LEADER_IPG_EMHYR_BACKGROUND',		0					),
			('LEADER_IPG_CALVEIT',	'LEADER_IPG_CALVEIT_NEUTRAL',	'LEADER_IPG_CALVEIT_BACKGROUND',	0					);
"""