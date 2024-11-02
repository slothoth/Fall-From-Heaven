from artdef_wrangler import Artdef

# need a specified cultures.artdef entry
# need a tint specified in Units.artdef under UnitTintTypes

job = {'Orcish': 'SlthBaseMale_SkinColor_Orc',
       'Demonic': 'SlthBaseMale_SkinColor_Demon'}

hairjob = {'Orcish': 'NO_HAIR',
       'Demonic': 'NO_HAIR'}
artdef_object = Artdef()
# artdef_object.unit_culture_artdef(artdef_object.folder, job, 'skin')
artdef_object.unit_culture_artdef(artdef_object.folder, hairjob, 'hairs')


