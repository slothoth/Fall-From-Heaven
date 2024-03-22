# in this script, we query the existing tech_prereqs, and the defined techs.
# we then get the techs without prerequisites, to start with.

# we then build a graph of all the techs reachable from that one tech
# we do that for all techs
def parse(tech):
    tree = {}
    for tech_with_req, tech_requirement in prereqs.items():
        if tech in tech_requirement:
            tree[tech + "-" + tech_with_req] = parse(tech_with_req)
    if len(tree) == 0:
        return None
    return tree

with open('prereqstechs.sql', 'r') as file:
    prereqs = file.readlines()

with open('techs.sql', 'r') as file:
    techs = file.readlines()

graphviz_string = "digraph G {\n"

techs = [i.split("'")[1] for i in techs if 'TECH' in i]
leads_to = {i.split("'")[3]: i.split("'")[1] for i in prereqs if 'TECH' in i}
prereqs_ = {}
for i in prereqs:
    if 'TECH' in i:
        split = i.split("'")
        tech, prereq_tech = split[1], split[3]
        graphviz_string += f"{prereq_tech[5:]} -> {tech[5:]};\n"
        if tech in prereqs_:            # if not in dict yet, make entry
            prereqs_[tech] = [prereqs_[tech], prereq_tech]
        else:                                   # if in dict, add
            prereqs_[tech] = prereq_tech

prereqs = prereqs_
no_pre_reqs = [i for i in techs if i not in prereqs]


for i in no_pre_reqs:
    graphviz_string += f"start -> {i[5:]};\n"

graphviz_string += "}"

with open('graphviz.dot', 'w') as file:
    file.write(graphviz_string)

big_tree = {}

for i in no_pre_reqs:
    big_tree[i] = parse(i)


print(big_tree)
