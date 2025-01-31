import os
import shutil
import re

from System.IO import Path
from System.IO import File
from System.IO import Directory
import System
import System.Random
import Sce.Atf as atf
import Firaxis.AssetEditing
import clr
import Sce.Atf.Adaptation
import Firaxis
import Firaxis.CivTech
import Firaxis.Granny
import DatabaseWrapper


SOURCE_PATH = ""
DESTINATION_PATH = ""

UNIT = "UNIT_ZWEIHANDER"

PATTERN = r'text="([^"]*)"'

randomGenerator = System.Random()
VARIATION_ATTACHMENT_PREFIX = 'V:'
def loadUnitsArtdef(projectName):
    # Need to determine if the landmark file is open. If it is, make sure it's active. If it's not then open it
    artDefPath = System.IO.Path.Combine(civTech.AllProjectsMap[projectName].Paths.ArtDefRoot, 'Units.artdef')
    unitsArtDefUri = Uri(artDefPath)
    return atfDocService.OpenExistingDocument(artDefEditor, unitsArtDefUri)


def loadUnitBinsArtdef(projectName):
    # Need to determine if the landmark file is open. If it is, make sure it's active. If it's not then open it
    artDefPath = System.IO.Path.Combine(civTech.AllProjectsMap[projectName].Paths.ArtDefRoot, 'Unit_Bins.artdef')
    unitsBinArtDefUri = Uri(artDefPath)
    return atfDocService.OpenExistingDocument(artDefEditor, unitsBinArtDefUri)

def extract_animations(filepath):
    anims = []
    with open(filepath, 'r') as file:
        bhv_lines = file.readlines()
    for line in bhv_lines:
        if 'm_AnimationName' in line:
            match = re.search(PATTERN, line)
            if match:
                anm_name = match.group(1)
                anm_file_path = SOURCE_PATH + '/Geometries/{anm_name}.anm'
                fgx_file_path = SOURCE_PATH + '/Geometries/{anm_name}.fgx'
                anims.append(anm_file_path)
                anims.append(fgx_file_path)
    return anims


def extract_textures(filepath):
    textures = []
    with open(filepath, 'r') as file:
        mtl_lines = file.readlines()
    for line in mtl_lines:
        if 'm_AnimationName' in line:
            match = re.search(PATTERN, line)
            if match:
                tex_name = match.group(1)
                tex_file_path = SOURCE_PATH + '/Geometries/{tex_name}.tex'
                dds_file_path = SOURCE_PATH + '/Geometries/{tex_name}.dds'
                textures.append(tex_file_path)
                textures.append(dds_file_path)
    return textures


def GetAssetFromBinReference(artDefSetAdapter, binReference, cultureReference):
    # this tries to match the logic used in 'WorldView_UnitSystem.cpp' by the UnitSystem::FindAttachments() function
    tokenizedBinReference = re.split(r'[;/]', binReference)

    binName = ''
    group = ''
    culture = ''
    assetName = ''

    if (len(tokenizedBinReference) >= 1) and tokenizedBinReference[0]:
        binName = tokenizedBinReference[0]
        if (len(tokenizedBinReference) >= 2) and tokenizedBinReference[1]:
            group = tokenizedBinReference[1]
            if (len(tokenizedBinReference) >= 3) and tokenizedBinReference[2]:
                culture = tokenizedBinReference[2]
                if (len(tokenizedBinReference) >= 4) and tokenizedBinReference[3]:
                    assetName = tokenizedBinReference[3]

    if ('[empty]' in str.lower(binName)):
        return None

    if (binName.startswith(VARIATION_ATTACHMENT_PREFIX) or group.startswith(
            VARIATION_ATTACHMENT_PREFIX) or culture.startswith(VARIATION_ATTACHMENT_PREFIX) or assetName.startswith(
            VARIATION_ATTACHMENT_PREFIX)):
        return None

    if ((len(culture) == 0) or ('#' == str.lower(culture)) or ('[culture]' == str.lower(culture))):
        culture = cultureReference

    UnitAttachmentBinCollections = ArtDefRegistry.GetSuitableCollections('Units', 'UnitAttachmentBins')

    for eachBinCollection in UnitAttachmentBinCollections:

        binAdapter = None

        for eachElement in eachBinCollection.Elements:
            if str.lower(eachElement.Name) == str.lower(binName):
                binAdapter = eachElement
                break

        if (not binAdapter):
            return None

        groupAdapter = None
        for eachCollection in binAdapter.Children:
            if (eachCollection.CollectionName == 'Groups'):
                for eachElement in eachCollection.Elements:
                    if str.lower(eachElement.Name) == str.lower(group):
                        groupAdapter = eachElement
                        break
                break
        if (not groupAdapter):
            return None

        cultureAdapter = None
        for eachCollection in groupAdapter.Children:
            if (eachCollection.CollectionName == 'Cultures'):
                foundCulture = False
                anyCultureAdapter = None
                for eachElement in eachCollection.Elements:
                    if str.lower(eachElement.Name) == str.lower(culture):
                        cultureAdapter = eachElement
                        foundCulture = True
                        break
                    if str.lower(eachElement.Name) == str.lower('any'):
                        anyCultureAdapter = eachElement
                if (not foundCulture):
                    if (anyCultureAdapter):
                        cultureAdapter = anyCultureAdapter
                    elif len(eachCollection.Elements) >= 1:
                        cultureAdapter = eachCollection.Elements[0]
                break
        if (not cultureAdapter):
            return None

        assetAdapter = None
        for eachCollection in cultureAdapter.Children:
            if (eachCollection.CollectionName == 'Assets'):
                foundAsset = False
                for eachElement in eachCollection.Elements:
                    if str.lower(eachElement.Name) == str.lower(assetName):
                        assetAdapter = eachElement
                        foundAsset = True
                        break
                if (not foundAsset):
                    if len(eachCollection.Elements) >= 1:
                        assetAdapter = eachCollection.Elements[randomGenerator.Next(len(eachCollection.Elements))]
                break

        if (not assetAdapter):
            return None

        EntryName = None
        for eachField in assetAdapter.Fields.Items:
            if (eachField.ParameterName == "Asset"):
                EntryName = eachField.EntryName

        if (not EntryName):
            return None

        assetEntityName = ''
        XLPEntry = XLPRegistry.FindXLPData(EntryName)
        if XLPEntry:
            assetEntityName = XLPEntry.ObjectName

        if (not assetEntityName):
            return None

        return assetEntityName

