import xmltodict

with open('../data/XML/Text/CIV4GameText_FFH2.xml', 'r', encoding='latin-1') as file:
    loc = xmltodict.parse(file.read())

text_tags = loc['Civ4GameText']['TEXT']

retagged = {i['Tag']: i['English'] for i in text_tags}

filtered = {key.replace('TXT_KEY'): val for key, val in retagged.items() if 'MESSAGE' in key}
print('')