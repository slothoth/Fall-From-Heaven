import logging
from collections import Counter
import xmltodict


class Localizer:
    def __init__(self):
        with open('data/XML/Text/CIV4GameText_FFH2.xml', 'r', encoding='ISO-8859-1') as file:
            data = file.read()

        infos = xmltodict.parse(data)['Civ4GameText']['TEXT']
        six_style = [self.civ6_format(i) for i in infos]
        self.text = {i['Tag']: i['English'] for i in six_style}

    def civ6_format(self, entry):
        tag = entry['Tag']
        if 'TXT_KEY' in tag:
            tag = tag.replace('TXT_KEY', 'LOC')
            if 'PEDIA' in tag:
                tag = tag.replace('PEDIA', 'DESCRIPTION')
            else:
                tag += '_NAME'
        if 'CIVIC_' in tag:
            tag = tag.replace('CIVIC_', 'POLICY_')
        if 'BONUS_' in tag and 'FORTIFY' not in tag:
            tag = tag.replace('BONUS_', 'RESOURCE_')
        entry['Tag'] = tag
        if entry['English'] is not None and "'" in entry['English']:
            entry['English'] = entry['English'].replace("'", "''")      # deals with sql apostrophe issues
        return entry


    def localize(self, model_obj):
        logger = logging.getLogger(__name__)
        tables_to_translate = ['Buildings', 'Districts', 'Improvements', 'Projects', 'Civics', 'Policies', 'Civilizations',
                               'Leaders', 'Traits', 'Resources', 'Terrains', 'Features', 'UnitPromotions', 'UnitPromotionClasses',
                               'Units', 'Abilities', 'Technologies', ]
        weird_tables = ['CityNames', 'CivilopediaConcepts', 'CivilizationFrontEnd']
        port_count = 0
        col_types = []
        for table_name, table in model_obj['sql_inserts'].items():
            if table_name not in tables_to_translate:
                continue
            if isinstance(table, list):
                table = {idx: i for idx, i in enumerate(table)}
            loc_cols = [i for i, j in list(table.values())[0].items() if isinstance(j, str) and 'LOC' in j]
            common_strings = []
            for loc_col in loc_cols:
                result = []
                [result.extend(i[loc_col].split('_')) for i in table.values()]
                common_strings.extend([name for name, count in Counter(result).items() if count > len(table) * 0.8])
            common_strings = set(common_strings)
            for key, row in table.items():
                loc_entry = []
                for col in loc_cols:
                    tag_value = row[col]
                    text = tag_value
                    for remove_str in common_strings:
                        text = text.replace(remove_str, '')
                    text = ' '.join([i.capitalize() for i in text.replace('_', ' ').strip().split()])
                    if col == 'Name':
                        col_types.append(col)
                    elif col == 'Adjective':
                        col_types.append(col)
                        if text[-1] == 's':
                            text = text[:-1]
                        else:
                            text += 'ian'
                    elif col == 'Description':
                        if isinstance(key, str) and key in model_obj['modifiers'].loc:
                            modifier_description = ''
                            for i in model_obj['modifiers'].loc[key]:
                                if 'SLTH' in i:
                                    string_replace = i.split('###')
                                    string_replace[1] = string_replace[1].replace('SLTH', '')
                                    string_replace[1] = "".join([j.capitalize() for j in string_replace[1].split('_')])
                                    i = " ".join([i.strip() for i in string_replace])
                                modifier_description += i + ' '
                            text = modifier_description.strip()
                        elif isinstance(key, str) and 'COOL' in key:
                            modifier_description = ''
                            if 'EMBERS' in key:
                                civ = "_".join(key.split('_')[-4:-1])
                            else:
                                civ = key.split('_')[-2]
                            for i in model_obj['modifiers'].loc[f"SLTH_BUILDING_PALACE_{civ}"]:
                                modifier_description += i + ' '
                            text = modifier_description.strip()

                        elif tag_value.replace('SLTH_', '') in self.text:
                            text = self.text[tag_value.replace('SLTH_', '')]
                            port_count += 1
                        else:
                            text = text + ' Description'
                    else:
                        logger.error(f'unrecognized loc_tag {col}')
                    if 'Mana ' in text and table_name == 'Resources':
                        text = ' '.join(text.split(' ')[::-1])
                    if 'Null' in text and 'Nullstone' not in text:
                        text = 'ZZ_Banned for Civ'
                    if table_name == 'Units':
                        text = text.replace('Equipment', '').replace('Unit', '')
                    if table_name == 'UnitPromotions':
                        text = text.replace('1', ' I').replace('2', ' II').replace('3', ' III')
                        text = text.replace('4', ' IV').replace('5', ' V')
                    text = text.replace('+-', '-')
                    loc_entry.append({'Language': 'en_us', 'Tag': tag_value, 'Text': text.strip()})
                if len(loc_entry) > 0:
                    if table_name in model_obj['loc']:
                        model_obj['loc'][table_name].extend(loc_entry)
                    else:
                        model_obj['loc'][table_name] = loc_entry
        logger.info(set(col_types))
        logger.info(f'Port count: {port_count}')
