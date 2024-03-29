import pandas as pd
import xmltodict
from utils import small_dict, build_sql_table, localization

techs_4_to_6 = {'Type': 'TechnologyType', 'Name': 'TechnologyType', 'iCost': 'Cost', 'Repeatable': 0,
                'EmbarkUnitType': 'NULL', 'EmbarkAll': 0, 'Description': 'Description', 'EraType': 'ERA_ANCIENT',
                'Critical': 0, 'BarbarianFree': 0, 'UITreeRow': 0, 'AdvisorType': 'ADVISOR_GENERIC'}

era_map = ['ERA_ANCIENT', 'ERA_CLASSICAL', 'ERA_MEDIEVAL', 'ERA_RENAISSANCE', 'ERA_INDUSTRIAL', 'ERA_MODERN',
               'ERA_ATOMIC', 'ERA_INFORMATION']


def techs_sql(kind_string, kept):
    ui_tree_map = pd.read_csv('data/ui_tree.csv')
    ui_tree_map = ui_tree_map.set_index('tech').apply(lambda x: x.tolist(), axis=1).to_dict()
    ui_civic_tree = pd.read_csv('data/civic_ui_tree.csv')
    ui_civic_tree = ui_civic_tree.set_index('civic').apply(lambda x: x.tolist(), axis=1).to_dict()

    with open('data/XML/Technologies/CIV4TechInfos.xml', 'r') as file:
        tech_infos = xmltodict.parse(file.read())['Civ4TechInfos']['TechInfos']['TechInfo']
    with open('data/techs.sql', 'r') as file:
        techsql = file.read()
    techsql = techsql.splitlines()
    defined_civic_and_traits = techsql[2:]

    kept_civics, kept_techs, kept_prereqs = kept['civics'], kept['techs'], kept['kept_tech_prerequisites']

    civics = {}
    techs = []
    for line in defined_civic_and_traits:
        formatted = line[2:-3].split("', '")
        if 'TECH' in formatted[1]:
            techs.append(formatted[0])
        elif 'CIVIC' in formatted[1]:
            civics['TECH' + formatted[0][5:]] = formatted[0]

    six_techs = [small_dict(i, techs_4_to_6) for i in tech_infos]
    six_style_techs = [i for i in six_techs if i['TechnologyType'] in techs]
    for tech in six_style_techs:
        tech['Name'] = 'LOC_' + tech['TechnologyType'] + '_NAME'
        tech['Description'] = 'LOC_' + tech['TechnologyType'] + '_DESCRIPTION'
        tech['Cost'] = int(int(tech['Cost']) / 4)
        tech['UITreeRow'] = ui_tree_map[tech['TechnologyType']][0]
        tech['EraType'] = era_map[int(ui_tree_map[tech['TechnologyType']][1])]

    six_style_civics = [i for i in six_techs if i['TechnologyType'] in civics]
    for civic in six_style_civics:
        civic['CivicType'] = civics[civic['TechnologyType']]
        civic.pop('TechnologyType')
        civic.pop('Critical')
        civic['Description'] = 'LOC_' + civic['CivicType'] + '_DESCRIPTION'
        civic['Name'] = 'LOC_' + civic['CivicType'] + '_NAME'
        civic['UITreeRow'] = ui_civic_tree[civic['CivicType']][0]
        civic['EraType'] = era_map[int(ui_civic_tree[civic['CivicType']][1])]

    tech_table_string = build_sql_table(six_style_techs, 'Technologies')
    civic_table_string = build_sql_table(six_style_civics, 'Civics')

    for tech_type_to_add in techsql:
        first_val = tech_type_to_add[2:].split("',")[0]
        if not ('TECH' in first_val or 'CIVIC' in first_val):
            kind_string += tech_type_to_add + '\n'
        elif not (first_val in kept_techs or first_val in kept_civics):
            kind_string += tech_type_to_add + '\n'
    kind_string = kind_string[:-2] + ','

    localization(six_style_techs)
    localization(six_style_civics)

    return tech_table_string, civic_table_string, civics, kind_string

def prereq_techs():
    with open('data/prereqstechs.sql', 'r') as file:
        prereqs_tech = file.readlines()
        prereqs_string = "".join(prereqs_tech[:2])
        prereqs_string += "".join([i for i in prereqs_tech[2:]])

    prereqs_string = prereqs_string[:-1] + ";\n"
    with open('data/prereqscivics.sql', 'r') as file:
        prereqs_string += file.read() + "\n"

    return prereqs_string
