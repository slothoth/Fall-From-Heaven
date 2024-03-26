from utils import small_dict, build_sql_table
import xmltodict
import json

extras_building_map = {'Type': 'BuildingType', 'GreatPeopleUnitClass': 'GreatPersonClassType',
                       'iGreatPeopleRateChange': 'PointsPerTurn', 'CommerceChanges': 'YieldType',
                       'YieldModifiers': 'YieldModifiers', 'CommerceModifiers': 'CommerceModifiers',
                       'FreeBonus': 'FreeBonus', 'FreeBonus2': 'FreeBonus2', 'FreeBonus3': 'FreeBonus3',
                       'iNumFreeBonuses': 'iNumFreeBonuses', 'Bonus': 'Bonus',
                       'BonusYieldModifiers': 'BonusYieldModifiers',
                       'DomainProductionModifiers': 'DomainProductionModifiers',
                       'iGlobalSpaceProductionModifier': 'iGlobalSpaceProductionModifier',
                       'iTradeRouteModifier': 'iTradeRouteModifier', 'iFreePromotionPick': 'iFreePromotionPick',
                       }

buildings_4_to_6 = {'Type': 'BuildingType', 'PrereqTech': 'PrereqTech', 'iCost': 'Cost',
                        'MaxWorldInstances': -1, 'bCapital': 'MaxPlayerInstances',
                        'PrereqDistrict': 'DISTRICT_CITY_CENTER',
                        'iHealth': 'Housing', 'iHappiness': 'Entertainment', 'SpecialistCounts': 'CitizenSlots',
                        'Advisor': 'AdvisorType'}

map_specialists = {'SPECIALIST_SCIENTIST': 'DISTRICT_CAMPUS', 'SPECIALIST_ENGINEER': 'DISTRICT_INDUSTRIAL_ZONE',
                       'SPECIALIST_PRIEST': 'DISTRICT_HOLY_SITE', 'SPECIALIST_ARTIST': 'DISTRICT_THEATER',
                       'SPECIALIST_MERCHANT': 'DISTRICT_COMMERCIAL_HUB'}

commerce_map = ['YIELD_GOLD', 'YIELD_SCIENCE', 'YIELD_CULTURE']
yield_map = ['SDM_UNKNOWN', 'YIELD_PRODUCTION', 'YIELD_GOLD']
gpp_map = {'UNITCLASS_PROPHET': 'GREAT_PERSON_CLASS_PROPHET', 'UNITCLASS_COMMANDER': 'GREAT_PERSON_CLASS_GENERAL',
           'UNITCLASS_MERCHANT': 'GREAT_PERSON_CLASS_MERCHANT', 'UNITCLASS_ENGINEER': 'GREAT_PERSON_CLASS_ENGINEER',
           'UNITCLASS_SCIENTIST': 'GREAT_PERSON_CLASS_SCIENTIST', 'UNITCLASS_ARTIST': 'GREAT_PERSON_CLASS_ARTIST',
           'UNITCLASS_ADVENTURER': 'GREAT_PERSON_CLASS_WRITER'}

advisor_mapping = {'ADVISOR_MILITARY': 'ADVISOR_CONQUEST', 'ADVISOR_RELIGION': 'ADVISOR_RELIGIOUS',
                   'ADVISOR_ECONOMY': 'ADVISOR_GENERIC', 'ADVISOR_GROWTH': 'ADVISOR_GENERIC',
                   'ADVISOR_SCIENCE': 'ADVISOR_TECHNOLOGY', 'ADVISOR_CULTURE': 'ADVISOR_CULTURE'}

