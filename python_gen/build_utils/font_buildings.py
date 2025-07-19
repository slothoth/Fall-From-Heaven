import sys
import sqlite3
import json
import os
def levenshtein_distance(s1, s2):
    if len(s1) < len(s2):
        return levenshtein_distance(s2, s1)

    if len(s2) == 0:
        return len(s1)

    previous_row = range(len(s2) + 1)
    for i, c1 in enumerate(s1):
        current_row = [i + 1]
        for j, c2 in enumerate(s2):
            insertions = previous_row[j + 1] + 1
            deletions = current_row[j] + 1
            substitutions = previous_row[j] + (c1 != c2)
            current_row.append(min(insertions, deletions, substitutions))
        previous_row = current_row
    return previous_row[-1]


def find_closest_match(original_string, string_list):
    if not string_list:
        return None

    original_lower = original_string.lower()
    closest_match = None
    min_distance = sys.maxsize  # Use a very large number initially

    for s in string_list:
        s_lower = s.lower()
        distance = levenshtein_distance(original_lower, s_lower)
        if distance < min_distance:
            min_distance = distance
            closest_match = s
    return closest_match


SQL_PATH = "C:/Users/Sam/AppData/Local/Firaxis Games/Sid Meier's Civilization VI/Cache/DebugGameplay.sqlite"

with open('building_icons.md', 'r') as f:
    building_names = f.readlines()

with open('new_building_icons.json', 'r') as f:
    building_icon_map = json.load(f)

for key,val in building_icon_map.items():
    if os.path.exists(f'atlas_svg_building/{val}.svg'):
        os.rename(f'atlas_svg_building/{val}.svg', f'atlas_svg_building/ICON_{key}.svg')


conn = sqlite3.connect(SQL_PATH)
cursor = conn.cursor()
cursor.execute("SELECT BuildingType FROM Buildings;")
building_infos = cursor.fetchall()
conn.close()

building_infos = [i[0] for i in building_infos]

buildings_ordered = {}
for i in building_names:
    split = i.split('  ')
    short_name = split[-1].strip()
    long_name = split[0].strip().replace(' ', '_')
    if short_name in buildings_ordered:
        print('ERROR')
    buildings_ordered[short_name] = long_name
found_buildings = {}
for key, val in buildings_ordered.items():
    closest_match = find_closest_match('BUILDING_' + val, building_infos)
    found_buildings[closest_match] = key

print()

