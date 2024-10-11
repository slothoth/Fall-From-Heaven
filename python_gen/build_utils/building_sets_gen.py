from itertools import combinations


base_game = ['BUILDING_GRANARY', 'BUILDING_PALACE', 'BUILDING_MONUMENT']

extras = ['BUILDING_PAGODA',  'BUILDING_MADRASA', 'BUILDING_MEETING_HOUSE',
          'BUILDING_TAVERN', 'SLTH_BUILDING_INN', 'SLTH_BUILDING_INFIRMARY', 'BUILDING_QUEENS_BIBLIOTHEQUE',
          'SLTH_BUILDING_CHANCEL', 'SLTH_BUILDING_HUNTING_LODGE',  'BUILDING_SHIPYARD',
          'BUILDING_GROVE',
           'BUILDING_KOTOKU-IN']
grigori = ['BUILDING_GRIGORI_TAVERN', 'BUILDING_GUILDHALL', ]
calabim = ['BUILDING_ORDU']
balserah = ['BUILDING_ARENA']
template = r'''
<Element class="AssetObjects..ArtDefReferenceValue">
    <m_ElementName text="RENAME$HERE"/>
    <m_RootCollectionName text="Building"/>
    <m_ArtDefPath text="Buildings.artdef"/>
    <m_CollectionIsLocked>true</m_CollectionIsLocked>
    <m_TemplateName text="Buildings"/>
    <m_ParamName text="Set$APPEND"/>
</Element>'''
r'''
<Element>
    <m_Fields>
        <m_Values>
            <Element class="AssetObjects..CollectionValue">
                <m_eObjectType>INVALID</m_eObjectType>
                <m_eValueType>ARTDEF_REF</m_eValueType>
                <m_Values>
                    REDO$HERE
                </m_Values>
                <m_ParamName text="Set"/>
            </Element>
        </m_Values>
    </m_Fields>
    <m_ChildCollections/>
    <m_Name text="MAGEGUILD, PALACE"/>
    <m_AppendMergedParameterCollections>false</m_AppendMergedParameterCollections>
</Element>'''
full = base_game + extras
variants = []
for r in range(len(full) + 1):
    variants.extend(combinations(full, r))
possible_combos = [list(variant) for variant in variants]
print('')

# NATIONAL_EPIC, HEROIC_EPIC, BREWERY, GAMBLING_HOUSE, DUNGEON,

# SYNAGOGUE, STABLE, TRAINING_YARD
# AKHARIEN, GRIMOIRE, LYRE,