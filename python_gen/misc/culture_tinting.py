from artdef_wrangler import Artdef
import xmltodict
from copy import deepcopy
# need a specified cultures.artdef entry
# need a tint specified in Units.artdef under UnitTintTypes

job = {'Orcish': 'SlthBaseMale_SkinColor_Orc',
       'Demonic': 'SlthBaseMale_SkinColor_Demon',
       'Dwarven': 'SCALE_$_0.800000'}

hairjob = {'Orcish': 'NO_HAIR',
           'Demonic': 'NO_HAIR',
           'Dwarven': 'ALL_BEARDS',
           }
artdef_object = Artdef()
artdef_to_add = artdef_object.unit_culture_artdef(artdef_object.folder, job, 'skin')
artdef_two = artdef_object.unit_culture_artdef(artdef_object.folder, hairjob, 'hairs')

full_artdef = deepcopy(artdef_to_add)
idx = 0
for first, second in zip(artdef_to_add['AssetObjects..ArtDefSet']['m_RootCollections']['Element'], artdef_two['AssetObjects..ArtDefSet']['m_RootCollections']['Element']):
    if first == second:
        continue
    else:
        first_list = first['Element'][idx]
        second_list = second['Element'][idx]
        if isinstance(first_list, dict):
            first_list = [first_list]
        if isinstance(second_list, dict):
            second_list = [second_list]
        full_artdef['AssetObjects..ArtDefSet']['m_RootCollections']['Element'][idx] = first_list + second_list
    idx += 1
with open('../Artdefs/Unit_Bins_alt.artdef', 'w') as file:
    xmltodict.unparse(artdef_to_add, output=file, pretty=True)


