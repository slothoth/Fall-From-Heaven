import xmltodict
import json
import glob
import logging


def assign_artdef(artdef, name):
    artdef_cpy = artdef.copy()
    artdef_cpy['m_Name'] = {'@text': name}
    return artdef_cpy


def artdef():
    unit_artdef()
    building_artdef()
    resource_artdef()


def unit_artdef():
    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(__name__)
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
        artdef_dict = {i['m_CollectionName']['@text']: i['Element'] for i in artdef_info_ if i.get('Element', None) is not None}
        for i, j in artdef_dict.items():
            if isinstance(j, dict):
                full_artdef[i].append(j)
            elif isinstance(j, list):
                full_artdef[i].extend(j)
            else:
                print('weird collection')

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

    artdef_template['AssetObjects::ArtDefSet']['m_RootCollections']['Element']['Element'] = []
    root = artdef_template['AssetObjects::ArtDefSet']['m_RootCollections']['Element']['Element']
    """root.append(assign_artdef(artdef_total['UNIT_ARCHER'], 'SLTH_UNIT_BLOODPET'))
    
    with open('prebuilt/Artdefs/Units.artdef', 'w') as file:
         xmltodict.unparse(artdef_template, output=file, pretty=True)"""

    artdef_units = artdef_map['Units']

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
                logger.info(f'found more than one match for {vanilla_ref}')
                failed['multsearch'].append(artdef_units[mod_ref])
            elif len(search) == 0:
                logger.info(f'no match for {vanilla_ref}')
                failed['nosearch'].append(artdef_units[mod_ref])
            else:
                root.append(assign_artdef(artdef_total[search[0]], mod_ref))
                search_found.append(artdef_units[mod_ref])
        else:
            root.append(assign_artdef(artdef_total[vanilla_ref], mod_ref))
            logger.warning(f"{mod_ref} now uses {artdef_total[vanilla_ref]['m_Name']['@text']}")

    with open('prebuilt/Artdefs/Units.artdef', 'w') as file:
        xmltodict.unparse(artdef_template, output=file, pretty=True)


def building_artdef():
    folder = "E:\Steam\steamapps\common\Sid Meier's Civilization VI"
    string = 'Buildings.artdef'
    artdefs = [f for f in glob.glob(f'{folder}/**/*{string}*', recursive=True)]

    with open(artdefs[0], 'r') as file:
        artdef_info = xmltodict.parse(file.read())
    artdef_info_ = artdef_info['AssetObjects..ArtDefSet']['m_RootCollections']['Element']
    full_artdef = {i['m_CollectionName']['@text']: i.get('Element', []) for i in artdef_info_}

    for artdef in artdefs[1:]:
        with open(artdef, 'r') as file:
            artdef_info = xmltodict.parse(file.read())
        artdef_info_ = artdef_info['AssetObjects..ArtDefSet']['m_RootCollections']['Element']
        artdef_dict = {i['m_CollectionName']['@text']: i['Element'] for i in artdef_info_ if
                       i.get('Element', None) is not None}
        for i, j in artdef_dict.items():
            if isinstance(j, dict):
                full_artdef[i].append(j)
            elif isinstance(j, list):
                full_artdef[i].extend(j)
            else:
                print('weird collection')

    uniques = []
    not_uniques = []
    drop_indices = []
    for idx, i in enumerate(full_artdef['Building']):
        if i['m_Name']['@text'] not in uniques:
            uniques.append(i['m_Name']['@text'])
        else:
            not_uniques.append(i['m_Name']['@text'])
            drop_indices.append(idx)

    drop_indices.reverse()
    for i in drop_indices:
        del full_artdef['Building'][i]

    artdef_total = {i['m_Name']['@text']: i for i in full_artdef['Building']}

    with open("plans/asset_map_plan.json", 'r') as json_file:
        artdef_map = json.load(json_file)

    with open('Gen_ArtDefs/Buildings.artdef', 'r') as file:
        artdef_template = xmltodict.parse(file.read())

    artdef_template['AssetObjects..ArtDefSet']['m_RootCollections']['Element'][0]['Element'] = []
    root = artdef_template['AssetObjects..ArtDefSet']['m_RootCollections']['Element'][0]['Element']
    root.append(assign_artdef(artdef_total['BUILDING_OLD_GOD_OBELISK'], 'SLTH_BUILDING_BREWERY'))

    with open('prebuilt/Artdefs/Buildings.artdef', 'w') as file:
         xmltodict.unparse(artdef_template, output=file, pretty=True)
    return                                                              # once it works do full

    artdef_build = artdef_map['Buildings']

    failed = {'multsearch': [], 'nosearch': []}
    search_found = []
    for mod_ref, vanilla_ref in artdef_build.items():
        if any([vanilla_ref in i for i in ['CUSTOM', 'IRRELEVANT', 'LIKELY_SUKRITACT_WILDLIFE?']]):
            continue
        if 'ADAPTED' in vanilla_ref:
            vanilla_ref = vanilla_ref.replace('ADAPTED', 'UNIT')
        if artdef_total.get(vanilla_ref) is None:
            search = [i for i in artdef_total if vanilla_ref.replace('UNIT_', '') in i]
            if len(search) > 1:
                root.append(assign_artdef(artdef_total[search[0]], mod_ref))
                logger.info(f'found more than one match for {vanilla_ref}')
                failed['multsearch'].append(artdef_build[mod_ref])
            elif len(search) == 0:
                logger.info(f'no match for {vanilla_ref}')
                failed['nosearch'].append(artdef_build[mod_ref])
            else:
                root.append(assign_artdef(artdef_total[search[0]], mod_ref))
                search_found.append(artdef_build[mod_ref])
        else:
            root.append(assign_artdef(artdef_total[vanilla_ref], mod_ref))
            logger.warning(f"{mod_ref} now uses {artdef_total[vanilla_ref]['m_Name']['@text']}")

    with open('prebuilt/Artdefs/Units.artdef', 'w') as file:
        xmltodict.unparse(artdef_template, output=file, pretty=True)


