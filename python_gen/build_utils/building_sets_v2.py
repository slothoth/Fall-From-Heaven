from itertools import combinations
overall_start = '''<Element>
						<m_CollectionName text="BuildingSets"/>
						<m_ReplaceMergedCollectionElements>false</m_ReplaceMergedCollectionElements>'''
start_set = '''
<Element>
    <m_Fields>
        <m_Values>
            <Element class="AssetObjects..CollectionValue">
                <m_eObjectType>INVALID</m_eObjectType>
                <m_eValueType>ARTDEF_REF</m_eValueType>
                <m_Values>'''
setElement =f'''<Element class="AssetObjects..ArtDefReferenceValue">
                        <m_ElementName text="$BUILDING"/>
                        <m_RootCollectionName text="Building"/>
                        <m_ArtDefPath text="Buildings.artdef"/>
                        <m_CollectionIsLocked>true</m_CollectionIsLocked>
                        <m_TemplateName text="Buildings"/>
                        <m_ParamName text="Set_$NUM"/>
                    </Element>'''
end_set ='''
                </m_Values>
                <m_ParamName text="Set"/>
            </Element>
        </m_Values>
    </m_Fields>
    <m_ChildCollections/>
    <m_Name text="$ELEMENT_LIST"/>
    <m_AppendMergedParameterCollections>false</m_AppendMergedParameterCollections>
</Element>
'''


'''DIS_CTY_EmptyCity_Base'''
'''DIS_CTY_Palace_Base'''
'''DIS_CTY_PalaceMonument_Base'''
'''DIS_CTY_PalaceMonumentGranary_Base'''
'''DIS_CTY_PalaceGranary_Base'''
'''DIS_CTY_Monument_Base'''
'''DIS_CTY_Granary_Base'''
'''DIS_CTY_MonumentGranary_Base'''

BaseVariantsStart='''
<Element>
    <m_Fields>
        <m_Values>
            <Element class="AssetObjects..ArtDefReferenceValue">
                <m_ElementName text="$BUILDING_SET_LIST"/>
                <m_RootCollectionName text="BuildingSets"/>
                <m_ArtDefPath text="Landmarks.artdef"/>
                <m_CollectionIsLocked>true</m_CollectionIsLocked>
                <m_TemplateName text="Landmarks"/>
                <m_ParamName text="Set_HeroBuildings"/>
            </Element>
            <Element class="AssetObjects..ArtDefReferenceValue">
                <m_ElementName text="DEFAULT"/>
                <m_RootCollectionName text="ArtEra"/>
                <m_ArtDefPath text="Eras.artdef"/>
                <m_CollectionIsLocked>true</m_CollectionIsLocked>
                <m_TemplateName text="Eras"/>
                <m_ParamName text="Tag_Era"/>
            </Element>
            <Element class="AssetObjects..ArtDefReferenceValue">
                <m_ElementName text="DEFAULT"/>
                <m_RootCollectionName text="Culture"/>
                <m_ArtDefPath text="Cultures.artdef"/>
                <m_CollectionIsLocked>true</m_CollectionIsLocked>
                <m_TemplateName text=""/>
                <m_ParamName text="Tag_Culture"/>
            </Element>
            <Element class="AssetObjects..BLPEntryValue">
                <m_EntryName text="DIS_CTY_EmptyCity_Base"/>
                <m_XLPClass text="TileBase"/>
                <m_XLPPath text="tilebases.xlp"/>
                <m_BLPPackage text="landmarks/tilebases"/>
                <m_LibraryName text="TileBase"/>
                <m_ParamName text="Asset"/>
            </Element>
            <Element class="AssetObjects..ArtDefReferenceValue">
                <m_ElementName text="ANY"/>
                <m_RootCollectionName text="AppealTags"/>
                <m_ArtDefPath text="Appeal.artdef"/>
                <m_CollectionIsLocked>true</m_CollectionIsLocked>
                <m_TemplateName text=""/>
                <m_ParamName text="Tag_Appeal"/>
            </Element>
            <Element class="AssetObjects..StringValue">
                <m_Value text=""/>
                <m_ParamName text="SelectionRule"/>
            </Element>
            <Element class="AssetObjects..IntValue">
                <m_nValue>0</m_nValue>
                <m_ParamName text="Priority"/>
            </Element>
            <Element class="AssetObjects..StringValue">
                <m_Value text="INHERIT"/>
                <m_ParamName text="Placement"/>
            </Element>
        </m_Values>
    </m_Fields>
    <m_ChildCollections/>
    <m_Name text="BaseVariants$NUM"/>
    <m_AppendMergedParameterCollections>false</m_AppendMergedParameterCollections>
</Element>'''

ExistingVariants = ['BuildingVariants1', 'DIS_CTY_ANC_Monument001', 'BuildingVariants003', 'BuildingVariants3']
''' unsure on this ExistingVaraints list'''

NewVariants = ["MAGEGUILD", "WORKSHOP", "PAGODA", "MEETING_HOUSE", "TAVERN", "GRIGORI_TAVERN", "CONSULATE"
				"CHANCERY", "BIBLIOTHEQUECLS", "BIBLIOTHEQUE", "GOV_FAITH", "MARAE",
               "SHIPYARD", "ARENA", "ORDU", "BUILDING_SYNAGOGUE", "BARRACKS", "STABLE", "AqueductAsBuilding",
               "PalgumAll"]

''' removed'''
'''"KublaiKhan_Vietnam_Landmarks_BuildingVariants"'''

'''meant to make the BuildingSets, and the BuildingVariants'''

newCombinations = []
identifier = 'SLTH'
num = 0
fullVariants = ExistingVariants + NewVariants
combinatorial = result = [', '.join(fullVariants[i:j]) for i, j in combinations(range(len(fullVariants) + 1), 2)]
base_done = ['GRANARY', 'GRANARY, MONUMENT', 'MONUMENT', 'PALACE, MONUMENT, GRANARY', 'PALACE, MONUMENT', 'PALACE, GRANARY', 'PALACE']
for i in combinatorial:
    newElement = BaseVariantsStart
    if i in base_done:
        continue
    SetList = i
    num = num + 1
    if num > 999:
        formal_num = f'{num}'
    elif num > 999:
        formal_num = f'0{num}'
    elif num > 99:
        formal_num = f'00{num}'
    else:
        formal_num =f'000{num}'
    newElement = newElement.replace('$BUILDING_SET_LIST', SetList)
    newElement = newElement.replace('BaseVariants$NUM', f'BaseVariants_{identifier}_{formal_num}')
    newCombinations.append(newElement)

newBuildingSets = []
for i in combinatorial:
    start_element = start_set
    split_set = i.split(',')
    set_list = []
    for idx, j in enumerate(split_set):
        new_element = setElement
        new_element = new_element.replace('$BUILDING', '').replace('Set_$NUM', f'Set_{idx}')
        set_list.append(new_element)
    new_end_set = end_set.replace('$ELEMENT_LIST', i)
    final_result = start_element + '/n' + "/n".join(set_list) + '/n'+ new_end_set
    newBuildingSets.append(final_result)

finalBuildingSetList = "/n".join(newBuildingSets)

final_base_variants = "/n".join(newCombinations)

print('')

