# Author: thecrazyscotsman
# Version: 2
# Also work done by Deliverator
# Amended by Slothoth

import os
import logging

from xml_handler import read_xml, pretty_print_xml, dict_to_xml, xml_to_string, save_pretty_xml_to_file


def generate_mod_art(save_file_location):
    logging.basicConfig(level=logging.WARNING)
    logger = logging.getLogger(__name__)

    lib_check = ['CityBuildings', 'ColorKey', 'DynamicGeometry', 'FOWSprite', 'FOWTexture', 'GameLighting', 'Landmark',
                 'Leader', 'LeaderFallback', 'LeaderLighting', 'Light', 'OverlayTexture', 'RouteDecalMaterial',
                 'RouteDoodad', 'SkyBoxTexture', 'StrategicView_DirectedAsset', 'StrategicView_Route',
                 'StrategicView_Sprite', 'StrategicView_TerrainBlend', 'StrategicView_TerrainBlendCorners',
                 'StrategicView_TerrainType', 'TerrainAsset', 'TerrainElement', 'TerrainMaterial', 'TileBase',
                 'UILensAsset', 'UITexture', 'Unit', 'VFX', 'Water', 'Wave', 'WonderMovie']

    xml_map = {'Units': ['Units', 'Audio'], 'Cultures': ['Units', 'Landmarks', 'Cultures', 'WorldView_Translate'],
                  'Eras': ['Units', 'Landmarks', 'WorldViewRoutes', 'WorldView_Translate', 'StrategicView_Translate',
                           'Audio'], 'UnitActivities': ['Units'], 'Clutter': ['Clutter'], 'Landmarks': ['Landmarks'],
                  'CityGenerators': ['Landmarks'],
                  'Civilizations': ['Landmarks', 'Civilizations', 'WorldView_Translate', 'Audio'],
                  'Improvements': ['Landmarks', 'StrategicView_Sprite', 'Improvements', 'WorldView_Translate',
                                   'StrategicView_Translate', 'Audio', 'IndirectGrid', 'UnitSimulation'],
                  'Resources': ['Landmarks', 'Resources', 'WorldView_Translate', 'Audio'], 'Farms': ['Farms'],
                  'TimeOfDay': ['GameLighting'],
                  'StrategicView': ['StrategicView_Properties', 'StrategicView_Sprite', 'StrategicView_Route',
                                    'StrategicView_TerrainType', 'StrategicView_TerrainBlendCorners',
                                    'StrategicView_TerrainBlend'],
                  'Districts': ['StrategicView_Sprite', 'WorldView_Translate', 'StrategicView_Translate', 'Audio'],
                  'Buildings': ['StrategicView_Sprite', 'WorldView_Translate', 'StrategicView_Translate'],
                  'TerrainMaterialSet': ['Terrain'], 'GraphicsTweaks': ['Terrain', 'IndirectGrid', 'AOSystem'],
                  'WorldViewRoutes': ['WorldViewRoutes', 'WorldView_Translate'], 'UserInterfaceBLPs': ['UI'],
                  'FOWConfig': ['FOW'], 'WonderMovie': ['WonderMovie'],
                  'Overlay': ['UILensAsset', 'Overlay', 'RangeArrows'], 'VFX': ['VFX'], 'WaterSettings': ['Water'],
                  'ScreenWashEffects': ['ScreenWashEffects'], 'Camera': ['Camera'],
                  'Terrains': ['Terrains', 'WorldView_Translate', 'StrategicView_Translate', 'Audio', 'IndirectGrid'],
                  'Features': ['Features', 'WorldView_Translate', 'StrategicView_Translate', 'Audio', 'IndirectGrid'],
                  'Appeal': ['WorldView_Translate'], 'Routes': ['StrategicView_Translate'],
                  'Cities': ['StrategicView_Translate'], 'GoodyHuts': ['Audio'],
                  'Leaders': ['Audio', 'LeaderLighting', 'Leaders'], 'LeaderFallback': ['LeaderFallback'],
                  'Lenses': ['Lenses'], 'WaveSettings': ['Wave'], 'DynamicGeo': ['DynamicGeometry'],
                  'UIPreview': ['UIPreview'], 'SkyBox': ['SkyBox'], 'Minimap': ['Minimap'],
                  'UnitOperations': ['UnitSimulation']}

    deprecated = {'GenericObject': ['GenericObject'], 'ColorKeys': ['ColorKeys']}
    # xml_map.update(deprecated)

    template_mod_art = read_xml('template.mod.art.xml')
    # filled_out_example = read_xml('correct.xml')
    # USER INPUT
    env = '../../FallFromHeaven'
    if env == '':
        env = input("Please enter your project path: ")

    # Create list of files in folders
    aDir = env + "//ArtDefs"
    xDir = env + "//XLPs"
    artdefs = os.listdir(aDir)
    if os.path.isdir(xDir):
        xlps = os.listdir(xDir)
    else:
        xlps = []
    artdef_dict = {}
    xList = []

    # Populate list with artdef file name and template name
    for a in artdefs:
        aTree = read_xml(aDir + "//" + a, as_xml=True)
        a_name = aTree.find('m_TemplateName').attrib['text']
        artdef_dict[a_name] = a

    # Populate list with xlp file name and class/package names
    for f in xlps:
        xTree = read_xml(xDir + "//" + f, as_xml=True)
        x_vals = (f, xTree.findall('m_ClassName').attrib['text'], xTree.findall('PackageName').attrib['text'])
        if any([i is None for i in x_vals]):
            raise KeyError('Couldnt find ClassName or PackageName in xlp.')
        xList.append(x_vals)

    art_consumers = {i.get('ConsumerName', i['consumerName'])['@text']: i for i in
                     template_mod_art['AssetObjects..GameArtSpecification']['artConsumers']['Element']}
    for key, val in artdef_dict.items():
        for element in xml_map[key]:
            if art_consumers[element]['relativeArtDefPaths'] == '':
                art_consumers[element]['relativeArtDefPaths'] = {'Element': []}  # is single item lists allowed?
            art_consumers[element]['relativeArtDefPaths']['Element'].append({'@text': val})

    packages_ = {i['libraryName']['@text']: i for i in
                 template_mod_art['AssetObjects..GameArtSpecification']['gameLibraries']['Element']}
    for lib_name, class_name, package_name in xList:
        packages_[class_name]['relativePackagePaths'] = {
            'Element': {'@text': package_name}}  # what about FIRST tuple val?

    root = dict_to_xml(template_mod_art)
    xml_string = xml_to_string(root)
    pretty_xml_string = pretty_print_xml(xml_string)
    save_pretty_xml_to_file(pretty_xml_string, save_file_location)


# generate_mod_art('FallFromHeaven.Mod.art.xml')
