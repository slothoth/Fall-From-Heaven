import xmltodict

with open('../data/XML/Technologies/CIV4TechInfos.xml', 'r', encoding='latin-1') as file:
    tech = xmltodict.parse(file.read())

techs = tech['Civ4TechInfos']['TechInfos']['TechInfo']

ORs = [i for i in techs if i['OrPreReqs'] is not None and isinstance(i['OrPreReqs']['PrereqTech'], list)]



tech_script = "('TECH_SKIP_', 'LOC_TECH_SKIP_NAME', '9000', 'LOC_TECH_SKIP_DESCRIPTION', 'ERA_ANCIENT', 'ADVISOR_GENERIC'),"

prereq_script = "('TECH_SKIP_', 'TECH_FUTURE_TECH'),"

mod_script = "('MODIFIER_GRANT_TECH_SKIP_', 'MODIFIER_PLAYER_GRANT_SPECIFIC_TECHNOLOGY', '1', '1'),"

mod_arg_script = "('MODIFIER_GRANT_TECH_SKIP_', 'TechType', 'TECH_SKIP_'),"

type_script = "('TECH_SKIP_', 'KIND_TECH'),"

grant_script = "('TECH_$1', 'MODIFIER_GRANT_TECH_SKIP_'),"


sql_form = [{'tech': tech_script.replace('TECH_SKIP_', i['Type']+'_SKIP'),
             'prereq': prereq_script.replace('TECH_SKIP_', i['Type']+'_SKIP'),
             'mod': mod_script.replace('TECH_SKIP_', i['Type']+'_SKIP'),
             'mod_arg': mod_arg_script.replace('TECH_SKIP_', i['Type']+'_SKIP'),
             'type': type_script.replace('TECH_SKIP_', i['Type']+'_SKIP'),
             'grant': [grant_script.replace('TECH_$1', j).replace('TECH_SKIP_', i['Type']+'_SKIP') for j in i['OrPreReqs']['PrereqTech']]}
                for i in ORs]

tech_sql = 'INSERT INTO Technologies(TechnologyType, Name, Cost, Description, EraType, AdvisorType) VALUES'
tech_prereq = 'INSERT INTO TechnologyPrereqs(Technology, PrereqTech) VALUES'
tech_mod = 'INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent) VALUES'
tech_mod_arg = 'INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES'
tech_type = 'INSERT INTO Types(Type, Kind) VALUES'

tech_granter = 'INSERT INTO TechnologyModifiers(TechnologyType, ModifierId) VALUES'

for i in sql_form:
    tech_sql += f'\n{i["tech"]}'
    tech_prereq += f'\n{i["prereq"]}'
    tech_mod += f'\n{i["mod"]}'
    tech_mod_arg += f'\n{i["mod_arg"]}'
    tech_type += f'\n{i["type"]}'
    for j in i["grant"]:
        tech_granter += f'\n{j}'


tech_sql = tech_sql[:-1] + f';'
tech_prereq = tech_prereq[:-1] + f';'
tech_mod = tech_mod[:-1] + f';'
tech_mod_arg = tech_mod_arg[:-1] + f';'
tech_type = tech_type[:-1] + f';'
tech_granter = tech_granter[:-1] + f';'
tech_sql = tech_sql + '\n\n' + tech_prereq + '\n\n' + tech_mod + '\n\n' + tech_mod_arg + '\n\n' + tech_type + '\n\n' + tech_granter + '\n\n'
print('')