def feature_artdef():
    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(__name__)
    folder = "E:\Steam\steamapps\common\Sid Meier's Civilization VI"
    string = 'Features.artdef'
    artdefs = [f for f in glob.glob(f'{folder}/**/*{string}*', recursive=True)]

    with open(artdefs[0], 'r') as file:
        artdef_info = xmltodict.parse(file.read())
    artdef_info_ = artdef_info['AssetObjects..ArtDefSet']['m_RootCollections']['Element']['Element']
    full_artdef = {i['m_Name']['@text']: i for i in artdef_info_}

    for artdef in artdefs[1:]:
        with open(artdef, 'r') as file:
            artdef_info = xmltodict.parse(file.read())
        artdef_info_ = artdef_info['AssetObjects..ArtDefSet']['m_RootCollections']['Element']['Element']
        if isinstance(artdef_info_, dict):
            artdef_info_ = [artdef_info_]
        artdef_dict = {i['m_Name']['@text']: i for i in artdef_info_}
        full_artdef.update(artdef_dict)

    artdef_total = full_artdef

    with open("plans/asset_map_plan.json", 'r') as json_file:
        artdef_map = json.load(json_file)

    """with open('Gen_ArtDefs/Features.artdef', 'r') as file:
        artdef_template = xmltodict.parse(file.read())

    artdef_template['AssetObjects::ArtDefSet']['m_RootCollections']['Element']['Element'] = []
    root = artdef_template['AssetObjects::ArtDefSet']['m_RootCollections']['Element']['Element']
    root.append(assign_artdef(artdef_total['UNIT_ARCHER'], 'SLTH_UNIT_BLOODPET'))

    with open('prebuilt/Artdefs/Features.artdef', 'w') as file:
         xmltodict.unparse(artdef_template, output=file, pretty=True)"""

    artdef_features = artdef_map['Features']

    failed = {'multsearch': [], 'nosearch': []}
    search_found = []
    for mod_ref, vanilla_ref in artdef_features.items():
        if any([vanilla_ref in i for i in ['CUSTOM', 'IRRELEVANT', 'LIKELY_SUKRITACT_WILDLIFE?']]):
            continue
        if 'ADAPTED' in vanilla_ref:
            vanilla_ref = vanilla_ref.replace('ADAPTED', 'UNIT')
        if artdef_total.get(vanilla_ref) is None:
            search = [i for i in artdef_total if vanilla_ref.replace('UNIT_', '') in i]
            if len(search) > 1:
                root.append(assign_artdef(artdef_total[search[0]], mod_ref))
                logger.info(f'found more than one match for {vanilla_ref}')
                failed['multsearch'].append(artdef_features[mod_ref])
            elif len(search) == 0:
                logger.info(f'no match for {vanilla_ref}')
                failed['nosearch'].append(artdef_features[mod_ref])
            else:
                root.append(assign_artdef(artdef_total[search[0]], mod_ref))
                search_found.append(artdef_features[mod_ref])
        else:
            root.append(assign_artdef(artdef_total[vanilla_ref], mod_ref))
            logger.warning(f"{mod_ref} now uses {artdef_total[vanilla_ref]['m_Name']['@text']}")

    with open('prebuilt/Artdefs/Features.artdef', 'w') as file:
        xmltodict.unparse(artdef_template, output=file, pretty=True)