def FiraxisAdapter(projectName, unit_name):
    binArtDefDocument = loadUnitBinsArtdef(projectName)
    binArtDefAdapter = binArtDefDocument.As[Firaxis.AssetEditing.ArtDefSetAdapter]()

    artDefDocument = loadUnitsArtdef(projectName)
    artDefSetAdapter = artDefDocument.As[Firaxis.AssetEditing.ArtDefSetAdapter]()

    # Get handle to the ArtDefCollection that we want
    unitMemberCollectionAdapter = None
    for eachCollection in artDefSetAdapter.RootCollections:
        if (eachCollection.Name == 'UnitMemberTypes'):
            unitMemberCollectionAdapter = eachCollection
            break

    for eachElement in unitMemberCollectionAdapter.Elements:
        if (eachElement.Name == unit_name):
            unitMemberElement = eachElement

    unitMemberCultureAdapter = None
    for eachCollection in unitMemberElement.Collections:
        if eachCollection.Name == "Cultures":
            if not unitMemberCultureAdapter:
                unitMemberCultureAdapter = eachCollection.Elements[0]
            break

    unitMemberVariationAdapter = None
    for eachCollection in unitMemberCultureAdapter.Collections:
        if eachCollection.Name == "Variations":
            if not unitMemberVariationAdapter:
                unitMemberVariationAdapter = eachCollection.Elements[0]
            break

    unitMemberAttachmentsAdapter = None
    listOfAttachments = []
    for eachCollection in unitMemberVariationAdapter.Collections:
        if eachCollection.Name == "Attachments":
            for eachElement in eachCollection.Elements:
                attachment = Attachment()
                for eachField in eachElement.Fields:
                    if eachField.Name == "Point":
                        attachment.AttachmentPoint = eachField.Value.ParameterValue
                    if eachField.Name == "Tint":
                        attachment.tintColor = None  # We need to do the Artdef collection reference to color mapping, sigh..

                assetBin = None
                for eachAttachmentCollection in eachElement.Collections:
                    if eachAttachmentCollection.Name == "Bins":
                        if (len(eachAttachmentCollection.Elements) >= 1):
                            assetBin = eachAttachmentCollection.Elements[
                                randomGenerator.Next(len(eachAttachmentCollection.Elements))].Name
                        break
                assetEntityName = GetAssetFromBinReference(binArtDefAdapter, assetBin,
                                                           unitMemberCultureAdapter.Name)

                if assetEntityName:
                    attachment.AssetName = assetEntityName

                if attachment.AssetName:
                    listOfAttachments.append(attachment)
            break
    return listOfAttachments

source_unit_artdef_path = SOURCE_PATH + '/Artdefs/Units.artdef'
source_unit_bins_artdef_path = SOURCE_PATH + '/Artdefs/Units.artdef'
dest_unit_artdef_path = SOURCE_PATH + '/Artdefs/Units.artdef'
dest_unit_bins_artdef_path = SOURCE_PATH + '/Artdefs/Units.artdef'
# given a source project, and a transporting project

# specify a unit to move acoess

# it will find the unit in Units.artdef, then find the UnitMemberTypes associated with it

# it will then iterate through the attachments the unitMember has, using either Any or European

# it will look up the UnitAttachments in Unit_Bins, and see if it exists there, again using cultural reference

# If it does, we then look up the asset under the filepath Assets/ and cache it


def main():
    cached = []
    asset_file_path = ''
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
                behaviour_file_path = SOURCE_PATH + '/Behaviours/{behaviour_name}.bhv'
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
                geo_file_path = SOURCE_PATH + '/Geometries/{geo_name}.geo'
                fgx_file_path = SOURCE_PATH + '/Geometries/{geo_name}.fgx'
                cached.append(geo_file_path)
                cached.append(fgx_file_path)

    for asset_line in asset_lines:
        if '<m_ObjectName' in asset_line:
            match = re.search(PATTERN, asset_line)
            if match:
                mat_name = match.group(1)
                mat_file_path = SOURCE_PATH + '/Materials/{mat_name}.mtl'
                if os.path.exists(mat_file_path):
                    textures = extract_textures(mat_file_path)
                    cached.append(mat_file_path)
                    cached.extend(textures)

    print(cached)
    # for source_filepath in cached:
        # dest_filepath = source_filepath.replace(SOURCE_PATH, DESTINATION_PATH)
        # if os.path.exists(source_filepath):
            # shutil.copy(source_filepath, dest_filepath)
        # else:
        #     print(f'skipping {source_filepath}')
    # then open each material, find each entry that looks like <m_eObjectType>TEXTURE</m_eObjectType>, then find the line
    # before it, then extract a string from <m_ObjectName text="$1"/>, and cache the file under Textures with .tex and .dds

    # finally we transfer over all the cached files

    # we also transfer the Unit entry to the destination project units.artdef, and the unitBins entry to the destinmation
    # projects unit_bins.artdef

if __name__ == "__main__":
    main()
