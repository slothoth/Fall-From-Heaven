import xmltodict, copy
from collections import defaultdict
from utils import small_dict, split_dict, make_or_add
import logging

promo_mapper = {'Type': 'UnitPromotionType', 'Description': 'Description', 'UnitCombats': 'PromotionClass'}
promo_mapper_extras = {'PromotionPrereq': 'PromotionPrereq', 'PromotionPrereqOr1': 'PromotionPrereqOr1',
                       'PromotionPrereqOr2': 'PromotionPrereqOr2', 'PromotionPrereqOr3': 'PromotionPrereqOr3',
                       'PromotionPrereqAnd': 'PromotionPrereqAnd', 'Type': 'UnitPromotionType'}

combat_map = {'UNITCOMBAT_NAVAL': 'PROMOTION_CLASS_NAVAL_MELEE', 'UNITCOMBAT_SIEGE': 'PROMOTION_CLASS_SIEGE',
              'UNITCOMBAT_MELEE': 'PROMOTION_CLASS_MELEE', 'UNITCOMBAT_ARCHER': 'PROMOTION_CLASS_RANGED',
              'UNITCOMBAT_MOUNTED': 'PROMOTION_CLASS_LIGHT_CAVALRY', 'UNITCOMBAT_RECON': 'PROMOTION_CLASS_RECON',
              'UNITCOMBAT_ANIMAL': 'PROMOTION_CLASS_ANIMAL', 'UNITCOMBAT_BEAST': 'PROMOTION_CLASS_BEAST',
              'UNITCOMBAT_DISCIPLE': 'PROMOTION_CLASS_DISCIPLE', 'UNITCOMBAT_ADEPT': 'PROMOTION_CLASS_ADEPT',
              'NONE': 'NULL'}

hard_to_filter = ['STIGMATA']


