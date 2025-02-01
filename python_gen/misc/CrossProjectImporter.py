import os
import shutil
import re
import xmltodict
from copy import deepcopy

SOURCE_PATH = "C:/Users/Sam/Documents/Firaxis ModBuddy/Civilization VI/WarfareExpanded/MC_MasterTemplate/WarfareExpanded"
DESTINATION_PATH = "C:/Users/Sam/Documents/Firaxis ModBuddy/Civilization VI/FallFromHeavenBuilder/FallFromHeavenBuilder"

DESTINATION_XLP = f'{DESTINATION_PATH}/XLPs/UnitBinParts.xlp'
UNIT = "UNIT_ZWEIHANDER"
#UNIT = "UNIT_TREBUCHET"

ASSET_PER_BIN_MAX = 2

PATTERN = r'text="([^"]*)"'

VARIATION_ATTACHMENT_PREFIX = 'V:'

def extract_animations(filepath):
    anims = []
    with open(filepath, 'r') as file:
        bhv_lines = file.readlines()
    for line in bhv_lines:
        if 'm_ObjectName' in line:
            match = re.search(PATTERN, line)
            if match:
                anm_name = match.group(1)
                anm_file_path = SOURCE_PATH + '/Geometries/' + anm_name + '.anm'
                fgx_file_path = SOURCE_PATH + '/Geometries/' + anm_name + '.fgx'
                anims.append(anm_file_path)
                anims.append(fgx_file_path)
    return anims


def extract_textures(filepath):
    textures = []
    with open(filepath, 'r') as file:
        mtl_lines = file.readlines()
    for line in mtl_lines:
        if 'm_ObjectName' in line:
            match = re.search(PATTERN, line)
            if match:
                tex_name = match.group(1)
                tex_file_path = SOURCE_PATH + '/Textures/' + tex_name + '.tex'
                dds_file_path = SOURCE_PATH + '/Textures/' + tex_name + '.dds'
                textures.append(tex_file_path)
                textures.append(dds_file_path)
    return textures

source_unit_artdef_path = SOURCE_PATH + '/Artdefs/Units.artdef'
source_unit_bins_artdef_path = SOURCE_PATH + '/Artdefs/Unit_Bins.artdef'
dest_unit_artdef_path = SOURCE_PATH + '/Artdefs/Units.artdef'
dest_unit_bins_artdef_path = SOURCE_PATH + '/Artdefs/Unit_Bins.artdef'
# given a source project, and a transporting project

# specify a unit to move acoess

# it will find the unit in Units.artdef, then find the UnitMemberTypes associated with it

# it will then iterate through the attachments the unitMember has, using either Any or European

# it will look up the UnitAttachments in Unit_Bins, and see if it exists there, again using cultural reference

# If it does, we then look up the asset under the filepath Assets/ and cache it


