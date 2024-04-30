import pandas as pd
import xmltodict
import re
from utils import small_dict,  make_or_add

techs_4_to_6 = {'Type': 'TechnologyType', 'Name': 'TechnologyType', 'iCost': 'Cost', 'Repeatable': 0,
                'EmbarkUnitType': 'NULL', 'EmbarkAll': 0, 'Description': 'Description', 'EraType': 'ERA_ANCIENT',
                'Critical': 0, 'BarbarianFree': 0, 'UITreeRow': 0, 'AdvisorType': 'ADVISOR_GENERIC'}

era_map = ['ERA_ANCIENT', 'ERA_CLASSICAL', 'ERA_MEDIEVAL', 'ERA_RENAISSANCE', 'ERA_INDUSTRIAL', 'ERA_MODERN',
               'ERA_ATOMIC', 'ERA_INFORMATION']


def techs_sql(model_obj, kept):
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
        tech['Name'] = 'LOC_SLTH_' + tech['TechnologyType'] + '_NAME'
        tech['Description'] = 'LOC_SLTH_' + tech['TechnologyType'] + '_DESCRIPTION'
        tech['Cost'] = int(int(tech['Cost']) / 4)
        tech['UITreeRow'] = ui_tree_map[tech['TechnologyType']][0]
        tech['EraType'] = era_map[int(ui_tree_map[tech['TechnologyType']][1])]

    six_style_civics = [i for i in six_techs if i['TechnologyType'] in civics]
    for civic in six_style_civics:
        civic['CivicType'] = civics[civic['TechnologyType']]
        civic.pop('TechnologyType')
        civic.pop('Critical')
        civic['Description'] = 'LOC_SLTH_' + civic['CivicType'] + '_DESCRIPTION'
        civic['Name'] = 'LOC_SLTH_' + civic['CivicType'] + '_NAME'
        civic['UITreeRow'] = ui_civic_tree[civic['CivicType']][0]
        civic['EraType'] = era_map[int(ui_civic_tree[civic['CivicType']][1])]
        civic['CivicType'] = f"SLTH_{civic['CivicType']}"

    for tech in six_style_techs:
        tech['TechnologyType'] = f"SLTH_{tech['TechnologyType']}"

    [i for i in six_style_techs if i['TechnologyType'] == 'SLTH_TECH_FISHING'][0]['EmbarkUnitType'] = 'UNIT_BUILDER'
    [i for i in six_style_techs if i['TechnologyType'] == 'SLTH_TECH_SAILING'][0]['EmbarkAll'] = 1
    [i for i in six_style_techs if i['TechnologyType'] == 'SLTH_TECH_SAILING'][0]['EmbarkUnitType'] = 'SLTH_UNIT_MUD_GOLEM'

    six_style_techs.append(elf_patch(six_style_techs, model_obj))

    'UNIT_BUILDER'
    'EmbarkAll : 1'

    make_or_add(model_obj['sql_inserts'], six_style_techs, 'Technologies')
    make_or_add(model_obj['sql_inserts'], six_style_civics, 'Civics')

    for tech_type_to_add in techsql[2:]:
        tech_split = tech_type_to_add.split("'")
        model_obj['kinds'][f"SLTH_{tech_split[1]}"] = tech_split[3]

    model_obj['civics'] = civics
    model_obj['modifiers'].civic_map = civics
    return model_obj


def prereq_techs(model_obj):
    with open('data/prereqstechs.sql', 'r') as file:
        prereqs_tech_str = file.readlines()
        prereq_techs, prereqs_civics = [], []
        for i in prereqs_tech_str[2:]:
            formatted = [re.sub(r"[^a-zA-Z_]+", "", j) for j in i.split("',")]
            prereq_techs.append({'Technology': f'SLTH_{formatted[0]}', 'PrereqTech': f'SLTH_{formatted[1]}'})

    with open('data/prereqscivics.sql', 'r') as file:
        prereqs_civic_str = file.readlines()

    for i in prereqs_civic_str[2:]:
        formatted = [re.sub(r"[^a-zA-Z_]+", "", j) for j in i.split("',")]
        prereqs_civics.append({'Civic': f'SLTH_{formatted[0]}', 'PrereqCivic': f'SLTH_{formatted[1]}'})

    make_or_add(model_obj['sql_inserts'], prereq_techs, 'TechnologyPrereqs')
    make_or_add(model_obj['sql_inserts'], prereqs_civics, 'CivicPrereqs')


def elf_patch(six_style_techs, model_obj):
    elf_patch_tech = [i for i in six_style_techs if i['TechnologyType'] =='SLTH_TECH_FUTURE_TECH'][0].copy()
    era = 'ERA_DUMMY'
    elf_patch_tech['TechnologyType'] = 'SLTH_TECH_FOREST_SECRETS'
    elf_patch_tech['Name'] = 'LOC_SLTH_TECH_FOREST_SECRETS_NAME'
    elf_patch_tech['Description'] = 'LOC_SLTH_TECH_FOREST_SECRETS_DESCRIPTION'
    elf_patch_tech['Cost'] = 9000
    elf_patch_tech['EraType'] = era
    era_type = {'EraType': era, 'Name': 'LOC_ERA_DUMMY_NAME', 'ChronologyIndex': -1, 'EmbarkedUnitStrength': 10,
                'GreatPersonBaseCost': 30}
    model_obj['kinds'][era] = 'KIND_ERA'
    model_obj['kinds']['SLTH_TECH_FOREST_SECRETS'] = 'KIND_TECH'
    make_or_add(model_obj['sql_inserts'], [era_type], 'Eras')
    return elf_patch_tech

