import pandas as pd
import os

# wtf is this sorcery
# ModifierArguments(ModifierId, Name, Type, "Value")
# ('MODIFIER_SHRINE_CITY_HERO_EXTRA_LIFESPAN', 'Key', 'ARGTYPE_IDENTITY', 'CityHeroExtraLifespan');
# This to me implies that CityHeroExtraLifeSpan is a key to an internal dictionary of city properties: MODIFIER_SINGLE_CITY_ADJUST_PROPERTY
# could we find hidden keys that are exposed but undocumented? Apparently you can find it in a lua property
substring = 'EFFECT_GRANT_PLAYER_SPECIFIC'
records = {}
for i in os.listdir('data/tables/'):
    if i == 'Kinds.csv':
        continue
    if i.endswith('.csv'):
        df = pd.read_csv(f'data/tables/{i}')
        records['i'] = []
        for column in df.columns:
            if df[column].apply(lambda x: isinstance(x, str)).any():
                if df[column].str.contains(substring, case=False).any():
                    try:
                        found_in_table = df[df[column].str.contains(substring, case=False).fillna(False)]
                        records['i'].append(df[df[column].str.contains(substring, case=False).fillna(False)])
                    except Exception as e:
                        print(f'failed read on {i}.{column} with error {e}')