def main():
    with open('../Gen_ArtDefs/Units.artdef', 'r') as file:
        artdef_template = xmltodict.parse(file.read())
    with open('../Gen_ArtDefs/Units.artdef', 'r') as file:
        artdef_bins_template = xmltodict.parse(file.read())
    artdef_template['AssetObjects..ArtDefSet']['m_RootCollections']['Element'][0]['Element'] = []
    with open(source_unit_artdef_path, 'r') as file:
        artdef_info = xmltodict.parse(file.read())
    source_unit_artdef_base = artdef_info['AssetObjects..ArtDefSet']['m_RootCollections']['Element']
    source_units = source_unit_artdef_base[00]['Element']
    source_unit_members = source_unit_artdef_base[10]
    chosen_unit = [i for i in source_units if i['m_Name']['@text'] == UNIT][0]
    artdef_template['AssetObjects..ArtDefSet']['m_RootCollections']['Element'][0]['Element'].append(chosen_unit)
    members = chosen_unit['m_ChildCollections']['Element'][0]['Element']
    unitMemberTypes = []
    if isinstance(members, dict):
        members = [members]
    for i in members:
        unitMemberTypes.append(i['m_Fields']['m_Values']['Element'][2]['m_ElementName']['@text'])

    unitAttachmentBins = []
    for i in source_unit_members['Element']:
        if i['m_Name']['@text'] in unitMemberTypes:
            cultural_variants = None
            cultures = i['m_ChildCollections']['Element']['Element']
            culture_match = None
            for j in cultures:
                if culture_match is None:
                    if j['m_Name']['@text'] == 'Any':
                        culture_match = True
                        cult_match = 'Any'
                    elif j['m_Name']['@text'] == 'European':
                        culture_match = True
                        cult_match = 'European'
                    elif j['m_Name']['@text'] == 'Mediterranean':
                        culture_match = True
                        cult_match = 'Mediterranean'
                    else:
                        continue
                if culture_match is not None:
                    cultural_variants = j['m_ChildCollections']['Element']['Element']
                    break

            if cultural_variants is not None:
                new_cultures = []
                for puk in i['m_ChildCollections']['Element']['Element']:
                    if puk['m_Name']['@text'] == 'Any':
                        new_cultures.append(puk)
                        break
                if isinstance(cultural_variants, dict):
                    cultural_variants = [cultural_variants]
                for k in cultural_variants:
                    if isinstance(k['m_ChildCollections'], dict):
                        k['m_ChildCollections'] = [k['m_ChildCollections']]
                    for v in k['m_ChildCollections']:
                        for attach in v['Element']['Element']:
                            if isinstance(attach['m_ChildCollections'], dict):
                                attach['m_ChildCollections'] = [attach['m_ChildCollections']]
                            for kujo in attach['m_ChildCollections']:
                                if isinstance(kujo['Element'], dict):
                                    kujo['Element'] = [kujo['Element']]
                                for bujo in kujo['Element']:
                                    end_attachment = bujo['Element']['m_Name']['@text']
                                    if 'V:' not in end_attachment:
                                        unitAttachmentBins.append(end_attachment)
                artdef_template['AssetObjects..ArtDefSet']['m_RootCollections']['Element'][1]['Element'] = i
                artdef_template['AssetObjects..ArtDefSet']['m_RootCollections']['Element'][1]['Element']['m_ChildCollections']['Element']['Element'] = new_cultures

    artdef_template['AssetObjects..ArtDefSet']['m_RootCollections']['Element'][2]['Element'] = []
    xlp_assets = {}
    with open(source_unit_bins_artdef_path, 'r') as file:
        artdef_info = xmltodict.parse(file.read())
    source_unit_bins_artdef = artdef_info['AssetObjects..ArtDefSet']['m_RootCollections']['Element'][9]['Element']
    for unit_location in unitAttachmentBins:
        base_bin, specific_asset = unit_location.split('/')
        for unit_bin in source_unit_bins_artdef:
            if unit_bin['m_Name']['@text'] == base_bin:
                copy_bin = deepcopy(unit_bin)
                copy_bin['m_ChildCollections']['Element']['Element'] = []
                detailed_bin = unit_bin['m_ChildCollections']['Element']['Element']
                if isinstance(detailed_bin, dict):
                    detailed_bin = [detailed_bin]
                for detail_bin in detailed_bin:
                    if detail_bin['m_Name']['@text'] == specific_asset:
                        copy_detail = deepcopy(detail_bin)
                        copy_detail['m_ChildCollections']['Element']['Element'] = []
                        asset_cultural = detail_bin['m_ChildCollections']['Element']['Element']         # amend to incluide in artdef
                        if isinstance(asset_cultural, dict):
                            asset_cultural = [asset_cultural]
                        cached_culture = None
                        for culture_assets in asset_cultural:
                            if culture_assets['m_Name']['@text'] == 'Any':
                                cached_culture = culture_assets
                            if culture_assets['m_Name']['@text'] == 'European' and cached_culture is None:
                                cached_culture = culture_assets
                            elif culture_assets['m_Name']['@text'] == 'Mediterranean' and cached_culture is None:
                                cached_culture = culture_assets
                        if cached_culture:
                            copy_detail['m_ChildCollections']['Element']['Element'].append(cached_culture)
                            possible_bins = cached_culture['m_ChildCollections']['Element']['Element'].copy()
                            copy_detail['m_ChildCollections']['Element']['Element'][0]['m_ChildCollections'][
                                'Element']['Element'] = []
                            if isinstance(possible_bins, dict):
                                possible_bins = [possible_bins]
                            for idx, poss_bin in enumerate(possible_bins):
                                if idx < ASSET_PER_BIN_MAX:
                                    xlp_info = poss_bin['m_Fields']['m_Values']['Element'][0]
                                    xlp_path = xlp_info['m_XLPPath']['@text']
                                    xlp_entry_name = xlp_info['m_EntryName']['@text']
                                    if xlp_path not in xlp_assets:
                                        xlp_assets[xlp_path] = []
                                    xlp_assets[xlp_path].append(xlp_entry_name)
                                    copy_detail['m_ChildCollections']['Element']['Element'][0]['m_ChildCollections']['Element']['Element'].append(poss_bin)
                            copy_bin['m_ChildCollections']['Element']['Element'].append(copy_detail)
                        else:
                            print('ERROR: Cultures Any not found.')

                artdef_template['AssetObjects..ArtDefSet']['m_RootCollections']['Element'][2]['Element'].append(copy_bin)

    with open('New_Units.artdef', 'w') as file:
        xmltodict.unparse(artdef_template, output=file, pretty=True)
    xlp_set = {}
    for xlp_path, xlp_entries in xlp_assets.items():
        xlp_set[xlp_path] = list(set(xlp_entries))

    end_assets = []
    end_xlp_mapping = {}
    for xlp_path, xlp_entries in xlp_set.items():
        combined_xlp_path = f'{SOURCE_PATH}/XLPs/{xlp_path}'
        with open(combined_xlp_path, 'r') as file:
            xlp_lines = file.readlines()

        for xlp_entry in xlp_entries:
            for idx, k in enumerate(xlp_lines):
                if 'm_EntryID' in k:
                    if xlp_entry in k:
                        entity_line = xlp_lines[idx+1]
                        match = re.search(PATTERN, entity_line)
                        if match:
                            entity_name = match.group(1)
                            end_assets.append(entity_name)
                            match = re.search(PATTERN, k)
                            if match:
                                end_xlp_mapping[entity_name] = match.group(1)
                        else:
                            print('ERROR')

    with open(DESTINATION_XLP, 'r') as file:
        xlp_og = file.readlines()

    end_editable = next(idx for idx, i in enumerate(xlp_og) if '</m_Entries>' in i)
    xlp_conclusion = xlp_og[end_editable:]
    xlp_sample = ['\t\t<Element>\n', '\t\t\t<m_EntryID text="$1"/>\n', '\t\t\t<m_ObjectName text="$1"/>\n', '\t\t</Element>\n']
    new_xlp = xlp_og[:end_editable]
    for end_asset in end_assets:
        asset_file_path = f'{SOURCE_PATH}/Assets/{end_asset}.ast'
        transfer_unit_assets(asset_file_path)
        matching_xlp_name = end_xlp_mapping[end_asset]
        new_xlp_entry = xlp_sample.copy()
        new_xlp_entry[1] = new_xlp_entry[1].replace('$1', matching_xlp_name)
        new_xlp_entry[2] = new_xlp_entry[2].replace('$1', end_asset)
        new_xlp = new_xlp + new_xlp_entry

    new_xlp = new_xlp + xlp_conclusion
    with open(DESTINATION_XLP, 'w') as file:
        file.writelines(new_xlp)


