import logging
from collections import Counter
import xmltodict
from utils import make_or_add


class Localizer:
    def __init__(self):
        with open('data/XML/Text/CIV4GameText_FFH2.xml', 'r', encoding='ISO-8859-1') as file:
            data = file.read()

        infos = xmltodict.parse(data)['Civ4GameText']['TEXT']
        six_style = [self.civ6_format(i) for i in infos]
        self.text = {i['Tag']: i['English'] for i in six_style}
        self.port_count = 0

    def civ6_format(self, entry):
        tag = entry['Tag']
        if 'TXT_KEY' in tag:
            tag = tag.replace('TXT_KEY', 'LOC')
            if 'STRATEGY' in tag:
                tag = tag.replace('STRATEGY', 'DESCRIPTION')
            else:
                if 'DESCRIPTION' not in tag:
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
                            text = self.text[tag_value.replace('SLTH_', '')].replace('[TAB]', '').replace('[COLOR_BUILDING_TEXT]', '').replace('[COLOR_REVERT]', '').replace('[COLOR_UNIT_TEXT]', '')
                            self.port_count += 1
                        elif len([i for i in self.text if tag_value.split('_')[-2] in i and 'STRATEGY' in i]) > 1:
                            if 'MILITARY_STRATEGY' not in tag_value:
                                text = self.text[[i for i in self.text if tag_value.split('_')[-2] in i and 'STRATEGY' in i][0]]
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
                    loc_entry.append({'Language': 'en_US', 'Tag': tag_value, 'Text': text.strip()})
                if len(loc_entry) > 0:
                    if table_name in model_obj['loc']:
                        model_obj['loc'][table_name].extend(loc_entry)
                    else:
                        model_obj['loc'][table_name] = loc_entry
        logger.info(set(col_types))

        self.city_names(model_obj)
        self.paragraph_pedia(model_obj)
        self.concept_pedia(model_obj)

        logger.info(f'Port count: {self.port_count}')

    def concept_pedia(self, model_obj):
        page_name = self.text.pop('LOC_PEDIA_CATEGORY_CONCEPT_NAME')
        concepts = {i: self.text[i] for i in self.text if 'CONCEPT' in i}

        loc = []

        # CivilopediaPageGroups
        civ_page_groups = [{"SectionId": "CONCEPTS", "PageGroupId": "FALLFROMHEAVEN",
                            "Name": "LOC_PEDIA_CONCEPTS_PAGEGROUP_FALLFROMHEAVEN_NAME"}]
        model_obj['loc']['Pedia'].append({'Tag': 'LOC_PEDIA_CONCEPTS_PAGEGROUP_FALLFROMHEAVEN_NAME', 'Language': 'en_US', 'Text': page_name})
        civ_pages = []
        civ_paragraphs = []
        for tag, text in concepts.items():
            if 'PEDIA' not in tag:
                continue
            page = tag.replace('LOC_CONCEPT_', '').replace('_PEDIA_NAME', '')
            name = f"LOC_PEDIA_CONCEPTS_PAGE_{page}_CHAPTER_CONTENT_TITLE"
            civ_pages.append({"SectionId": "CONCEPTS", "PageId": page, "PageGroupId": "FALLFROMHEAVEN",
                              "PageLayoutId": "Simple", "Name": name})
            model_obj['loc']['Pedia'].append({'Tag': name, 'Language': 'en_US',
                                              'Text': self.text[tag.replace('_PEDIA', '')]})

            para_text = self.text[tag]
            para_text = para_text.replace('[TAB]', '').replace('[tab]', '')
            para_count = 1
            civpedia_tag = tag.replace('PEDIA_NAME', 'CHAPTER_CONTENT_PARA_1').replace(
                'LOC_', f'LOC_PEDIA_CONCEPTS_PAGE_').replace('CONCEPT_', '')
            # LOC_PEDIA_CONCEPTS_PAGE_AIRCOMBAT_1_CHAPTER_CONTENT_PARA_1
            # LOC_PEDIA_CONCEPTS_PAGE_AFFINITY_CHAPTER_HISTORY_PARA_1
            sort_index = 0
            if 'PARA' in para_text:
                para_text = para_text.replace('[PARAGRAPH1:]', '[PARAGRAPH:1]')
                para_split = para_text.split('[PARAGRAPH:1]')
                for p in para_split:
                    if 'PARAGRAPH:2' in p:
                        para_2 = p.split('[PARAGRAPH:2]')
                        for p_two in para_2:
                            civpedia_tag = civpedia_tag.replace(f'PARA_{para_count - 1}', f'PARA_{para_count}')
                            civ_paragraphs.append({"SectionId": "CONCEPTS", "PageId": page, "ChapterId": "UNITS",
                              "Paragraph": civpedia_tag, "SortIndex": sort_index})
                            model_obj['loc']['Pedia'].append({'Language': 'en_US', 'Tag': civpedia_tag, 'Text': p_two})
                            para_count += 1
                            sort_index += 10
                    else:
                        civpedia_tag = civpedia_tag.replace(f'PARA_{para_count - 1}', f'PARA_{para_count}')
                        civ_paragraphs.append({"SectionId": "CONCEPTS", "PageId": page, "ChapterId": "UNITS",
                                               "Paragraph": civpedia_tag, "SortIndex": sort_index})
                        model_obj['loc']['Pedia'].append({'Language': 'en_US', 'Tag': civpedia_tag, 'Text': p})
                        para_count += 1

            else:
                civ_paragraphs.append({"SectionId": "CONCEPTS", "PageId": page, "ChapterId": "UNITS",
                                       "Paragraph": civpedia_tag, "SortIndex": sort_index})
                model_obj['loc']['Pedia'].append({'Language': 'en_US', 'Tag': civpedia_tag, 'Text': para_text})

        make_or_add(model_obj['sql_inserts'], civ_pages, 'CivilopediaPages')
        make_or_add(model_obj['sql_inserts'], civ_page_groups, 'CivilopediaPageGroups')
        make_or_add(model_obj['sql_inserts'], civ_paragraphs, 'CivilopediaPageChapterParagraphs')

    def paragraph_pedia(self, model_obj):
        pedia = [i for i in self.text if 'PEDIA' in i]
        model_obj['loc']['Pedia'] = []
        allowed = ['LOC_PROMOTION', 'PEDIA_CIT', 'LOC_IMPROVEMENT', 'LOC_UNIT', 'LOC_CIV', 'BUILDING', 'LOC_POLICY',
                   'LOC_LEADER', 'LOC_RESOURCE', 'TECHS']
        extra = ['PEDIAS_PAGE', 'LOC_SPELL', 'LOC_RELIGION', 'LOC_PEDIA_CATEGORY']
        for i in pedia:
            if not any([j in i for j in allowed]):
                continue
            para_text = self.text[i]
            para_text = para_text.replace('[TAB]', '').replace('[tab]', '')
            para_count = 1
            civpedia_tag = i.replace('PEDIA_NAME', 'CHAPTER_HISTORY_PARA_1').replace(
                'LOC_', f'LOC_PEDIA_{i.split("_")[1]}S_PAGE_').replace('TECHS', 'TECHNOLOGIES')
            if not any([j in i for j in ['LOC_RESOURCE', 'LOC_IMPROVEMENT', 'LOC_FEATURE']]):
                civpedia_tag = civpedia_tag.replace('PAGE_', 'PAGE_SLTH_')
            if 'PARA' in para_text:
                para_text = para_text.replace('[PARAGRAPH1:]', '[PARAGRAPH:1]')
                para_split = para_text.split('[PARAGRAPH:1]')
                for p in para_split:
                    if 'PARAGRAPH:2' in p:
                        para_2 = p.split('[PARAGRAPH:2]')
                        for p_two in para_2:
                            civpedia_tag = civpedia_tag.replace(f'PARA_{para_count - 1}', f'PARA_{para_count}')
                            model_obj['loc']['Pedia'].append({'Language': 'en_US', 'Tag': civpedia_tag, 'Text': p_two})
                            para_count += 1
                    else:
                        civpedia_tag = civpedia_tag.replace(f'PARA_{para_count - 1}', f'PARA_{para_count}')
                        model_obj['loc']['Pedia'].append({'Language': 'en_US', 'Tag': civpedia_tag, 'Text': p})
                        para_count += 1

            else:
                model_obj['loc']['Pedia'].append({'Language': 'en_US', 'Tag': civpedia_tag, 'Text': para_text})

    def city_names(self, model_obj):
        city_names = {i: j for i, j in self.text.items() if 'LOC_CITY' in i}
        unique_ids = 7000
        model_obj['loc']['CityNames'] = []
        cities = []
        for tag, name in city_names.items():
            civ = tag.split('_')[2]
            if 'BARBARIAN' in civ:
                continue
            elif 'RANDOM' in civ:
                continue
            elif 'BAR' in civ:
                continue
            elif 'CLAN' in civ:
                civ = 'CLAN_OF_EMBERS'
            cities.append({'ID': unique_ids, 'CivilizationType': f'SLTH_CIVILIZATION_{civ}', 'CityName': tag})
            model_obj['loc']['CityNames'].append({'Language': 'en_US', 'Tag': tag, 'Text': name})
            unique_ids += 1
            self.port_count += 1

        make_or_add(model_obj['sql_inserts'], cities, 'CityNames')