def buildings_sql(civics, kind_string):
    debug_string = ''
    with open('data/CIV4BuildingInfos.xml', 'r') as file:
        building_infos = xmltodict.parse(file.read())['Civ4BuildingInfos']['BuildingInfos']['BuildingInfo']

    with open("data/existing_buildings.json", 'r') as json_file:
        exist_dict = json.load(json_file)

    only_useful_build_infos = [
        {key: value for key, value in i.items() if value != 'NONE' and value != None and value != '0'} for i in
        building_infos]

    six_style_build_dict = [small_dict(i, buildings_4_to_6) for i in building_infos]
    six_style_build_extras = [small_dict(i, extras_building_map) for i in building_infos]

    existing_buildings = exist_dict['existing_buildings']
    existing_buildings_gpp = exist_dict['existing_buildings_gpp']
    existing_buildings_yields = exist_dict['existing_buildings_yields']

    for building in six_style_build_dict:
        building['AdvisorType'] = advisor_mapping[building['AdvisorType']]
        building['Name'] = 'LOC_' + building['BuildingType'] + '_NAME'
        building['Description'] = 'LOC_' + building['BuildingType'] + '_DESCRIPTION'
        if building['PrereqTech'] in civics:
            building['PrereqCivic'] = civics[building['PrereqTech']]
            building['PrereqTech'] = 'NULL'
        else:
            building['PrereqCivic'] = 'NULL'
        if building['PrereqTech'] == 'NONE':
            building['PrereqTech'] = 'NULL'
        if building['MaxPlayerInstances'] == '0':
            building['MaxPlayerInstances'] = -1
        if building.get('CitizenSlots', False):
            specialists = building['CitizenSlots']['SpecialistCount']
            if isinstance(specialists, dict):
                building['PrereqDistrict'] = map_specialists[specialists['SpecialistType']]
                building['CitizenSlots'] = specialists['iSpecialistCount']
            else:
                if "TEMPLE" in building['BuildingType']:
                    building['PrereqDistrict'] = "DISTRICT_HOLY_SITE"
                    building['CitizenSlots'] = 1
                else:
                    debug_string += f"{building['BuildingType']} has multiple specialists, hard to assign\n"
                    building['CitizenSlots'] = 0
        else:
            building['CitizenSlots'] = 'NULL'

        if int(building['Cost']) < 1:
            building['Cost'] = -1

    unbuildable_buildings = [i for i in six_style_build_dict if int(i['Cost']) < 1]
    buildable_buildings = [i for i in six_style_build_dict if int(i['Cost']) > 0]

    building_great_person_points, building_yield_changes, building_modifiers, modifier_table = [], [], [], []
    modifier_arguments, dynamic_modifiers = [], []

    six_style_build_dict = [i for i in six_style_build_dict]

    building_great_person_points = [i for i in building_great_person_points if
                                    not i['BuildingType'] in existing_buildings_gpp]

    building_yield_changes = [i for i in building_yield_changes if not i['BuildingType'] in existing_buildings_yields]

    for building in six_style_build_extras:
        name = building['BuildingType']
        if building.get('YieldType', None) is not None and building['YieldType'] != 'NONE':
            for idx, amount in enumerate(building['YieldType']['iCommerce']):
                if int(amount) != 0:
                    building_yield_changes.append({'BuildingType': name, 'YieldType': commerce_map[idx],
                                                   'YieldChange': amount})
        if building.get('GreatPersonClassType', 'NONE') != 'NONE':
            building_great_person_points.append({'BuildingType': name,
                                                 'GreatPersonClassType': gpp_map[building['GreatPersonClassType']],
                                                 'PointsPerTurn': building['PointsPerTurn']})
        if building.get('YieldModifiers', None) is not None and building['YieldModifiers'] != 'NONE':
            for idx, amount in enumerate(building['YieldModifiers']['iYield']):
                if int(amount) != 0:
                    name = building['BuildingType']
                    modifier_id = f"{name[9:]}_ADD{yield_map[idx][5:]}YIELD"
                    building_modifiers.append({'BuildingType': name, 'ModifierId': modifier_id})
                    modifier_table.append({'ModifierId': modifier_id,
                                           'ModifierType': 'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER'})
                    modifier_arguments.append({'ModifierID': modifier_id, 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                                               'Value': amount})
                    modifier_arguments.append(
                        {'ModifierID': modifier_id, 'Name': 'YieldType', 'Type': 'ARGTYPE_IDENTITY',
                         'Value': yield_map[idx]})

        if building.get('CommerceModifier', None) is not None and building['CommerceModifier'] != 'NONE':
            for idx, amount in enumerate(building['CommerceModifier']['iCommerce']):
                if int(amount) != 0:
                    modifier_id = f"{name[9:]}_ADD{commerce_map[idx][5:]}YIELD"
                    building_modifiers.append({'BuildingType': name, 'ModifierId': modifier_id})
                    modifier_table.append({'ModifierId': modifier_id,
                                           'ModifierType': 'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER'})
                    modifier_arguments.append({'ModifierId': modifier_id, 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                                               'Value': amount})
                    modifier_arguments.append(
                        {'ModifierId': modifier_id, 'Name': 'YieldType', 'Type': 'ARGTYPE_IDENTITY',
                         'Value': commerce_map[idx]})

        if building.get('BonusYieldModifiers', None) is not None and building['BonusYieldModifiers'] != 'NONE':
            for resource in building['BonusYieldModifiers']['BonusYieldModifier']:
                for idx, amount in enumerate(resource['YieldModifiers']['iYield']):
                    if int(amount) != 0:
                        modifier_id = f"{name[9:]}_{resource['BonusType']}_MULT_YIELD"
                        building_modifiers.append({'BuildingType': name, 'ModifierId': modifier_id})
                        modifier_table.append({'ModifierId': modifier_id,
                                               'ModifierType': 'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER'})
                        modifier_arguments.append(
                            {'ModifierId': modifier_id, 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                             'Value': amount})
                        modifier_arguments.append(
                            {'ModifierId': modifier_id, 'Name': 'YieldType', 'Type': 'ARGTYPE_IDENTITY',
                             'Value': yield_map[idx]})
                        # TODO add requirement needing access to the bonus resource

        if building.get('iTradeRouteModifier', None) is not None and building['iTradeRouteModifier'] != '0':
            trade_route_modifier = 'MODIFIER_CITY_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL'
            modifier_id = f"{name[9:]}_TRADE_ROUTE_YIELD_MULT"
            vt = building['iTradeRouteModifier']
            if trade_route_modifier not in [i for i in dynamic_modifiers]:
                dynamic_modifiers.append({'ModifierType': trade_route_modifier,
                                          'CollectionType': 'COLLECTION_OWNER',
                                          'EffectType': 'EFFECT_ADJUST_CITY_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL'})
            building_modifiers.append({'BuildingType': name, 'ModifierId': modifier_id})
            modifier_table.append({'ModifierId': modifier_id, 'ModifierType': trade_route_modifier})
            modifier_arguments.append({'ModifierId': modifier_id, 'Name': 'YieldType', 'Type': 'ARGTYPE_IDENTITY',
                                       'Value': 'YIELD_PRODUCTION, YIELD_FOOD, YIELD_SCIENCE, YIELD_CULTURE, YIELD_GOLD, YIELD_FAITH'})
            modifier_arguments.append({'ModifierId': modifier_id, 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                                       'Value': f'{vt}, {vt}, {vt}, {vt}, {vt}, {vt}'})
        if building.get('FreeBonus', None) is not None and building['FreeBonus'] != 'NONE':
            modifier_id = f"{name[9:]}_GRANT_{building['FreeBonus'][6:]}"
            building_modifiers.append({'BuildingType': name, 'ModifierId': modifier_id})
            modifier_table.append(
                {'ModifierId': modifier_id, 'ModifierType': 'MODIFIER_SINGLE_CITY_GRANT_RESOURCE_IN_CITY'})
            modifier_arguments.append({'ModifierId': modifier_id, 'Name': 'ResourceType', 'Type': 'ARGTYPE_IDENTITY',
                                       'Value': f"RESOURCE_{building['FreeBonus'][6:]}"})
            modifier_arguments.append({'ModifierId': modifier_id, 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                                       'Value': f"{building['iNumFreeBonuses']}"})
            # TODO implement resource placeholders in types, resources
        if building.get('FreeBonus2', None) is not None and building['FreeBonus2'] != 'NONE':
            modifier_id = f"{name[9:]}_GRANT_{building['FreeBonus2'][6:]}"
            building_modifiers.append({'BuildingType': name, 'ModifierId': modifier_id})
            modifier_table.append(
                {'ModifierId': modifier_id, 'ModifierType': 'MODIFIER_SINGLE_CITY_GRANT_RESOURCE_IN_CITY'})
            modifier_arguments.append({'ModifierId': modifier_id, 'Name': 'ResourceType', 'Type': 'ARGTYPE_IDENTITY',
                                       'Value': f"RESOURCE_{building['FreeBonus2'][6:]}"})
            modifier_arguments.append({'ModifierId': modifier_id, 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                                       'Value': f"{building['iNumFreeBonuses']}"})

        if building.get('FreeBonus3', None) is not None and building['FreeBonus3'] != 'NONE':
            modifier_id = f"{name[9:]}_GRANT_{building['FreeBonus3'][6:]}"
            building_modifiers.append({'BuildingType': name, 'ModifierId': modifier_id})
            modifier_table.append(
                {'ModifierId': modifier_id, 'ModifierType': 'MODIFIER_SINGLE_CITY_GRANT_RESOURCE_IN_CITY'})
            modifier_arguments.append({'ModifierId': modifier_id, 'Name': 'ResourceType', 'Type': 'ARGTYPE_IDENTITY',
                                       'Value': f"RESOURCE_{building['FreeBonus3'][6:]}"})
            modifier_arguments.append({'ModifierId': modifier_id, 'Name': 'Amount', 'Type': 'ARGTYPE_IDENTITY',
                                       'Value': f"{building['iNumFreeBonuses']}"})

            # if building.get('Bonus', None) is not None and building['Bonus'] != 'NONE':
            # to implement
            """'DomainProductionModifiers': 'DomainProductionModifiers',
            MARITIMIEINDUSTRIES_ANCIENT_NAVAL_MELEE_PRODUCTION, Amount, ARGTYPE_IDENTITY, 100, -1,
            MARITIMIEINDUSTRIES_ANCIENT_NAVAL_MELEE_PRODUCTION, EraType, ARGTYPE_IDENTITY, ERA_ANCIENT, -1,
            MARITIMIEINDUSTRIES_ANCIENT_NAVAL_MELEE_PRODUCTION, UnitPromotionClass, ARGTYPE_IDENTITY, PROMOTION_CLASS_NAVAL_MELEE, -1,
            'iGlobalSpaceProductionModifier': 'iGlobalSpaceProductionModifier' "HONG_KONG CITY STATE BONUS"
            'iFreePromotionPick': 'iFreePromotionPick'"""

    for building in six_style_build_dict:
        if not building['BuildingType'] in existing_buildings:
            kind_string += f"\n('{building['BuildingType']}', 'KIND_BUILDING'),"

    building_table_string = build_sql_table(six_style_build_dict, 'Buildings')
    building_table_string += build_sql_table(building_great_person_points, 'Building_GreatPersonPoints')
    building_table_string += build_sql_table(building_yield_changes, 'Building_YieldChanges')
    building_table_string += build_sql_table(building_modifiers, 'BuildingModifiers')
    building_table_string += build_sql_table(modifier_table, 'Modifiers')
    building_table_string += build_sql_table(modifier_arguments, 'ModifierArguments')

    print(debug_string)

    return building_table_string, kind_string