def transfer_unit_assets(asset_file_path):
    cached = [asset_file_path]
    with open(asset_file_path, 'r') as file:
        asset_lines = file.readlines()

    next_line = False
    for asset_line in asset_lines:
        if '<m_behaviorInstances>' in asset_line:
            next_line = True
        if next_line:
            next_line = False
            match = re.search(PATTERN, asset_line)
            if match:
                behaviour_name = match.group(1)
                behaviour_file_path = SOURCE_PATH + '/Behaviours/' + behaviour_name + '.bhv'
                if os.path.exists(behaviour_file_path):
                    cached.append(behaviour_file_path)
                    animations = extract_animations(behaviour_file_path)
                    cached.extend(animations)
    # then open the asset file and work over that

    # first check m_behaviorInstances and see if any exist in folder Behaviours
    # if they do then we cache that file, the iterate over each <m_AnimationName text="$1"/> to see if any of the animations are in
    # the Animations folder, if so we cache them

    # we then check in the asset file, the GeometrySet data.
    # Find all <m_GeoName text="$1"/> use that to find the .geo and .fgx file in Geometries
    # then find the materials, under m_ObjectName, under the Materials folder, use <m_ObjectName text="$1"/> and cache the file using .mtl
    for asset_line in asset_lines:
        if '<m_GeoName' in asset_line:
            match = re.search(PATTERN, asset_line)
            if match:
                geo_name = match.group(1)
                geo_file_path = SOURCE_PATH + '/Geometries/' + geo_name + '.geo'
                fgx_file_path = SOURCE_PATH + '/Geometries/' + geo_name + '.fgx'
                cached.append(geo_file_path)
                cached.append(fgx_file_path)

    for asset_line in asset_lines:
        if '<m_ObjectName' in asset_line:
            match = re.search(PATTERN, asset_line)
            if match:
                mat_name = match.group(1)
                mat_file_path = SOURCE_PATH + '/Materials/' + mat_name + '.mtl'
                if os.path.exists(mat_file_path):
                    textures = extract_textures(mat_file_path)
                    cached.append(mat_file_path)
                    cached.extend(textures)

    for source_filepath in cached:
        dest_filepath = source_filepath.replace(SOURCE_PATH, DESTINATION_PATH)
        if os.path.exists(source_filepath):
            shutil.copy(source_filepath, dest_filepath)
        else:
            print(f'skipping {source_filepath}')
    # then open each material, find each entry that looks like <m_eObjectType>TEXTURE</m_eObjectType>, then find the line
    # before it, then extract a string from <m_ObjectName text="$1"/>, and cache the file under Textures with .tex and .dds

    # finally we transfer over all the cached files

    #
    # we also transfer the Unit entry to the destination project units.artdef, and the unitBins entry to the destination
    # projects unit_bins.artdef

if __name__ == "__main__":
    main()
