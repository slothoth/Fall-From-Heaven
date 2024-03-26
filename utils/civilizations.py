import xmltodict

civ_patch = {'MERCURIANS': ['UNIT_ANGEL_OF_DEATH', 'UNIT_OPHANIM', 'UNIT_SERAPH', 'UNIT_REPENTANT_ANGEL',
                                'UNIT_VALKYRIE', 'UNIT_HERALD'],
                 'BANNOR': ['UNIT_DEMAGOG', 'UNIT_FLAGBEARER'], 'BALSERAPHS': ['UNIT_FREAK'],
                 'ILLIANS': ['UNIT_HIGH_PRIEST_OF_WINTER'], 'KURIOTATES': ['UNIT_HERNE'], 'DOVIELLO': ['UNIT_LUCIAN'],
                 'LANUN': ['UNIT_BLACK_WIND']}


def civilizations(civs):
    with open('data/CIV4CivilizationInfos.xml', 'r') as file:
        civ_dict = xmltodict.parse(file.read())['Civ4CivilizationInfos']['CivilizationInfos']['CivilizationInfo']

    unique_buildings_to_remove = []
    unique_units_to_remove = []
    unique_buildings_not_remove = []
    unique_units_not_remove = []
    for civ in civ_dict:
        if civ['Type'][13:] in civs:
            for unique_building in civ['Buildings']['Building']:
                unique_buildings_not_remove.append(unique_building['BuildingType'])
            for unique_unit in civ['Units']['Unit']:
                if unique_unit['UnitType'] != 'NONE':
                    unique_units_not_remove.append(unique_unit['UnitType'])

    for civ in civ_dict:
        if civ['Type'][13:] not in civs:
            for unique_unit in civ['Units']['Unit']:
                if unique_unit['UnitType'] != 'NONE':
                    if unique_unit['UnitType'] not in unique_units_not_remove:
                        unique_units_to_remove.append(unique_unit['UnitType'])
            if civ['Hero'] != 'NONE':
                unique_units_to_remove.append(civ['Hero'])

            if civ.get('Buildings', False):
                if isinstance(civ['Buildings']['Building'], dict):
                    unique_buildings_to_remove.append(civ['Buildings']['Building']['BuildingType'])
                else:
                    for unique_building in civ['Buildings']['Building']:
                        if unique_building['BuildingType'] != 'NONE':
                            unique_buildings_to_remove.append(unique_building['BuildingType'])

    # patch mercurian angels..., demagog, lightbearer
    for civ, units in civ_patch.items():
        if civ not in civs:
            for weird_unit in units:
                unique_units_to_remove.append(weird_unit)

    return unique_units_to_remove, unique_buildings_to_remove