class Promotions:
    def __init__(self):
        self.logger = logging.getLogger(__name__)

    def promotion_miner(self, model_obj):
        with open('data/XML/Units/CIV4PromotionInfos.xml', 'r') as file:
            promo_dict = xmltodict.parse(file.read())['Civ4PromotionInfos']['PromotionInfos']['PromotionInfo']

        promo_dict = {i['Type']:i for i in promo_dict}
        equipments, promo_dict = split_dict(promo_dict, 'bEquipment')
        races, promo_dict = split_dict(promo_dict, 'bRace')
        mana_promotions, promo_dict = split_dict(promo_dict, 'BonusPrereq')
        effects, promo_dict = split_dict(promo_dict, 'bDispellable')
        effects2, promo_dict = split_dict(promo_dict, 'iExpireChance')
        tech_never_promos, promo_dict = split_dict(promo_dict, 'TechPrereq', 'TECH_NEVER')
        no_min_lvl_promos, promo_dict = split_dict(promo_dict, 'iMinLevel', '-1')
        stigmata, sundered = promo_dict.pop('PROMOTION_STIGMATA'), promo_dict.pop('PROMOTION_SUNDERED')
        to_remove = []
        for name, promo in promo_dict.items():
            if promo.get('PromotionPrereq', '') in mana_promotions:
                mana_promotions[name] = promo
                to_remove.append(name)
        for i in to_remove:
            promo_dict.pop(i)

        prereq_names = ['PromotionPrereq', 'PromotionPrereqAnd', 'PromotionPrereqOr1', 'PromotionPrereqOr2',
                        'PromotionPrereqOr3']

        # pre filtering for promotree building
        for i in promo_dict.values():
            if i.get('PromotionPrereqAnd', False):
                buffer = i['PromotionPrereqAnd']
                i['PromotionPrereqAnd'] = i['PromotionPrereq']
                i['PromotionPrereq'] = buffer
            if i.get('PromotionPrereqOr1', 'BAD_ERROR') in [i for i in races] + [i for i in tech_never_promos] + ['PROMOTION_CHANNELING3']:
                i['RacePrereq'] = i.pop('PromotionPrereqOr1')
            if i.get('PromotionPrereqOr2', 'BAD_ERROR') in [i for i in races] + [i for i in tech_never_promos] + ['PROMOTION_CHANNELING3']:
                i['RacePrereq'] = i.pop('PromotionPrereqOr2')
            if i.get('PromotionPrereqOr3', 'BAD_ERROR') in [i for i in races] + [i for i in tech_never_promos] + ['PROMOTION_CHANNELING3']:
                i['RacePrereq'] = i.pop('PromotionPrereqOr3')

        filtered_list_of_dicts = [{k: d[k] for k in d if k in ['Type'] + prereq_names} for d in promo_dict.values()]
        dict_list = [i for i in filtered_list_of_dicts]
        lookup_table = {d['Type']: d for d in dict_list}
        for d in dict_list:
            prereq_names = ['PromotionPrereq', 'PromotionPrereqOr1', 'PromotionPrereqOr2', 'PromotionPrereqOr3']
            for key in prereq_names:
                if key in d:
                    prerequired_dict = lookup_table.get(d[key])
                    if prerequired_dict:
                        if 'children' not in prerequired_dict:     # Add current dictionary as child to prerequired dict
                            prerequired_dict['children'] = {}
                        prerequired_dict['children'][d['Type']] = d
                    else:
                        pass         # If the prerequisite key does not exist, it's a root node

        root_nodes = {d['Type']: d for d in dict_list if not any(key in d for key in prereq_names) or not all(
            d[key] in lookup_table for key in prereq_names if key in d)}

        def dfs(node, depth, depths):
            # Update the depth of the current node
            depths[node['Type']] = depth

            # Recursively visit all children of the current node
            if 'children' in node:
                for child in node['children'].values():
                    dfs(child, depth + 1, depths)

        depths = {}

        # Perform DFS from each root node
        for root in root_nodes.values():
            dfs(root, 1, depths)

        # Rank the nodes based on their depths
        ranked_nodes = sorted(depths.items(), key=lambda x: x[1], reverse=True)

        promo_extras = {key: small_dict(i, promo_mapper_extras) for key, i in promo_dict.items()}
        promo_dict = {key: small_dict(i, promo_mapper) for key, i in promo_dict.items()}

        for i in ranked_nodes:
            promo_dict[i[0]]['Level'] = i[1]

        duplicated_promos, duplicated_promo_extras = [], {}
        for promo in promo_dict.values():
            promo['Name'] = f"LOC_{promo['UnitPromotionType']}_NAME"
            promo['Description'] = f"LOC_{promo['UnitPromotionType']}_DESCRIPTION"
            if promo.get('PromotionClass', False):
                name = promo['UnitPromotionType']
                combat_classes = promo['PromotionClass']['UnitCombat']
                if isinstance(combat_classes, dict):
                    combat_classes = [combat_classes]
                    promo['PromotionClass']['UnitCombat'] = [promo['PromotionClass']['UnitCombat']]
                for idx, combat_type in enumerate(combat_classes):
                    promo_class = combat_map[combat_type['UnitCombatType']]
                    dupe_promo = promo.copy()
                    dupe_promo_extra = promo_extras[name].copy()
                    dupe_promo['oldname'] = dupe_promo['UnitPromotionType']
                    dupe_promo['UnitPromotionType'] += f'_{promo_class[16:]}'
                    dupe_promo['PromotionClass'] = promo_class
                    dupe_promo_extra['UnitPromotionType'] = dupe_promo['UnitPromotionType']
                    duplicated_promos.append(dupe_promo)
                    duplicated_promo_extras[dupe_promo['UnitPromotionType']] = dupe_promo_extra
            else:
                self.logger.info(f'{promo["UnitPromotionType"]} has no combat type classification, setting to melee')
                promo['PromotionClass'] = 'PROMOTION_CLASS_MELEE'
                promo.pop('UnitCombats')

        per_class_promos = defaultdict(list)
        for d in duplicated_promos:
            per_class_promos[d['PromotionClass']].append(d)

        for promo_class_name in per_class_promos:
            per_class_promos[promo_class_name] = {i['oldname']:i for i in per_class_promos[promo_class_name]}

        def filter_tree(node, allowed_names):
            if node['Type'] not in allowed_names:
                return None
            filtered_node = copy.deepcopy(node)         # Copy the node to avoid modifying the original tree
            # Filter children recursively
            if 'children' in filtered_node:
                filtered_node['children'] = [filter_tree(child, allowed_names) for child in filtered_node['children'].values() if
                                             filter_tree(child, allowed_names) is not None]
            return filtered_node

        def filter_root_nodes(root_nodes, allowed_names):
            filtered_root_nodes = [filter_tree(root, allowed_names) for root in root_nodes.values() if
                                   filter_tree(root, allowed_names) is not None]
            return filtered_root_nodes

        per_class_promo_roots = {i: filter_root_nodes(root_nodes, per_class_promos[i]) for i in per_class_promos}
        promo_tree_positions = []

        def collect_leaf_names_and_indexes(node, indexes=[], name=''):
            if 'children' not in node or not node['children']:
                # This is a leaf node, return its name and indexes in a tuple
                idx_adjust = indexes[-1] if len(indexes) > 0 else 0
                promo_tree_positions.append({'PromotionClass': name, 'Type': node['Type'], 'Position': idx_adjust})
                return [(node['Type'], indexes)]
            else:
                # Recursively collect leaf names and indexes from children
                leaf_names_and_indexes = []
                for idx, child in enumerate(node['children']):
                    idx_adjust = indexes[-1] if len(indexes) > 0 else 0
                    promo_tree_positions.append({'PromotionClass': name, 'Type': node['Type'], 'Position': idx_adjust})
                    leaf_names_and_indexes.extend(collect_leaf_names_and_indexes(child, indexes + [idx_adjust+idx], name))
                return leaf_names_and_indexes

        per_class_leaf_names = {}
        for name, class_root_nodes in per_class_promo_roots.items():
            all_leaf_names = []
            for idx, root in enumerate(class_root_nodes):
                all_leaf_names.append(collect_leaf_names_and_indexes(root, [idx], name))
            per_class_leaf_names[name] = all_leaf_names

        tree_position_groupings = {}
        for item in promo_tree_positions:
            value1 = item['PromotionClass']
            value2 = item['Type']
            if value1 not in tree_position_groupings:
                tree_position_groupings[value1] = {}
            if value2 not in tree_position_groupings[value1]:
                tree_position_groupings[value1][value2] = []
            tree_position_groupings[value1][value2].append(item)

        # check no disagreements on positioning
        check_one_position_per_promotion = {len({i['Position'] for i in promo})
                                            for promotion_class, list_of_positions in tree_position_groupings.items()
                                            for promotion_name, promo in list_of_positions.items()}

        if len(check_one_position_per_promotion) > 1:
            plural_promotions = [j for j in {promotion_class: {promotion_name: {i['Position'] for i in promo}
                                              for promotion_name, promo in list_of_positions.items() if len({i['Position'] for i in promo}) > 1}
                                       for promotion_class, list_of_positions in tree_position_groupings.items()}.values() if len(j) > 0]
            raise Exception(f"ERROR: Multiple positions possible for promotions, check unique_positions_structured."
                            f" See\n{plural_promotions}")

        unique_positions_structured = {promotion_class: {promotion_name: {i['Position'] for i in promo}
                                                         for promotion_name, promo in list_of_positions.items()}
                                       for promotion_class, list_of_positions in tree_position_groupings.items()}

        promo_prereqs, p1, p2, p3 = [], [], [], []
        patch_exclude = ['PROMOTION_UNDEAD', 'PROMOTION_DEMON', 'PROMOTION_CHANNELING1', 'PROMOTION_CHANNELING2',
                         'PROMOTION_CHANNELING3', 'PROMOTION_NIGHTMARE', 'PROMOTION_HERO', 'PROMOTION_MEDIC1']
        for name, promo in duplicated_promo_extras.items():
            suffix = name.split('_')
            if suffix[-2] in ['NAVAL', 'LIGHT']:
                suffix = f"{suffix[-2]}_{suffix[-1]}"
            else:
                suffix = suffix[-1]
            if promo.get('PromotionPrereq') != 'PromotionPrereq' and promo['PromotionPrereq'] not in patch_exclude:
                promo_prereqs.append({'UnitPromotion': name, 'PrereqUnitPromotion': f"{promo['PromotionPrereq']}_{suffix}"})
            if promo.get('PromotionPrereqOr1') != 'PromotionPrereqOr1' and promo['PromotionPrereqOr1'] not in patch_exclude:
                promo_prereqs.append({'UnitPromotion': name, 'PrereqUnitPromotion': f"{promo['PromotionPrereqOr1']}_{suffix}"})
            if promo.get('PromotionPrereqOr2') != 'PromotionPrereqOr2' and promo['PromotionPrereqOr2'] not in patch_exclude:
                promo_prereqs.append({'UnitPromotion': name, 'PrereqUnitPromotion': f"{promo['PromotionPrereqOr2']}_{suffix}"})
            if promo.get('PromotionPrereqOr3') != 'PromotionPrereqOr3' and promo['PromotionPrereqOr3'] not in patch_exclude:
                promo_prereqs.append({'UnitPromotion': name, 'PrereqUnitPromotion': f"{promo['PromotionPrereqOr3']}_{suffix}"})


        promotion_classes = [{'PromotionClassType': 'PROMOTION_CLASS_ANIMAL', 'Name': 'LOC_PROMOTION_CLASS_ANIMAL_NAME'},
                             {'PromotionClassType': 'PROMOTION_CLASS_BEAST', 'Name': 'LOC_PROMOTION_CLASS_BEAST_NAME'},
                             {'PromotionClassType': 'PROMOTION_CLASS_ADEPT', 'Name': 'LOC_PROMOTION_CLASS_ADEPT_NAME'},
                             {'PromotionClassType': 'PROMOTION_CLASS_DISCIPLE',
                              'Name': 'LOC_PROMOTION_CLASS_DISCIPLE_NAME'}]

        for promotion in promotion_classes:
            model_obj['kinds'][promotion['PromotionClassType']] = 'KIND_PROMOTION_CLASS'
            model_obj['tags'][promotion['PromotionClassType'][10:]] = 'ABILITY_CLASS'

        for promotion in duplicated_promos:
            model_obj['kinds'][promotion['UnitPromotionType']] = 'KIND_PROMOTION'

        for promo in duplicated_promos:
            promo['Column'] = unique_positions_structured[promo['PromotionClass']][promo['oldname']].pop() + 1
            promo.pop('oldname')

        make_or_add(model_obj['sql_inserts'], duplicated_promos, 'UnitPromotions')
        make_or_add(model_obj['sql_inserts'], promo_prereqs + p1 + p2 + p3, 'UnitPromotionPrereqs')
        make_or_add(model_obj['sql_inserts'], promotion_classes, 'UnitPromotionClasses')
        return model_obj
