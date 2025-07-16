import xmltodict

with open('../../data/XML/Text/CIV4GameText_FFH2.xml', 'r', encoding='latin-1') as file:
    loc = xmltodict.parse(file.read())

text_tags = loc['Civ4GameText']['TEXT']

retagged = {i['Tag']: i['English'] for i in text_tags}

# filtered = {key.replace('TXT_KEY_MESSAGE', 'LOC_NOTIFICATION'): val for key, val in retagged.items() if 'MESSAGE' in key}
filtered = {key: val for key, val in retagged.items() if 'AI_DIPLO' in key}
by_response_type = {}
for key, value in filtered.items():
    new_key = key.replace('AI_DIPLO_', '')
    if 'LEADER' in new_key:
        new_key, leader = new_key.split('_LEADER_')
        if new_key not in by_response_type:
            by_response_type[new_key] = {}
        by_response_type[new_key][leader] = value
    elif 'DEMAND' in new_key:
        split = new_key.split('_')
        if 'CLAN_OF_EMBER' in new_key:
            new_key, leader = "_".join(split[:-3]), "_".join(split[-3:-1])
        else:
            new_key, leader = "_".join(split[:-1]), split[-1]
        if new_key not in by_response_type:
            by_response_type[new_key] = {}
        by_response_type[new_key][leader] = value

dawn = {key: val for key, val in retagged.items() if 'DAWN_OF_MAN' in key}
defeated = {key: val for key, val in retagged.items() if 'POPUP_DEFEATED' in key}
by_response_type['DEFEATED'] = {}
for key, value in defeated.items():
    leader = key.replace('TXT_KEY_POPUP_DEFEATED_', '')
    by_response_type['DEFEATED'][leader] = value

dawn_filtered = {}
for key, value in dawn.items():
    if 'TEXT' not in key:
        leader = key.replace('TXT_KEY_DAWN_OF_MAN_', '')
        dawn_filtered[leader] = value
print('')

leader_map = {'AMURITES': 'LEADER_DAIN', 'BALSERAPHS': 'LEADER_KEELYN', 'BANNOR': 'LEADER_DECIUS_BANNOR',
              'CLAN_OF_EMBERS': 'LEADER_SHEELBA', 'CALABIM': 'LEADER_DECIUS_CALABIM', 'KHAZAD': 'LEADER_KANDROS',
              'LUCHUIRP': 'LEADER_BEERI', 'ELOHIM': 'LEADER_EINION', 'LJOSALFAR': 'LEADER_THESSA',
              'SVARTALFAR': 'LEADER_FAERYL', 'GRIGORI': 'LEADER_CASSIEL', 'HIPPUS': 'LEADER_RHOANNA',
              'INFERNAL': 'LEADER_HYBOREM', 'KURIOTATES': 'LEADER_CARDITH', 'LANUN': 'LEADER_HANNAH',
              'MALAKIM': 'LEADER_DECIUS_MALAKIM', 'MERCURIANS': 'LEADER_BASIUM', 'SHEAIM': 'LEADER_OSGABELLA',
              'SIDAR': 'LEADER_SANDALPHON', 'DOVIELLO': 'LEADER_MAHALA', 'ILLIANS': 'LEADER_AURIC'}

dawn_locs = ''
for key, value in dawn_filtered.items():
    leader = leader_map[key]
    new_loc_tag = 'LOC_LOADING_INFO_' + leader
    new_loc_value = value.replace('[NEWLINE]', '').replace('Strategy: ','').replace("'", "''")
    line = f"('{new_loc_tag}', '{new_loc_value}', 'en_US'),\n"
    dawn_locs += line
print(dawn_locs)
print(['DEMAND_TRIBUTE_POWER_EQUAL', 'DEMAND_TRIBUTE_POWER_STRONGER','DEMAND_TRIBUTE_POWER_WEAKER'])

old_new_diplo_map = {'FIRST_CONTACT': 'LOC_DIPLO_FIRST_MEET_*_ANY', 'GREETINGS_ATT_FR': 'LOC_DIPLO_DEAL_INTRO_*_HAPPY',
                     'GREETINGS_ATT_FUR': 'LOC_DIPLO_DEAL_INTRO_*_UNHAPPY', 'DECLARE_WAR': 'LOC_DIPLO_DECLARE_WAR_FROM_AI_*_ANY',
                     'REFUSE_TO_TALK': 'LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_*_ANY',
                     'NO_PEACE': 'LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_*_ANY',
                     'PEACE': 'LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_*_ANY',
                     'OFFER_PEACE': 'OC_DIPLO_MAKE_PEACE_FROM_AI_*_ANY',
                     'DEFEATED': 'LOC_DIPLO_DEFEAT_FROM_AI_*_ANY', 'REJECT': 'LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_*_ANY',
                     'ACCEPT': 'LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_*_ANY',
                     'THANKS': 'LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_*_ANY',
                     'FR_NO_DEAL': 'LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_*_HAPPY',
                     'FUR_NO_DEAL': 'LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_*_UNHAPPY',
                     'DEMAND_REJECTED': 'LOC_DIPLO_AI_REFUSE_DEMAND_*_ANY',
                     }
extras = {'GREETINGS_ATT_FR': 'LOC_DIPLO_GREETING_*_HAPPY', 'GREETINGS_ATT_FUR': 'LOC_DIPLO_GREETING_*_UNHAPPY'}



diplos = ''
for key, value in by_response_type.items():
    for leader_, text in value.items():
        leader = leader_map.get(leader_, f'LEADER_{leader_}')
        new_loc_tag_start = old_new_diplo_map.get(key, None)
        new_loc_value = text.replace('[NEWLINE]', '').replace('Strategy: ', '').replace("'", "''")
        if new_loc_tag_start is not None:
            new_loc_tag_start = new_loc_tag_start.replace('*', leader)
            line = f"('{new_loc_tag_start}', '{new_loc_value}', 'en_US'),\n"
            diplos += line

        new_loc_extra = extras.get(key, None)
        if new_loc_extra is not None:
            new_loc_extra = new_loc_extra.replace('*', leader)
            line = f"('{new_loc_extra}', '{new_loc_value}', 'en_US'),\n"
            diplos += line

print('')
