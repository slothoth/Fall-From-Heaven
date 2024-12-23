import xmltodict
import json
import glob
import logging
import os
from copy import deepcopy

class Artdef:
    def __init__(self, asset_map=None):
        if asset_map is not None:
            with open("plans/asset_map_plan.json", 'r') as json_file:
                self.asset_map = json.load(json_file)
        with open("data/config.json", 'r') as json_file:
            config = json.load(json_file)
        self.folder = config.get('civ_install', None)
        if self.folder == "YOUR_DIRECTORY_HERE":
            self.folder = os.environ.get('CIV_INSTALL', None)
            if self.folder is None:
                raise FileNotFoundError(
                    "Set your civ VI install filepath in config.json.")

        logging.basicConfig(level=logging.INFO)
        self.logger = logging.getLogger(__name__)
        with open('Gen_ArtDefs/Icons.xml', 'r') as file:
            self.icons = xmltodict.parse(file.read())
        self.icons['GameInfo']['IconDefinitions']['Row'] = []

    def assign_artdef(self, artdef, name):
        artdef_cpy = artdef.copy()
        artdef_cpy['m_Name'] = {'@text': name}
        return artdef_cpy

    def do_artdef(self):
        self.unit_artdef(self.folder)
        self.building_artdef(self.folder)
        self.resource_artdef(self.folder)
        self.icon_resource_wrangler()
        self.icon_units_wrangler(self.folder)
        self.write_xml()

    def write_xml(self):
        with open('../../FallFromHeaven/Icons.xml', 'w') as file:
            xmltodict.unparse(self.icons, output=file, pretty=True)

    def unit_artdef(self, folder):
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
        for idx, i in enumerate(full_artdef['Units']):
            if i['m_Name']['@text'] not in uniques:
                uniques.append(i['m_Name']['@text'])
            else:
                not_uniques.append(i)
                drop_indices.append(idx)

        drop_indices.reverse()
        for i in drop_indices:
            del full_artdef['Units'][i]

        artdef_total = {i['m_Name']['@text']: i for i in full_artdef['Units']}

        # reset scout, warrior
        artdef_total['UNIT_SCOUT_CAT'] = [i for i in not_uniques if 'SCOUT' in i['m_Name']['@text']][0]

        artdef_total['UNIT_ZOMBIE'] = [i for i in not_uniques if 'WARRIOR' in i['m_Name']['@text']][0]

        with open("plans/asset_map_plan.json", 'r') as json_file:
            artdef_map = json.load(json_file)

        with open('Gen_ArtDefs/Units.artdef', 'r') as file:
            artdef_template = xmltodict.parse(file.read())

        artdef_template['AssetObjects..ArtDefSet']['m_RootCollections']['Element']['Element'] = []
        root = artdef_template['AssetObjects..ArtDefSet']['m_RootCollections']['Element']['Element']

        artdef_units = artdef_map['Units']

        failed = {'multsearch': [], 'nosearch': []}
        search_found = []
        used = []
        for mod_ref, vanilla_ref in artdef_units.items():
            if any([i in vanilla_ref for i in ['CUSTOM', 'IRRELEVANT', 'LIKELY_SUKRITACT_WILDLIFE?', 'EQUIPMENT']]):
                continue
            if 'ADAPTED' in vanilla_ref:
                vanilla_ref = vanilla_ref.replace('ADAPTED', 'UNIT')
            if artdef_total.get(vanilla_ref) is None:
                search = [i for i in artdef_total if vanilla_ref.replace('UNIT_', '') in i]
                if len(search) > 1:
                    root.append(self.assign_artdef(artdef_total[search[0]], mod_ref))
                    self.logger.info(f'found more than one match for {vanilla_ref}')
                    failed['multsearch'].append(artdef_units[mod_ref])
                    used.append(vanilla_ref)
                elif len(search) == 0:
                    self.logger.info(f'no match for {vanilla_ref}')
                    failed['nosearch'].append(artdef_units[mod_ref])
                else:
                    root.append(self.assign_artdef(artdef_total[search[0]], mod_ref))
                    search_found.append(artdef_units[mod_ref])
                    used.append(vanilla_ref)
            else:
                root.append(self.assign_artdef(artdef_total[vanilla_ref], mod_ref))
                used.append(vanilla_ref)
                self.logger.info(f"{mod_ref} now uses {artdef_total[vanilla_ref]['m_Name']['@text']}")

        with open('../../FallFromHeaven/Artdefs/Units.artdef', 'w') as file:
            xmltodict.unparse(artdef_template, output=file, pretty=True)

        total_units = set([i for i in artdef_total])
        unused = list(total_units - set(used))
        self.logger.info(f"{unused}")

    def building_artdef(self, folder):
        string = 'Buildings.artdef'
        artdefs = [f for f in glob.glob(f'{folder}/**/*{string}*', recursive=True)]

        with open(artdefs[0], 'r') as file:
            artdef_info = xmltodict.parse(file.read())
        artdef_info_ = artdef_info['AssetObjects..ArtDefSet']['m_RootCollections']['Element']
        full_artdef = {i['m_CollectionName']['@text']: i.get('Element', []) for i in artdef_info_}
        for i in full_artdef:
            if isinstance(full_artdef[i], dict):
                full_artdef[i] = [full_artdef[i]]
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
        root.append(self.assign_artdef(artdef_total['BUILDING_OLD_GOD_OBELISK'], 'SLTH_BUILDING_BREWERY'))

        with open('../../FallFromHeaven/Artdefs/Buildings.artdef', 'w') as file:
            xmltodict.unparse(artdef_template, output=file, pretty=True)
        return  # once it works do full
      
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

        with open('../../FallFromHeaven/Artdefs/Units.artdef', 'w') as file:
            xmltodict.unparse(artdef_template, output=file, pretty=True)

    def feature_artdef(self, folder):
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

        with open('Gen_ArtDefs/Features.artdef', 'r') as file:
            artdef_template = xmltodict.parse(file.read())

        artdef_template['AssetObjects::ArtDefSet']['m_RootCollections']['Element']['Element'] = []
        root = artdef_template['AssetObjects::ArtDefSet']['m_RootCollections']['Element']['Element']
        """
        root.append(self.assign_artdef(artdef_total['UNIT_ARCHER'], 'SLTH_UNIT_BLOODPET'))
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
                    root.append(self.assign_artdef(artdef_total[search[0]], mod_ref))
                    self.logger.info(f'found more than one match for {vanilla_ref}')
                    failed['multsearch'].append(artdef_features[mod_ref])
                elif len(search) == 0:
                    self.logger.info(f'no match for {vanilla_ref}')
                    failed['nosearch'].append(artdef_features[mod_ref])
                else:
                    root.append(self.assign_artdef(artdef_total[search[0]], mod_ref))
                    search_found.append(artdef_features[mod_ref])
            else:
                root.append(self.assign_artdef(artdef_total[vanilla_ref], mod_ref))
                self.logger.warning(f"{mod_ref} now uses {artdef_total[vanilla_ref]['m_Name']['@text']}")

        with open('../../FallFromHeaven/Artdefs/Features.artdef', 'w') as file:
            xmltodict.unparse(artdef_template, output=file, pretty=True)

    def resource_artdef(self, folder):
        logging.basicConfig(level=logging.INFO)
        logger = logging.getLogger(__name__)
        string = 'Resources.artdef'
        artdefs = [f for f in glob.glob(f'{folder}/**/*{string}*', recursive=True)]
        position = 1
        with open(artdefs[0], 'r') as file:
            artdef_info = xmltodict.parse(file.read())
        if 'Element' not in artdef_info['AssetObjects..ArtDefSet']['m_RootCollections']['Element']:
            for i in artdefs[1:]:
                position += 1
                with open(i, 'r') as file:
                    artdef_info = xmltodict.parse(file.read())
                if 'Element' in artdef_info['AssetObjects..ArtDefSet']['m_RootCollections']['Element']:
                    break

        artdef_info_ = artdef_info['AssetObjects..ArtDefSet']['m_RootCollections']['Element']['Element']
        full_artdef = {i['m_Name']['@text']: i for i in artdef_info_}

        for artdef in artdefs[position:]:
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
                    root.append(self.assign_artdef(artdef_total[search[0]], mod_ref))
                    logger.info(f'found more than one match for {vanilla_ref}')
                    failed['multsearch'].append(artdef_resources[mod_ref])
                elif len(search) == 0:
                    logger.info(f'no match for {vanilla_ref}')
                    failed['nosearch'].append(artdef_resources[mod_ref])
                else:
                    root.append(self.assign_artdef(artdef_total[search[0]], mod_ref))
                    search_found.append(artdef_resources[mod_ref])
            else:
                root.append(self.assign_artdef(artdef_total[vanilla_ref], mod_ref))
                logger.debug(f"{mod_ref} now uses {artdef_total[vanilla_ref]['m_Name']['@text']}")

        with open('../../FallFromHeaven/Artdefs/Resources.artdef', 'w') as file:
            xmltodict.unparse(artdef_template, output=file, pretty=True)

    def icon_resource_wrangler(self):
        with open("data/icons.json", 'r') as json_file:
            icon_atlas_map = json.load(json_file)

        big_dict = {}
        [big_dict.update({j.replace('ICON_', ''): {'atlas': k, 'index': l} for j, l in i.items()}) for k, i in
         icon_atlas_map.items()]
        icon_map = self.asset_map['Resources']

        for mod_ref, vanilla_ref in icon_map.items():
            self.icons['GameInfo']['IconDefinitions']['Row'].append(
                {'@Atlas': big_dict[vanilla_ref]['atlas'], '@Index': big_dict[vanilla_ref]['index'],
                 '@Name': f'ICON_{mod_ref}'})
            self.icons['GameInfo']['IconDefinitions']['Row'].append(
                {'@Atlas': big_dict[vanilla_ref]['atlas'] + '_FOW', '@Index': big_dict[vanilla_ref]['index'],
                 '@Name': f'ICON_{mod_ref}_FOW'})

    def icon_units_wrangler(self, folder):
        string = 'Icons_Units.xml'
        icon_xml = [f for f in glob.glob(f'{folder}/**/*{string}*', recursive=True)]
        with open(icon_xml[0], 'r') as file:
            icon_info = xmltodict.parse(file.read())['GameInfo']['IconDefinitions']['Row']

        full_icons = {i['@Name']: i for i in icon_info}

        for i in icon_xml[1:]:
            with open(i, 'r') as file:
                icon_info = xmltodict.parse(file.read())
            if icon_info.get('GameInfo', {}).get('IconDefinitions') is None:
                continue
            icon_info = icon_info['GameInfo']['IconDefinitions']['Row']
            if isinstance(icon_info, dict):
                icon_info = [icon_info]
            full_icons.update({i['@Name']: i for i in icon_info})

        icon_map = self.asset_map['Units']
        for mod_ref, vanilla_ref in icon_map.items():
            if any([vanilla_ref in i for i in ['CUSTOM', 'IRRELEVANT', 'LIKELY_SUKRITACT_WILDLIFE?']]):
                continue
            if 'ADAPTED' in vanilla_ref:
                vanilla_ref = vanilla_ref.replace('ADAPTED', 'UNIT')
            if mod_ref in self.asset_map['units_scenario']:
                vanilla_ref = self.asset_map['units_scenario'][mod_ref]
            vanilla_ref = 'ICON_' + vanilla_ref
            if full_icons.get(vanilla_ref) is None:
                search = [i for i in full_icons if vanilla_ref.replace('UNIT_', '') in i]
                if len(search) > 1:
                    self.logger.info(f'found more than one match for {vanilla_ref}')
                if len(search) == 0:
                    self.logger.info(f'no match for {vanilla_ref}')
                    continue
                vanilla_ref = search[0].replace('_FOW', '')

            icon_def = full_icons[vanilla_ref].copy()
            icon_def['@Name'] = f'ICON_{mod_ref}'
            self.icons['GameInfo']['IconDefinitions']['Row'].append(icon_def)
            if full_icons.get(vanilla_ref + '_FOW') is not None:
                fow_def = icon_def.copy()
                fow_def['@Name'] += '_FOW'
                fow_def['@Atlas'] += '_FOW'
                self.icons['GameInfo']['IconDefinitions']['Row'].append(fow_def)

    def icon_buildings_wrangler(self, folder):
        string = 'Icons_Buildings.xml'
        icon_xml = [f for f in glob.glob(f'{folder}/**/*{string}*', recursive=True)]
        with open(icon_xml[0], 'r') as file:
            icon_info = xmltodict.parse(file.read())['GameInfo']['IconDefinitions']['Row']

        full_icons = {i['@Name']: i for i in icon_info}

        for i in icon_xml[1:]:
            with open(i, 'r') as file:
                icon_info = xmltodict.parse(file.read())
            if icon_info.get('GameInfo', {}).get('IconDefinitions') is None:
                continue
            icon_info = icon_info['GameInfo']['IconDefinitions']['Row']
            if isinstance(icon_info, dict):
                icon_info = [icon_info]
            full_icons.update({i['@Name']: i for i in icon_info})

        icon_map = self.asset_map['Units']
        for mod_ref, vanilla_ref in icon_map.items():
            if any([vanilla_ref in i for i in ['CUSTOM', 'IRRELEVANT', 'LIKELY_SUKRITACT_WILDLIFE?']]):
                continue
            if 'ADAPTED' in vanilla_ref:
                vanilla_ref = vanilla_ref.replace('ADAPTED', 'UNIT')
            if mod_ref in self.asset_map['units_scenario']:
                vanilla_ref = self.asset_map['units_scenario'][mod_ref]
            vanilla_ref = 'ICON_' + vanilla_ref
            if full_icons.get(vanilla_ref) is None:
                search = [i for i in full_icons if vanilla_ref.replace('UNIT_', '') in i]
                if len(search) > 1:
                    self.logger.info(f'found more than one match for {vanilla_ref}')
                if len(search) == 0:
                    self.logger.info(f'no match for {vanilla_ref}')
                    continue
                vanilla_ref = search[0].replace('_FOW', '')

            icon_def = full_icons[vanilla_ref].copy()
            icon_def['@Name'] = f'ICON_{mod_ref}'
            self.icons['GameInfo']['IconDefinitions']['Row'].append(icon_def)
            if full_icons.get(vanilla_ref + '_FOW') is not None:
                fow_def = icon_def.copy()
                fow_def['@Name'] += '_FOW'
                fow_def['@Atlas'] += '_FOW'
                self.icons['GameInfo']['IconDefinitions']['Row'].append(fow_def)


    def leader_fallback_artdef(self):
        string = 'Icons_Units.xml'
        icon_xml = [f for f in glob.glob(f'{folder}/**/*{string}*', recursive=True)]
        with open(icon_xml[0], 'r') as file:
            icon_info = xmltodict.parse(file.read())['GameInfo']['IconDefinitions']['Row']

        full_icons = {i['@Name']: i for i in icon_info}

        for i in icon_xml[1:]:
            with open(i, 'r') as file:
                icon_info = xmltodict.parse(file.read())
            if icon_info.get('GameInfo', {}).get('IconDefinitions') is None:
                continue
            icon_info = icon_info['GameInfo']['IconDefinitions']['Row']
            if isinstance(icon_info, dict):
                icon_info = [icon_info]
            full_icons.update({i['@Name']: i for i in icon_info})

        icon_map = self.asset_map['Units']
        for mod_ref, vanilla_ref in icon_map.items():
            if any([vanilla_ref in i for i in ['CUSTOM', 'IRRELEVANT', 'LIKELY_SUKRITACT_WILDLIFE?']]):
                continue
            if 'ADAPTED' in vanilla_ref:
                vanilla_ref = vanilla_ref.replace('ADAPTED', 'UNIT')
            if mod_ref in self.asset_map['units_scenario']:
                vanilla_ref = self.asset_map['units_scenario'][mod_ref]
            vanilla_ref = 'ICON_' + vanilla_ref
            if full_icons.get(vanilla_ref) is None:
                search = [i for i in full_icons if vanilla_ref.replace('UNIT_', '') in i]
                if len(search) > 1:
                    self.logger.info(f'found more than one match for {vanilla_ref}')
                if len(search) == 0:
                    self.logger.info(f'no match for {vanilla_ref}')
                    continue
                vanilla_ref = search[0].replace('_FOW', '')

            icon_def = full_icons[vanilla_ref].copy()
            icon_def['@Name'] = f'ICON_{mod_ref}'
            self.icons['GameInfo']['IconDefinitions']['Row'].append(icon_def)
            if full_icons.get(vanilla_ref + '_FOW') is not None:
                fow_def = icon_def.copy()
                fow_def['@Name'] += '_FOW'
                fow_def['@Atlas'] += '_FOW'
                self.icons['GameInfo']['IconDefinitions']['Row'].append(fow_def)

    def unit_culture_artdef(self, folder, job, jobtype):
        logging.basicConfig(level=logging.INFO)
        logger = logging.getLogger(__name__)
        string = 'Unit_Bins.artdef'
        artdefs = [f for f in glob.glob(f'{folder}/**/*{string}*', recursive=True)]
        position = 1
        if jobtype == 'skin':
            filter = ['Bodies', 'Heads', 'BaseMale_Bodies', 'BaseMale_Heads', 'BaseFemale_Bodies', 'BaseFemale_Heads', 'BaseFemale_Hair']
        armors = ['BaseMale_Armor']
        if jobtype == 'hairs':
            filter = ['BaseMale_FaceHair', 'BaseMale_Hair_Ancient_to_Medieval', 'BaseMale_Mustache', 'BaseMale_Hair_Medieval_to_Modern']
        artdef_to_add = self.absorb_artdef(artdefs[0], filter, job)

        for artdef in artdefs[position:]:
            artdef_to_add = self.absorb_artdef(artdef, filter, job, deepcopy(artdef_to_add))

        return artdef_to_add

    def absorb_artdef(self, filepath, filter, job, existing_artdef=None):
        with open(filepath, 'r') as file:
            string_artdef = file.read()
            string_artdef = string_artdef.replace('\t', '')
            artdef_info = xmltodict.parse(string_artdef)

        artdef_classes = artdef_info['AssetObjects..ArtDefSet']['m_RootCollections']['Element']
        artdef_index = [idx for idx, i in enumerate(artdef_classes) if i['m_CollectionName'] == {'@text': 'UnitAttachmentBins'}][0]
        artdef_info_ = artdef_classes[artdef_index].get('Element', None)
        if artdef_info_ is None:
            return existing_artdef
        elif isinstance(artdef_info_, dict):
            artdef_info_ = [artdef_info_]
        bodies_info = [i for i in artdef_info_ if i['m_Name']['@text'] in filter]
        if len(bodies_info) == 0:
            return existing_artdef
        if existing_artdef:
            mapper = {i['m_Name']['@text']: i['m_ChildCollections']['Element']['Element'] for i in
                      existing_artdef['AssetObjects..ArtDefSet']['m_RootCollections']['Element'][artdef_index][
                          'Element']}
        new_bodies = []
        for body_type in bodies_info:
            items_to_edit = body_type['m_ChildCollections']['Element']['Element']
            if isinstance(items_to_edit, dict):
                items_to_edit = [items_to_edit]
            changed_items = []
            for j in items_to_edit:
                culture_check = j['m_ChildCollections']['Element']
                if culture_check['m_CollectionName']['@text'] == 'Cultures':
                    individual_cultures = culture_check['Element']
                    if isinstance(individual_cultures, dict):
                        individual_cultures = [individual_cultures]
                    for culture, action in job.items():
                        new_entry = deepcopy(individual_cultures[0])
                        if 'Skin' in action:
                            new_entry['m_Fields']['m_Values']['Element']['m_ElementName']['@text'] = action
                        elif action == 'NO_HAIR':
                            if isinstance(new_entry['m_ChildCollections']['Element']['Element'], list):
                                new_entry['m_ChildCollections']['Element']['Element'] = new_entry['m_ChildCollections']['Element']['Element'][0]
                            new_entry['m_ChildCollections']['Element']['Element']['m_ChildCollections'] = None
                        elif 'SCALE' in action:
                            new_scaler = action.split('$_')[1]
                            if isinstance(new_entry['m_ChildCollections']['Element']['Element'], dict):
                                new_entry['m_ChildCollections']['Element']['Element'] = [new_entry['m_ChildCollections']['Element']['Element']]
                            for child_to_alter in new_entry['m_ChildCollections']['Element']['Element']:
                                found_scale_entries = [i for i in child_to_alter['m_Fields']['m_Values']['Element'] if i['m_ParamName'] == {'@text': 'Scale'}]
                                if len(found_scale_entries) == 1:
                                    scale_entry = found_scale_entries[0]
                                    scale_entry['m_fValue'] = new_scaler
                                else:
                                    print(f'ERROR: Found {len(found_scale_entries)} matching text: scale in element, skipping.')
                        new_entry['m_Name'] = {'@text': culture}
                        individual_cultures.append(new_entry)
                    j['m_ChildCollections']['Element']['Element'] = individual_cultures
                    changed_items.append(j)
                else:
                    print('error, collection isnt cultures')
            if existing_artdef is not None:
                body_key = body_type['m_Name']['@text']
                existing_collection = mapper.get(body_key, None)
                if existing_collection is not None:
                    existing_collection += changed_items
                else:
                    body_type['m_ChildCollections']['Element']['Element'] = changed_items
                    existing_artdef['AssetObjects..ArtDefSet']['m_RootCollections']['Element'][artdef_index]['Element'].append(body_type)
                    mapper[body_key] = existing_artdef['AssetObjects..ArtDefSet']['m_RootCollections']['Element'][artdef_index]['Element'][-1]
            else:
                body_type['m_ChildCollections']['Element']['Element'] = changed_items
                new_bodies.append(body_type)
        if existing_artdef is None:
            artdef_info['AssetObjects..ArtDefSet']['m_RootCollections']['Element'][artdef_index]['Element'] = new_bodies
            return artdef_info
        else:
            return existing_artdef