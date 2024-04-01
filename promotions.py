import xmltodict
from utils import build_sql_table, small_dict, split_dict

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
    def promotion_miner(self, kinds):
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
        stigmata = promo_dict.pop('PROMOTION_STIGMATA')
        to_remove = []
        for name, promo in promo_dict.items():
            if promo.get('PromotionPrereq', '') in mana_promotions:
                mana_promotions[name] = promo
                to_remove.append(name)
        for i in to_remove:
            promo_dict.pop(i)

        prereq_names = ['PromotionPrereq', 'PromotionPrereqAnd', 'PromotionPrereqOr1', 'PromotionPrereqOr2',
                        'PromotionPrereqOr3']

        filtered_list_of_dicts = [{k: d[k] for k in d if k in ['Type'] + prereq_names} for d in promo_dict.values()]
        dict_list = [i for i in filtered_list_of_dicts]
        lookup_table = {d['Type']: d for d in dict_list}
        for d in dict_list:
            prereq_names = ['PromotionPrereq', 'PromotionPrereqAnd', 'PromotionPrereqOr1', 'PromotionPrereqOr2',
                                 'PromotionPrereqOr3']
            for key in prereq_names:
                if key in d:
                    prerequired_dict = lookup_table.get(d[key])
                    if prerequired_dict:
                        # Add the current dictionary as a child to the prerequired dictionary
                        if 'children' not in prerequired_dict:
                            prerequired_dict['children'] = []
                        prerequired_dict['children'].append(d)
                    else:
                        # If the prerequisite key does not exist, it's a root node
                        pass

        # Step 3: Find root nodes
        root_nodes = [d for d in dict_list if not any(key in d for key in prereq_names) or not all(
            d[key] in lookup_table for key in prereq_names if key in d)]

        def dfs(node, depth, depths):
            # Update the depth of the current node
            depths[node['Type']] = depth

            # Recursively visit all children of the current node
            if 'children' in node:
                for child in node['children']:
                    dfs(child, depth + 1, depths)

        depths = {}

        # Perform DFS from each root node
        for root in root_nodes:
            dfs(root, 1, depths)

        # Rank the nodes based on their depths
        ranked_nodes = sorted(depths.items(), key=lambda x: x[1], reverse=True)

        promo_extras = {key: small_dict(i, promo_mapper_extras) for key, i in promo_dict.items()}
        promo_dict = {key: small_dict(i, promo_mapper) for key, i in promo_dict.items()}

        for i in ranked_nodes:
            promo_dict[i[0]]['Level'] = i[1]

        duplicated_promos, duplicated_promo_extras = [], {}
        for promo in promo_dict.values():
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
                    dupe_promo['UnitPromotionType'] += f'_{promo_class[16:]}'
                    dupe_promo['PromotionClass'] = promo_class
                    dupe_promo_extra['UnitPromotionType'] = dupe_promo['UnitPromotionType']
                    duplicated_promos.append(dupe_promo)
                    duplicated_promo_extras[dupe_promo['UnitPromotionType']] = dupe_promo_extra
            else:
                print(f'{promo["UnitPromotionType"]} has no combat type classification, setting to melee')
                promo['PromotionClass'] = 'PROMOTION_CLASS_MELEE'
                promo.pop('UnitCombats')

        for i in duplicated_promos:
            i['Name'] = f"LOC_{i['UnitPromotionType']}_NAME"
            i['Description'] = f"LOC_{i['Description'][8:]}_DESCRIPTION"

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
            kinds[promotion['PromotionClassType']] = 'KIND_PROMOTION_CLASS'

        for promotion in duplicated_promos:
            kinds[promotion['UnitPromotionType']] = 'KIND_PROMOTION'

        promo_string = build_sql_table(duplicated_promos, 'UnitPromotions')
        promo_string += build_sql_table(promo_prereqs + p1 + p2 + p3, 'UnitPromotionPrereqs')
        promo_string += build_sql_table(promotion_classes, 'UnitPromotionClasses')

        return promo_string, kinds