def resource_artdef():
    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(__name__)
    folder = "E:\Steam\steamapps\common\Sid Meier's Civilization VI"
    string = 'Resources.artdef'
    artdefs = [f for f in glob.glob(f'{folder}/**/*{string}*', recursive=True)]

    with open(artdefs[0], 'r') as file:
        artdef_info = xmltodict.parse(file.read())
    artdef_info_ = artdef_info['AssetObjects..ArtDefSet']['m_RootCollections']['Element']['Element']
    full_artdef = {i['m_Name']['@text']: i for i in artdef_info_}

    for artdef in artdefs[1:]:
        with open(artdef, 'r') as file:
            artdef_info = xmltodict.parse(file.read())
        if 'Element' not in artdef_info['AssetObjects..ArtDefSet']['m_RootCollections']['Element']:
            continue
        artdef_info_ = artdef_info['AssetObjects..ArtDefSet']['m_RootCollections']['Element']['Element']
        if isinstance(artdef_info_, dict):
            artdef_info_ = [artdef_info_]
        artdef_dict = {i['m_Name']['@text']: i for i in artdef_info_}
        full_artdef.update(artdef_dict)

    artdef_total = full_artdef

    with open("plans/asset_map_plan.json", 'r') as json_file:
        artdef_map = json.load(json_file)

    with open('Gen_ArtDefs/Resources.artdef', 'r') as file:
        artdef_template = xmltodict.parse(file.read())

    artdef_template['AssetObjects..ArtDefSet']['m_RootCollections']['Element']['Element'] = []
    root = artdef_template['AssetObjects..ArtDefSet']['m_RootCollections']['Element']['Element']

    artdef_resources = artdef_map['Resources']

    failed = {'multsearch': [], 'nosearch': []}
    search_found = []
    for mod_ref, vanilla_ref in artdef_resources.items():
        if any([vanilla_ref in i for i in ['CUSTOM', 'IRRELEVANT', 'LIKELY_SUKRITACT_WILDLIFE?']]):
            continue
        if 'ADAPTED' in vanilla_ref:
            vanilla_ref = vanilla_ref.replace('ADAPTED', 'UNIT')
        if artdef_total.get(vanilla_ref) is None:
            search = [i for i in artdef_total if vanilla_ref.replace('UNIT_', '') in i]
            if len(search) > 1:
                root.append(assign_artdef(artdef_total[search[0]], mod_ref))
                logger.info(f'found more than one match for {vanilla_ref}')
                failed['multsearch'].append(artdef_resources[mod_ref])
            elif len(search) == 0:
                logger.info(f'no match for {vanilla_ref}')
                failed['nosearch'].append(artdef_resources[mod_ref])
            else:
                root.append(assign_artdef(artdef_total[search[0]], mod_ref))
                search_found.append(artdef_resources[mod_ref])
        else:
            root.append(assign_artdef(artdef_total[vanilla_ref], mod_ref))
            logger.warning(f"{mod_ref} now uses {artdef_total[vanilla_ref]['m_Name']['@text']}")

    with open('prebuilt/Artdefs/Resources.artdef', 'w') as file:
        xmltodict.unparse(artdef_template, output=file, pretty=True)
