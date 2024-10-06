INSERT INTO Policies(PolicyType, Description, PrereqCivic, PrereqTech, Name, GovernmentSlotType) VALUES
('SLTH_POLICY_DESPOTISM', 'LOC_SLTH_POLICY_DESPOTISM_DESCRIPTION', NULL, NULL, 'LOC_SLTH_POLICY_DESPOTISM_NAME', 'SLOT_DIPLOMATIC'),
('SLTH_POLICY_CITY_STATES', 'LOC_SLTH_POLICY_CITY_STATES_DESCRIPTION', NULL, 'TECH_CARTOGRAPHY', 'LOC_SLTH_POLICY_CITY_STATES_NAME', 'SLOT_DIPLOMATIC'),
('SLTH_POLICY_GOD_KING', 'LOC_SLTH_POLICY_GOD_KING_DESCRIPTION', 'CIVIC_MYSTICISM', NULL, 'LOC_SLTH_POLICY_GOD_KING_NAME', 'SLOT_DIPLOMATIC'),
('SLTH_POLICY_ARISTOCRACY', 'LOC_SLTH_POLICY_ARISTOCRACY_DESCRIPTION', 'CIVIC_CODE_OF_LAWS', NULL, 'LOC_SLTH_POLICY_ARISTOCRACY_NAME', 'SLOT_DIPLOMATIC'),
('SLTH_POLICY_THEOCRACY', 'LOC_SLTH_POLICY_THEOCRACY_DESCRIPTION', 'CIVIC_RELIGIOUS_LAW', NULL, 'LOC_SLTH_POLICY_THEOCRACY_NAME', 'SLOT_DIPLOMATIC'),
('SLTH_POLICY_REPUBLIC', 'LOC_SLTH_POLICY_REPUBLIC_DESCRIPTION', 'CIVIC_TAXATION', NULL, 'LOC_SLTH_POLICY_REPUBLIC_NAME', 'SLOT_DIPLOMATIC'),
('SLTH_POLICY_RELIGION', 'LOC_SLTH_POLICY_RELIGION_DESCRIPTION', NULL, NULL, 'LOC_SLTH_POLICY_RELIGION_NAME', 'SLOT_ECONOMIC'),
('SLTH_POLICY_PACIFISM', 'LOC_SLTH_POLICY_PACIFISM_DESCRIPTION', NULL, NULL, 'LOC_SLTH_POLICY_PACIFISM_NAME', 'SLOT_ECONOMIC'),
('SLTH_POLICY_NATIONHOOD', 'LOC_SLTH_POLICY_NATIONHOOD_DESCRIPTION', NULL, NULL, 'LOC_SLTH_POLICY_NATIONHOOD_NAME', 'SLOT_ECONOMIC'),
('SLTH_POLICY_SACRIFICE_THE_WEAK', 'LOC_SLTH_POLICY_SACRIFICE_THE_WEAK_DESCRIPTION', 'CIVIC_INFERNAL_PACT', NULL, 'LOC_SLTH_POLICY_SACRIFICE_THE_WEAK_NAME', 'SLOT_ECONOMIC'),
('SLTH_POLICY_SOCIAL_ORDER', 'LOC_SLTH_POLICY_SOCIAL_ORDER_DESCRIPTION', 'CIVIC_RELIGIOUS_LAW', NULL, 'LOC_SLTH_POLICY_SOCIAL_ORDER_NAME', 'SLOT_ECONOMIC'),
('SLTH_POLICY_CONSUMPTION', 'LOC_SLTH_POLICY_CONSUMPTION_DESCRIPTION', 'CIVIC_CURRENCY', NULL, 'LOC_SLTH_POLICY_CONSUMPTION_NAME', 'SLOT_ECONOMIC'),
('SLTH_POLICY_SCHOLARSHIP', 'LOC_SLTH_POLICY_SCHOLARSHIP_DESCRIPTION', NULL, 'TECH_ARCANE_LORE', 'LOC_SLTH_POLICY_SCHOLARSHIP_NAME', 'SLOT_ECONOMIC'),
('SLTH_POLICY_LIBERTY', 'LOC_SLTH_POLICY_LIBERTY_DESCRIPTION', 'CIVIC_MERCANTILISM', NULL, 'LOC_SLTH_POLICY_LIBERTY_NAME', 'SLOT_ECONOMIC'),
('SLTH_POLICY_CRUSADE', 'LOC_SLTH_POLICY_CRUSADE_DESCRIPTION', 'CIVIC_FANATICISM', NULL, 'LOC_SLTH_POLICY_CRUSADE_NAME', 'SLOT_ECONOMIC'),
('SLTH_POLICY_TRIBALISM', 'LOC_SLTH_POLICY_TRIBALISM_DESCRIPTION', NULL, NULL, 'LOC_SLTH_POLICY_TRIBALISM_NAME', 'SLOT_MILITARY'),
('SLTH_POLICY_APPRENTICESHIP', 'LOC_SLTH_POLICY_APPRENTICESHIP_DESCRIPTION', 'CIVIC_EDUCATION', NULL, 'LOC_SLTH_POLICY_APPRENTICESHIP_NAME', 'SLOT_MILITARY'),
('SLTH_POLICY_SLAVERY', 'LOC_SLTH_POLICY_SLAVERY_DESCRIPTION', 'CIVIC_WAY_OF_THE_WICKED', NULL, 'LOC_SLTH_POLICY_SLAVERY_NAME', 'SLOT_MILITARY'),
('SLTH_POLICY_ARETE', 'LOC_SLTH_POLICY_ARETE_DESCRIPTION', 'CIVIC_ARETE', NULL, 'LOC_SLTH_POLICY_ARETE_NAME', 'SLOT_MILITARY'),
('SLTH_POLICY_MILITARY_STATE', 'LOC_SLTH_POLICY_MILITARY_STATE_DESCRIPTION', 'CIVIC_MILITARY_TRADITION', NULL, 'LOC_SLTH_POLICY_MILITARY_STATE_NAME', 'SLOT_MILITARY'),
('SLTH_POLICY_CASTE_SYSTEM', 'LOC_SLTH_POLICY_CASTE_SYSTEM_DESCRIPTION', 'CIVIC_TAXATION', NULL, 'LOC_SLTH_POLICY_CASTE_SYSTEM_NAME', 'SLOT_MILITARY'),
('SLTH_POLICY_GUILDS', 'LOC_SLTH_POLICY_GUILDS_DESCRIPTION', 'CIVIC_GUILDS', NULL, 'LOC_SLTH_POLICY_GUILDS_NAME', 'SLOT_MILITARY'),
('SLTH_POLICY_DECENTRALIZATION', 'LOC_SLTH_POLICY_DECENTRALIZATION_DESCRIPTION', NULL, NULL, 'LOC_SLTH_POLICY_DECENTRALIZATION_NAME', 'SLOT_GREAT_PERSON'),
('SLTH_POLICY_AGRARIANISM', 'LOC_SLTH_POLICY_AGRARIANISM_DESCRIPTION', NULL, 'TECH_CALENDAR', 'LOC_SLTH_POLICY_AGRARIANISM_NAME', 'SLOT_GREAT_PERSON'),
('SLTH_POLICY_CONQUEST', 'LOC_SLTH_POLICY_CONQUEST_DESCRIPTION', 'CIVIC_MILITARY_TRADITION', NULL, 'LOC_SLTH_POLICY_CONQUEST_NAME', 'SLOT_GREAT_PERSON'),
('SLTH_POLICY_MERCANTILISM', 'LOC_SLTH_POLICY_MERCANTILISM_DESCRIPTION', 'CIVIC_MERCANTILISM', NULL, 'LOC_SLTH_POLICY_MERCANTILISM_NAME', 'SLOT_GREAT_PERSON'),
('SLTH_POLICY_FOREIGN_TRADE', 'LOC_SLTH_POLICY_FOREIGN_TRADE_DESCRIPTION', NULL, 'TECH_TRADE', 'LOC_SLTH_POLICY_FOREIGN_TRADE_NAME', 'SLOT_GREAT_PERSON'),
('SLTH_POLICY_GUARDIAN_OF_NATURE', 'LOC_SLTH_POLICY_GUARDIAN_OF_NATURE_DESCRIPTION', 'CIVIC_HIDDEN_PATHS', NULL, 'LOC_SLTH_POLICY_GUARDIAN_OF_NATURE_NAME', 'SLOT_GREAT_PERSON');
INSERT INTO PolicyModifiers(PolicyType, ModifierId) VALUES
('SLTH_POLICY_DESPOTISM', 'MODIFIER_SLTH_POLICY_DESPOTISM_ADJUST_WAR_WEARINESS'),
('SLTH_POLICY_CITY_STATES', 'MODIFIER_SLTH_POLICY_CITY_STATES_ADJUST_WAR_WEARINESS'),
('SLTH_POLICY_CITY_STATES', 'MODIFIER_SLTH_POLICY_CITY_STATES_ADD_CULTUREYIELD'),
('SLTH_POLICY_GOD_KING', 'MODIFIER_SLTH_POLICY_GOD_KING_ADD_PRODUCTIONYIELD'),
('SLTH_POLICY_GOD_KING', 'MODIFIER_SLTH_POLICY_GOD_KING_ADD_GOLDYIELD'),
('SLTH_POLICY_ARISTOCRACY', 'MODIFIER_SLTH_POLICY_ARISTOCRACY_FARM_FOOD'),
('SLTH_POLICY_ARISTOCRACY', 'MODIFIER_YieldType_FARM_GOLD'),
('SLTH_POLICY_REPUBLIC', 'MODIFIER_REPUBLIC_INCREASE_GPP_MULT'),
('SLTH_POLICY_REPUBLIC', 'MODIFIER_SLTH_POLICY_REPUBLIC_ADD_CULTUREYIELD'),
('SLTH_POLICY_RELIGION', 'MODIFIER_SLTH_POLICY_RELIGION_ADD_CULTUREYIELD'),
('SLTH_POLICY_RELIGION', 'MODIFIER_SLTH_POLICY_RELIGION_BUILDING_TEMPLE_OF_KILMORPH_ADD_AMENITIES'),
('SLTH_POLICY_RELIGION', 'MODIFIER_SLTH_POLICY_RELIGION_BUILDING_TEMPLE_OF_LEAVES_ADD_AMENITIES'),
('SLTH_POLICY_RELIGION', 'MODIFIER_SLTH_POLICY_RELIGION_BUILDING_TEMPLE_OF_THE_ORDER_ADD_AMENITIES'),
('SLTH_POLICY_RELIGION', 'MODIFIER_SLTH_POLICY_RELIGION_BUILDING_TEMPLE_OF_THE_OVERLORDS_ADD_AMENITIES'),
('SLTH_POLICY_RELIGION', 'MODIFIER_SLTH_POLICY_RELIGION_BUILDING_TEMPLE_OF_THE_VEIL_ADD_AMENITIES'),
('SLTH_POLICY_RELIGION', 'MODIFIER_SLTH_POLICY_RELIGION_BUILDING_TEMPLE_OF_THE_EMPYREAN_ADD_AMENITIES'),
('SLTH_POLICY_PACIFISM', 'MODIFIER_PACIFISM_INCREASE_GPP_MULT'),
('SLTH_POLICY_PACIFISM', 'MODIFIER_SLTH_POLICY_PACIFISM_MILITARY_PRODUCTION'),
('SLTH_POLICY_PACIFISM', 'MODIFIER_SLTH_POLICY_PACIFISM_ADJUST_WAR_WEARINESS'),
('SLTH_POLICY_NATIONHOOD', 'MODIFIER_SLTH_POLICY_NATIONHOOD_MILITARY_PRODUCTION'),
('SLTH_POLICY_NATIONHOOD', 'MODIFIER_SLTH_POLICY_NATIONHOOD_ADJUST_WAR_WEARINESS'),
('SLTH_POLICY_NATIONHOOD', 'MODIFIER_SLTH_POLICY_NATIONHOOD_BUILDING_TRAINING_YARD_ADD_AMENITIES'),
('SLTH_POLICY_SACRIFICE_THE_WEAK', 'MODIFIER_SACRIFICE_THE_WEAK_INCREASE_GPP_MULT'),
('SLTH_POLICY_SACRIFICE_THE_WEAK', 'MODIFIER_SLTH_POLICY_SACRIFICE_THE_WEAK_ADJUST_HOUSING'),
('SLTH_POLICY_SACRIFICE_THE_WEAK', 'MODIFIER_SLTH_POLICY_SACRIFICE_THE_WEAK_ADD_GOLDYIELD'),
('SLTH_POLICY_SOCIAL_ORDER', 'MODIFIER_SLTH_POLICY_SOCIAL_ORDER_BUILDING_COURTHOUSE_ADD_AMENITIES'),
('SLTH_POLICY_SOCIAL_ORDER', 'MODIFIER_SLTH_POLICY_SOCIAL_ORDER_BUILDING_BASILICA_ADD_AMENITIES'),
('SLTH_POLICY_CONSUMPTION', 'MODIFIER_SLTH_POLICY_CONSUMPTION_ADD_GOLDYIELD'),
('SLTH_POLICY_CONSUMPTION', 'MODIFIER_SLTH_POLICY_CONSUMPTION_BUILDING_MARKET_ADD_AMENITIES'),
('SLTH_POLICY_CONSUMPTION', 'MODIFIER_SLTH_POLICY_CONSUMPTION_BUILDING_TAVERN_ADD_AMENITIES'),
('SLTH_POLICY_CONSUMPTION', 'MODIFIER_SLTH_POLICY_CONSUMPTION_BUILDING_THEATRE_ADD_AMENITIES'),
('SLTH_POLICY_SCHOLARSHIP', 'MODIFIER_SLTH_POLICY_SCHOLARSHIP_ADJUST_WAR_WEARINESS'),
('SLTH_POLICY_SCHOLARSHIP', 'MODIFIER_SLTH_POLICY_SCHOLARSHIP_ADD_SCIENCEYIELD'),
('SLTH_POLICY_SCHOLARSHIP', 'MODIFIER_SLTH_POLICY_SCHOLARSHIP_BUILDING_LIBRARY_ADD_AMENITIES'),
('SLTH_POLICY_LIBERTY', 'MODIFIER_SLTH_POLICY_LIBERTY_ADJUST_WAR_WEARINESS'),
('SLTH_POLICY_LIBERTY', 'MODIFIER_SLTH_POLICY_LIBERTY_ADD_CULTUREYIELD'),
('SLTH_POLICY_CRUSADE', 'MODIFIER_SLTH_POLICY_CRUSADE_ADJUST_WAR_WEARINESS'),
('SLTH_POLICY_APPRENTICESHIP', 'ATTACH_CITIES_APPRENTICESHIP_POLICY'),
('SLTH_POLICY_APPRENTICESHIP', 'MODIFIER_SLTH_POLICY_APPRENTICESHIP_MILITARY_PRODUCTION'),
('SLTH_POLICY_SLAVERY', 'MODIFIER_SLTH_POLICY_SLAVERY_QUARRY_PRODUCTION'),
('SLTH_POLICY_SLAVERY', 'MODIFIER_SLTH_POLICY_SLAVERY_SLAVE_TAKING'),
('SLTH_POLICY_ARETE', 'MODIFIER_SLTH_POLICY_ARETE_MINE_PRODUCTION'),
('SLTH_POLICY_MILITARY_STATE', 'MODIFIER_SLTH_POLICY_MILITARY_STATE_MILITARY_PRODUCTION'),
('SLTH_POLICY_MILITARY_STATE', 'MODIFIER_SLTH_POLICY_MILITARY_STATE_ADD_CULTUREYIELD'),
('SLTH_POLICY_CASTE_SYSTEM', 'MODIFIER_SLTH_POLICY_CASTE_SYSTEM_BUILD_CHARGES'),
('SLTH_POLICY_AGRARIANISM', 'MODIFIER_SLTH_POLICY_AGRARIANISM_ADJUST_HOUSING'),
('SLTH_POLICY_AGRARIANISM', 'MODIFIER_SLTH_POLICY_AGRARIANISM_FARM_FOOD'),
('SLTH_POLICY_AGRARIANISM', 'MODIFIER_YieldType_FARM_PRODUCTION'),
('SLTH_POLICY_CONQUEST', 'ATTACH_CITIES_CONQUEST_POLICY'),
('SLTH_POLICY_MERCANTILISM', 'MODIFIER_SLTH_POLICY_MERCANTILISM_FOREIGN_TRADE_SET_TO_ZERO'),
('SLTH_POLICY_MERCANTILISM', 'MODIFIER_SLTH_POLICY_MERCANTILISM_ADD_GOLDYIELD'),
('SLTH_POLICY_MERCANTILISM', 'MODIFIER_SLTH_POLICY_MERCANTILISM_BUILDING_MARKET_ADD_AMENITIES'),
('SLTH_POLICY_FOREIGN_TRADE', 'MODIFIER_SLTH_POLICY_FOREIGN_TRADE_ADJUST_TRADE_ROUTE_CAPACITY'),
('SLTH_POLICY_FOREIGN_TRADE', 'MODIFIER_SLTH_POLICY_FOREIGN_TRADE_ADD_GOLDYIELD'),
('SLTH_POLICY_FOREIGN_TRADE', 'MODIFIER_SLTH_POLICY_FOREIGN_TRADE_ADD_CULTURE_YIELD'),
('SLTH_POLICY_FOREIGN_TRADE', 'MODIFIER_SLTH_POLICY_FOREIGN_TRADE_ADJUST_TRADE_ROUTE_CAPACITY_COASTAL'),
('SLTH_POLICY_THEOCRACY', 'ATTACH_CITIES_THEOCRACY_POLICY'),
('SLTH_POLICY_GUARDIAN_OF_NATURE', 'MODIFIER_SLTH_POLICY_GUARDIAN_OF_NATURE_ADJUST_HOUSING'),
('SLTH_POLICY_GUARDIAN_OF_NATURE', 'MODIFIER_SLTH_POLICY_GUARDIAN_OF_NATURE_MILITARY_PRODUCTION'),
('SLTH_POLICY_GUARDIAN_OF_NATURE', 'MODIFIER_SLTH_POLICY_GUARDIAN_OF_NATURE_BUILDING_GROVE_ADD_AMENITIES');
INSERT INTO Government_SlotCounts(GovernmentType, GovernmentSlotType, NumSlots) VALUES
('GOVERNMENT_CHIEFDOM', 'SLOT_DIPLOMATIC', '1'),
('GOVERNMENT_CHIEFDOM', 'SLOT_WILDCARD', '1');
INSERT INTO Modifiers(ModifierId, ModifierType, Permanent, SubjectRequirementSetId) VALUES
('MODIFIER_SLTH_POLICY_DESPOTISM_ADJUST_WAR_WEARINESS', 'MODIFIER_PLAYER_ADJUST_WAR_WEARINESS', '0', NULL),
('MODIFIER_SLTH_POLICY_CITY_STATES_ADJUST_WAR_WEARINESS', 'MODIFIER_PLAYER_ADJUST_WAR_WEARINESS', '0', NULL),
('MODIFIER_SLTH_POLICY_CITY_STATES_ADD_CULTUREYIELD', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', '0', NULL),
('MODIFIER_SLTH_POLICY_GOD_KING_ADD_PRODUCTIONYIELD', 'MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_YIELD_MODIFIER', '0', NULL),
('MODIFIER_SLTH_POLICY_GOD_KING_ADD_GOLDYIELD', 'MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_YIELD_MODIFIER', '0', NULL),
('MODIFIER_SLTH_POLICY_ARISTOCRACY_FARM_FOOD', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', '0', 'PLOT_HAS_FARM_REQUIREMENTS'),
('MODIFIER_YieldType_FARM_GOLD', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', '0', 'PLOT_HAS_FARM_REQUIREMENTS'),
('MODIFIER_REPUBLIC_INCREASE_GPP_MULT', 'MODIFIER_CITY_INCREASE_GREAT_PERSON_POINT_BONUS', '0', NULL),
('MODIFIER_SLTH_POLICY_REPUBLIC_ADD_CULTUREYIELD', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', '0', NULL),
('MODIFIER_SLTH_POLICY_RELIGION_ADD_CULTUREYIELD', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', '0', NULL),
('MODIFIER_SLTH_POLICY_RELIGION_BUILDING_TEMPLE_OF_KILMORPH_ADD_AMENITIES', 'MODIFIER_PLAYER_CITIES_ADJUST_ENTERTAINMENT', '0', 'SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_KILMORPH'),
('MODIFIER_SLTH_POLICY_RELIGION_BUILDING_TEMPLE_OF_LEAVES_ADD_AMENITIES', 'MODIFIER_PLAYER_CITIES_ADJUST_ENTERTAINMENT', '0', 'SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_LEAVES'),
('MODIFIER_SLTH_POLICY_RELIGION_BUILDING_TEMPLE_OF_THE_ORDER_ADD_AMENITIES', 'MODIFIER_PLAYER_CITIES_ADJUST_ENTERTAINMENT', '0', 'SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_ORDER'),
('MODIFIER_SLTH_POLICY_RELIGION_BUILDING_TEMPLE_OF_THE_OVERLORDS_ADD_AMENITIES', 'MODIFIER_PLAYER_CITIES_ADJUST_ENTERTAINMENT', '0', 'SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_OVERLORDS'),
('MODIFIER_SLTH_POLICY_RELIGION_BUILDING_TEMPLE_OF_THE_VEIL_ADD_AMENITIES', 'MODIFIER_PLAYER_CITIES_ADJUST_ENTERTAINMENT', '0', 'SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_VEIL'),
('MODIFIER_SLTH_POLICY_RELIGION_BUILDING_TEMPLE_OF_THE_EMPYREAN_ADD_AMENITIES', 'MODIFIER_PLAYER_CITIES_ADJUST_ENTERTAINMENT', '0', 'SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_EMPYREAN'),
('MODIFIER_PACIFISM_INCREASE_GPP_MULT', 'MODIFIER_CITY_INCREASE_GREAT_PERSON_POINT_BONUS', '0', NULL),
('MODIFIER_SLTH_POLICY_PACIFISM_MILITARY_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_MILITARY_UNITS_PRODUCTION', '0', NULL),
('MODIFIER_SLTH_POLICY_PACIFISM_ADJUST_WAR_WEARINESS', 'MODIFIER_PLAYER_ADJUST_WAR_WEARINESS', '0', NULL),
('MODIFIER_SLTH_POLICY_NATIONHOOD_MILITARY_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_MILITARY_UNITS_PRODUCTION', '0', NULL),
('MODIFIER_SLTH_POLICY_NATIONHOOD_ADJUST_WAR_WEARINESS', 'MODIFIER_PLAYER_ADJUST_WAR_WEARINESS', '0', NULL),
('MODIFIER_SLTH_POLICY_NATIONHOOD_BUILDING_TRAINING_YARD_ADD_AMENITIES', 'MODIFIER_PLAYER_CITIES_ADJUST_ENTERTAINMENT', '0', 'SLTH_REQUIRES_CITY_HAS_TRAINING_YARD'),
('MODIFIER_SACRIFICE_THE_WEAK_INCREASE_GPP_MULT', 'MODIFIER_CITY_INCREASE_GREAT_PERSON_POINT_BONUS', '0', NULL),
('MODIFIER_SLTH_POLICY_SACRIFICE_THE_WEAK_ADJUST_HOUSING', 'MODIFIER_PLAYER_CITIES_ADJUST_POLICY_HOUSING', '0', NULL),
('MODIFIER_SLTH_POLICY_SACRIFICE_THE_WEAK_ADD_GOLDYIELD', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', '0', NULL),
('MODIFIER_SLTH_POLICY_SOCIAL_ORDER_BUILDING_COURTHOUSE_ADD_AMENITIES', 'MODIFIER_PLAYER_CITIES_ADJUST_ENTERTAINMENT', '0', 'SLTH_REQUIRES_CITY_HAS_COURTHOUSE'),
('MODIFIER_SLTH_POLICY_SOCIAL_ORDER_BUILDING_BASILICA_ADD_AMENITIES', 'MODIFIER_PLAYER_CITIES_ADJUST_ENTERTAINMENT', '0', 'SLTH_REQUIRES_CITY_HAS_BASILICA'),
('MODIFIER_SLTH_POLICY_CONSUMPTION_ADD_GOLDYIELD', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', '0', NULL),
('MODIFIER_SLTH_POLICY_CONSUMPTION_BUILDING_MARKET_ADD_AMENITIES', 'MODIFIER_PLAYER_CITIES_ADJUST_ENTERTAINMENT', '0', 'SLTH_REQUIRES_CITY_HAS_MARKET'),
('MODIFIER_SLTH_POLICY_CONSUMPTION_BUILDING_TAVERN_ADD_AMENITIES', 'MODIFIER_PLAYER_CITIES_ADJUST_ENTERTAINMENT', '0', 'SLTH_REQUIRES_CITY_HAS_TAVERN'),
('MODIFIER_SLTH_POLICY_CONSUMPTION_BUILDING_THEATRE_ADD_AMENITIES', 'MODIFIER_PLAYER_CITIES_ADJUST_ENTERTAINMENT', '0', 'SLTH_REQUIRES_CITY_HAS_THEATRE'),
('MODIFIER_SLTH_POLICY_SCHOLARSHIP_ADJUST_WAR_WEARINESS', 'MODIFIER_PLAYER_ADJUST_WAR_WEARINESS', '0', NULL),
('MODIFIER_SLTH_POLICY_SCHOLARSHIP_ADD_SCIENCEYIELD', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', '0', NULL),
('MODIFIER_SLTH_POLICY_SCHOLARSHIP_BUILDING_LIBRARY_ADD_AMENITIES', 'MODIFIER_PLAYER_CITIES_ADJUST_ENTERTAINMENT', '0', 'SLTH_REQUIRES_CITY_HAS_LIBRARY'),
('MODIFIER_SLTH_POLICY_LIBERTY_ADJUST_WAR_WEARINESS', 'MODIFIER_PLAYER_ADJUST_WAR_WEARINESS', '0', NULL),
('MODIFIER_SLTH_POLICY_LIBERTY_ADD_CULTUREYIELD', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', '0', NULL),
('MODIFIER_SLTH_POLICY_CRUSADE_ADJUST_WAR_WEARINESS', 'MODIFIER_PLAYER_ADJUST_WAR_WEARINESS', '0', NULL),
('MODIFIER_SLTH_POLICY_APPRENTICESHIP_MILITARY_EXPERIENCE', 'MODIFIER_CITY_TRAINED_UNITS_ADJUST_GRANT_EXPERIENCE', '0', NULL),
('MODIFIER_SLTH_POLICY_APPRENTICESHIP_MILITARY_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_MILITARY_UNITS_PRODUCTION', '0', NULL),
('MODIFIER_SLTH_POLICY_SLAVERY_QUARRY_PRODUCTION', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', '0', 'PLOT_HAS_QUARRY_REQUIREMENTS'),
('MODIFIER_SLTH_POLICY_SLAVERY_SLAVE_TAKING_MODIFIER', 'MODIFIER_UNIT_ADJUST_COMBAT_UNIT_CAPTURE', '0', NULL),
('MODIFIER_SLTH_POLICY_SLAVERY_SLAVE_TAKING', 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', '0', NULL),
('MODIFIER_SLTH_POLICY_ARETE_MINE_PRODUCTION', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', '0', 'PLOT_HAS_MINE_REQUIREMENTS'),
('MODIFIER_SLTH_POLICY_MILITARY_STATE_MILITARY_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_MILITARY_UNITS_PRODUCTION', '0', NULL),
('MODIFIER_SLTH_POLICY_MILITARY_STATE_ADD_CULTUREYIELD', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', '0', NULL),
('MODIFIER_SLTH_POLICY_CASTE_SYSTEM_BUILD_CHARGES', 'MODIFIER_PLAYER_TRAINED_UNITS_ADJUST_BUILDER_CHARGES', '1', 'UNIT_IS_BUILDER'),
('MODIFIER_SLTH_POLICY_AGRARIANISM_ADJUST_HOUSING', 'MODIFIER_PLAYER_CITIES_ADJUST_POLICY_HOUSING', '0', NULL),
('MODIFIER_SLTH_POLICY_AGRARIANISM_FARM_FOOD', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', '0', 'PLOT_HAS_FARM_REQUIREMENTS'),
('MODIFIER_YieldType_FARM_PRODUCTION', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', '0', 'PLOT_HAS_FARM_REQUIREMENTS'),
('MODIFIER_SLTH_POLICY_CONQUEST_MILITARY_EXPERIENCE', 'MODIFIER_CITY_TRAINED_UNITS_ADJUST_GRANT_EXPERIENCE', '0', NULL),
('MODIFIER_SLTH_POLICY_MERCANTILISM_FOREIGN_TRADE_SET_TO_ZERO', 'MODIFIER_PLAYER_ADJUST_INTERNATIONAL_TRADE_ROUTE_YIELD_MODIFIER_WARLORDS', '0', NULL),
('MODIFIER_SLTH_POLICY_MERCANTILISM_ADD_GOLDYIELD', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', '0', NULL),
('MODIFIER_SLTH_POLICY_MERCANTILISM_BUILDING_MARKET_ADD_AMENITIES', 'MODIFIER_PLAYER_CITIES_ADJUST_ENTERTAINMENT', '0', 'SLTH_REQUIRES_CITY_HAS_MARKET'),
('MODIFIER_SLTH_POLICY_FOREIGN_TRADE_ADJUST_TRADE_ROUTE_CAPACITY', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY', '0', NULL),
('MODIFIER_SLTH_POLICY_FOREIGN_TRADE_ADD_GOLDYIELD', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', '0', NULL),
('MODIFIER_SLTH_POLICY_FOREIGN_TRADE_ADD_CULTURE_YIELD', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', '0', NULL),
('MODIFIER_SLTH_POLICY_FOREIGN_TRADE_ADJUST_TRADE_ROUTE_CAPACITY_COASTAL_PER_CITY', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY', '0', 'PLOT_IS_ADJACENT_TO_COAST'),
('MODIFIER_SLTH_POLICY_FOREIGN_TRADE_ADJUST_TRADE_ROUTE_CAPACITY_COASTAL', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', '0', NULL),
('MODIFIER_SLTH_POLICY_GUARDIAN_OF_NATURE_ADJUST_HOUSING', 'MODIFIER_PLAYER_CITIES_ADJUST_POLICY_HOUSING', '0', NULL),
('MODIFIER_SLTH_POLICY_GUARDIAN_OF_NATURE_MILITARY_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_MILITARY_UNITS_PRODUCTION', '0', NULL),
('MODIFIER_SLTH_POLICY_GUARDIAN_OF_NATURE_BUILDING_GROVE_ADD_AMENITIES', 'MODIFIER_PLAYER_CITIES_ADJUST_ENTERTAINMENT', '0', 'SLTH_REQUIRES_CITY_HAS_GROVE');
INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('MODIFIER_SLTH_POLICY_DESPOTISM_ADJUST_WAR_WEARINESS', 'Amount', 'ARGTYPE_IDENTITY', '-50'),
('MODIFIER_SLTH_POLICY_DESPOTISM_ADJUST_WAR_WEARINESS', 'Overall', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_CITY_STATES_ADJUST_WAR_WEARINESS', 'Amount', 'ARGTYPE_IDENTITY', '25'),
('MODIFIER_SLTH_POLICY_CITY_STATES_ADJUST_WAR_WEARINESS', 'Overall', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_CITY_STATES_ADD_CULTUREYIELD', 'Amount', 'ARGTYPE_IDENTITY', '-20'),
('MODIFIER_SLTH_POLICY_CITY_STATES_ADD_CULTUREYIELD', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_CULTURE'),
('MODIFIER_SLTH_POLICY_GOD_KING_ADD_PRODUCTIONYIELD', 'Amount', 'ARGTYPE_IDENTITY', '50'),
('MODIFIER_SLTH_POLICY_GOD_KING_ADD_PRODUCTIONYIELD', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_PRODUCTION'),
('MODIFIER_SLTH_POLICY_GOD_KING_ADD_GOLDYIELD', 'Amount', 'ARGTYPE_IDENTITY', '50'),
('MODIFIER_SLTH_POLICY_GOD_KING_ADD_GOLDYIELD', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_GOLD'),
('MODIFIER_SLTH_POLICY_ARISTOCRACY_FARM_FOOD', 'Amount', 'ARGTYPE_IDENTITY', '-1'),
('MODIFIER_SLTH_POLICY_ARISTOCRACY_FARM_FOOD', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_FOOD'),
('MODIFIER_YieldType_FARM_GOLD', 'Amount', 'ARGTYPE_IDENTITY', '2'),
('MODIFIER_YieldType_FARM_GOLD', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_GOLD'),
('MODIFIER_REPUBLIC_INCREASE_GPP_MULT', 'Amount', 'ARGTYPE_IDENTITY', '25'),
('MODIFIER_SLTH_POLICY_REPUBLIC_ADD_CULTUREYIELD', 'Amount', 'ARGTYPE_IDENTITY', '20'),
('MODIFIER_SLTH_POLICY_REPUBLIC_ADD_CULTUREYIELD', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_CULTURE'),
('MODIFIER_SLTH_POLICY_RELIGION_ADD_CULTUREYIELD', 'Amount', 'ARGTYPE_IDENTITY', '10'),
('MODIFIER_SLTH_POLICY_RELIGION_ADD_CULTUREYIELD', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_CULTURE'),
('MODIFIER_SLTH_POLICY_RELIGION_BUILDING_TEMPLE_OF_KILMORPH_ADD_AMENITIES', 'SLTH_POLICY_RELIGION', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_RELIGION_BUILDING_TEMPLE_OF_LEAVES_ADD_AMENITIES', 'SLTH_POLICY_RELIGION', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_RELIGION_BUILDING_TEMPLE_OF_THE_ORDER_ADD_AMENITIES', 'SLTH_POLICY_RELIGION', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_RELIGION_BUILDING_TEMPLE_OF_THE_OVERLORDS_ADD_AMENITIES', 'SLTH_POLICY_RELIGION', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_RELIGION_BUILDING_TEMPLE_OF_THE_VEIL_ADD_AMENITIES', 'SLTH_POLICY_RELIGION', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_RELIGION_BUILDING_TEMPLE_OF_THE_EMPYREAN_ADD_AMENITIES', 'SLTH_POLICY_RELIGION', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_PACIFISM_INCREASE_GPP_MULT', 'Amount', 'ARGTYPE_IDENTITY', '50'),
('MODIFIER_SLTH_POLICY_PACIFISM_MILITARY_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '-20'),
('MODIFIER_SLTH_POLICY_PACIFISM_ADJUST_WAR_WEARINESS', 'Amount', 'ARGTYPE_IDENTITY', '25'),
('MODIFIER_SLTH_POLICY_PACIFISM_ADJUST_WAR_WEARINESS', 'Overall', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_NATIONHOOD_MILITARY_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '10'),
('MODIFIER_SLTH_POLICY_NATIONHOOD_ADJUST_WAR_WEARINESS', 'Amount', 'ARGTYPE_IDENTITY', '-25'),
('MODIFIER_SLTH_POLICY_NATIONHOOD_ADJUST_WAR_WEARINESS', 'Overall', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_NATIONHOOD_BUILDING_TRAINING_YARD_ADD_AMENITIES', 'SLTH_POLICY_NATIONHOOD', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SACRIFICE_THE_WEAK_INCREASE_GPP_MULT', 'Amount', 'ARGTYPE_IDENTITY', '-20'),
('MODIFIER_SLTH_POLICY_SACRIFICE_THE_WEAK_ADJUST_HOUSING', 'Amount', 'ARGTYPE_IDENTITY', '-4'),
('MODIFIER_SLTH_POLICY_SACRIFICE_THE_WEAK_ADD_GOLDYIELD', 'Amount', 'ARGTYPE_IDENTITY', '10'),
('MODIFIER_SLTH_POLICY_SACRIFICE_THE_WEAK_ADD_GOLDYIELD', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_GOLD'),
('MODIFIER_SLTH_POLICY_SOCIAL_ORDER_BUILDING_COURTHOUSE_ADD_AMENITIES', 'SLTH_POLICY_SOCIAL_ORDER', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_SOCIAL_ORDER_BUILDING_BASILICA_ADD_AMENITIES', 'SLTH_POLICY_SOCIAL_ORDER', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_CONSUMPTION_ADD_GOLDYIELD', 'Amount', 'ARGTYPE_IDENTITY', '20'),
('MODIFIER_SLTH_POLICY_CONSUMPTION_ADD_GOLDYIELD', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_GOLD'),
('MODIFIER_SLTH_POLICY_CONSUMPTION_BUILDING_MARKET_ADD_AMENITIES', 'SLTH_POLICY_CONSUMPTION', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_CONSUMPTION_BUILDING_TAVERN_ADD_AMENITIES', 'SLTH_POLICY_CONSUMPTION', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_CONSUMPTION_BUILDING_THEATRE_ADD_AMENITIES', 'SLTH_POLICY_CONSUMPTION', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_SCHOLARSHIP_ADJUST_WAR_WEARINESS', 'Amount', 'ARGTYPE_IDENTITY', '20'),
('MODIFIER_SLTH_POLICY_SCHOLARSHIP_ADJUST_WAR_WEARINESS', 'Overall', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_SCHOLARSHIP_ADD_SCIENCEYIELD', 'Amount', 'ARGTYPE_IDENTITY', '10'),
('MODIFIER_SLTH_POLICY_SCHOLARSHIP_ADD_SCIENCEYIELD', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_SCIENCE'),
('MODIFIER_SLTH_POLICY_SCHOLARSHIP_BUILDING_LIBRARY_ADD_AMENITIES', 'SLTH_POLICY_SCHOLARSHIP', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_LIBERTY_ADJUST_WAR_WEARINESS', 'Amount', 'ARGTYPE_IDENTITY', '50'),
('MODIFIER_SLTH_POLICY_LIBERTY_ADJUST_WAR_WEARINESS', 'Overall', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_LIBERTY_ADD_CULTUREYIELD', 'Amount', 'ARGTYPE_IDENTITY', '100'),
('MODIFIER_SLTH_POLICY_LIBERTY_ADD_CULTUREYIELD', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_CULTURE'),
('MODIFIER_SLTH_POLICY_CRUSADE_ADJUST_WAR_WEARINESS', 'Amount', 'ARGTYPE_IDENTITY', '-75'),
('MODIFIER_SLTH_POLICY_CRUSADE_ADJUST_WAR_WEARINESS', 'Overall', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_APPRENTICESHIP_MILITARY_EXPERIENCE', 'Amount', 'ARGTYPE_IDENTITY', '-1'),
('MODIFIER_SLTH_POLICY_APPRENTICESHIP_MILITARY_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '-10'),
('MODIFIER_SLTH_POLICY_SLAVERY_QUARRY_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_SLAVERY_QUARRY_PRODUCTION', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_PRODUCTION'),
('MODIFIER_SLTH_POLICY_SLAVERY_SLAVE_TAKING_MODIFIER', 'CanCapture', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_SLAVERY_SLAVE_TAKING_MODIFIER', 'UnitType', 'ARGTYPE_IDENTITY', 'UNIT_SLAVE'),
('MODIFIER_SLTH_POLICY_SLAVERY_SLAVE_TAKING', 'ModifierId', 'ARGTYPE_IDENTITY', 'MODIFIER_SLTH_POLICY_SLAVERY_SLAVE_TAKING_MODIFIER'),
('MODIFIER_SLTH_POLICY_ARETE_MINE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_ARETE_MINE_PRODUCTION', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_PRODUCTION'),
('MODIFIER_SLTH_POLICY_MILITARY_STATE_MILITARY_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '15'),
('MODIFIER_SLTH_POLICY_MILITARY_STATE_ADD_CULTUREYIELD', 'Amount', 'ARGTYPE_IDENTITY', '-25'),
('MODIFIER_SLTH_POLICY_MILITARY_STATE_ADD_CULTUREYIELD', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_CULTURE'),
('MODIFIER_SLTH_POLICY_CASTE_SYSTEM_BUILD_CHARGES', 'Amount', 'ARGTYPE_IDENTITY', '2'),
('MODIFIER_SLTH_POLICY_AGRARIANISM_ADJUST_HOUSING', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_AGRARIANISM_FARM_FOOD', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_AGRARIANISM_FARM_FOOD', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_FOOD'),
('MODIFIER_YieldType_FARM_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '-1'),
('MODIFIER_YieldType_FARM_PRODUCTION', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_PRODUCTION'),
('MODIFIER_SLTH_POLICY_CONQUEST_MILITARY_EXPERIENCE', 'Amount', 'ARGTYPE_IDENTITY', '-1'),
('MODIFIER_SLTH_POLICY_MERCANTILISM_FOREIGN_TRADE_SET_TO_ZERO', 'YIELD_PRODUCTION, YIELD_FOOD, YIELD_SCIENCE, YIELD_CULTURE, YIELD_GOLD, YIELD_FAITH', 'YieldType', 'YIELD_PRODUCTION, YIELD_FOOD, YIELD_SCIENCE, YIELD_CULTURE, YIELD_GOLD, YIELD_FAITH'),
('MODIFIER_SLTH_POLICY_MERCANTILISM_FOREIGN_TRADE_SET_TO_ZERO', '-100, -100, -100, -100, -100, -100', 'Amount', '-100, -100, -100, -100, -100, -100'),
('MODIFIER_SLTH_POLICY_MERCANTILISM_ADD_GOLDYIELD', 'Amount', 'ARGTYPE_IDENTITY', '20'),
('MODIFIER_SLTH_POLICY_MERCANTILISM_ADD_GOLDYIELD', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_GOLD'),
('MODIFIER_SLTH_POLICY_MERCANTILISM_BUILDING_MARKET_ADD_AMENITIES', 'SLTH_POLICY_MERCANTILISM', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_FOREIGN_TRADE_ADJUST_TRADE_ROUTE_CAPACITY', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_FOREIGN_TRADE_ADD_GOLDYIELD', 'Amount', 'ARGTYPE_IDENTITY', '-10'),
('MODIFIER_SLTH_POLICY_FOREIGN_TRADE_ADD_GOLDYIELD', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_GOLD'),
('MODIFIER_SLTH_POLICY_FOREIGN_TRADE_ADD_CULTURE_YIELD', 'Amount', 'ARGTYPE_IDENTITY', '20'),
('MODIFIER_SLTH_POLICY_FOREIGN_TRADE_ADD_CULTURE_YIELD', 'YieldType', 'ARGTYPE_IDENTITY', 'YIELD_CULTURE'),
('MODIFIER_SLTH_POLICY_FOREIGN_TRADE_ADJUST_TRADE_ROUTE_CAPACITY_COASTAL_PER_CITY', 'Amount', 'ARGTYPE_IDENTITY', '1'),
('MODIFIER_SLTH_POLICY_FOREIGN_TRADE_ADJUST_TRADE_ROUTE_CAPACITY_COASTAL', 'ModifierId', 'ARGTYPE_IDENTITY', 'MODIFIER_SLTH_POLICY_FOREIGN_TRADE_ADJUST_TRADE_ROUTE_CAPACITY_COASTAL_PER_CITY'),
('MODIFIER_SLTH_POLICY_GUARDIAN_OF_NATURE_ADJUST_HOUSING', 'Amount', 'ARGTYPE_IDENTITY', '5'),
('MODIFIER_SLTH_POLICY_GUARDIAN_OF_NATURE_MILITARY_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '-10'),
('MODIFIER_SLTH_POLICY_GUARDIAN_OF_NATURE_BUILDING_GROVE_ADD_AMENITIES', 'SLTH_POLICY_GUARDIAN_OF_NATURE', 'ARGTYPE_IDENTITY', '2');
INSERT INTO Requirements(RequirementId, RequirementType, ProgressWeight) VALUES
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_KILMORPH', 'REQUIREMENT_CITY_HAS_BUILDING', '0'),
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_LEAVES', 'REQUIREMENT_CITY_HAS_BUILDING', '0'),
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_ORDER', 'REQUIREMENT_CITY_HAS_BUILDING', '0'),
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_OVERLORDS', 'REQUIREMENT_CITY_HAS_BUILDING', '0'),
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_VEIL', 'REQUIREMENT_CITY_HAS_BUILDING', '0'),
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_EMPYREAN', 'REQUIREMENT_CITY_HAS_BUILDING', '0'),
('SLTH_REQUIRES_CITY_HAS_TRAINING_YARD', 'REQUIREMENT_CITY_HAS_BUILDING', '0'),
('SLTH_REQUIRES_CITY_HAS_COURTHOUSE', 'REQUIREMENT_CITY_HAS_BUILDING', '0'),
('SLTH_REQUIRES_CITY_HAS_BASILICA', 'REQUIREMENT_CITY_HAS_BUILDING', '0'),
('SLTH_REQUIRES_CITY_HAS_MARKET', 'REQUIREMENT_CITY_HAS_BUILDING', '0'),
('SLTH_REQUIRES_CITY_HAS_TAVERN', 'REQUIREMENT_CITY_HAS_BUILDING', '0'),
('SLTH_REQUIRES_CITY_HAS_THEATRE', 'REQUIREMENT_CITY_HAS_BUILDING', '0'),
('SLTH_REQUIRES_CITY_HAS_LIBRARY', 'REQUIREMENT_CITY_HAS_BUILDING', '0'),
('SLTH_REQUIRES_CITY_HAS_GROVE', 'REQUIREMENT_CITY_HAS_BUILDING', '0');
INSERT INTO RequirementArguments(RequirementId, Name, Type, Value) VALUES
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_KILMORPH', 'BuildingType', 'ARGTYPE_IDENTITY', 'BUILDING_TEMPLE_OF_KILMORPH'),
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_LEAVES', 'BuildingType', 'ARGTYPE_IDENTITY', 'BUILDING_TEMPLE_OF_LEAVES'),
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_ORDER', 'BuildingType', 'ARGTYPE_IDENTITY', 'BUILDING_TEMPLE_OF_THE_ORDER'),
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_OVERLORDS', 'BuildingType', 'ARGTYPE_IDENTITY', 'BUILDING_TEMPLE_OF_THE_OVERLORDS'),
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_VEIL', 'BuildingType', 'ARGTYPE_IDENTITY', 'BUILDING_TEMPLE_OF_THE_VEIL'),
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_EMPYREAN', 'BuildingType', 'ARGTYPE_IDENTITY', 'BUILDING_TEMPLE_OF_THE_EMPYREAN'),
('SLTH_REQUIRES_CITY_HAS_TRAINING_YARD', 'BuildingType', 'ARGTYPE_IDENTITY', 'BUILDING_TRAINING_YARD'),
('SLTH_REQUIRES_CITY_HAS_COURTHOUSE', 'BuildingType', 'ARGTYPE_IDENTITY', 'BUILDING_COURTHOUSE'),
('SLTH_REQUIRES_CITY_HAS_BASILICA', 'BuildingType', 'ARGTYPE_IDENTITY', 'BUILDING_BASILICA'),
('SLTH_REQUIRES_CITY_HAS_MARKET', 'BuildingType', 'ARGTYPE_IDENTITY', 'BUILDING_MARKET'),
('SLTH_REQUIRES_CITY_HAS_TAVERN', 'BuildingType', 'ARGTYPE_IDENTITY', 'BUILDING_TAVERN'),
('SLTH_REQUIRES_CITY_HAS_THEATRE', 'BuildingType', 'ARGTYPE_IDENTITY', 'BUILDING_THEATRE'),
('SLTH_REQUIRES_CITY_HAS_LIBRARY', 'BuildingType', 'ARGTYPE_IDENTITY', 'BUILDING_LIBRARY'),
('SLTH_REQUIRES_CITY_HAS_GROVE', 'BuildingType', 'ARGTYPE_IDENTITY', 'BUILDING_GROVE');
INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_KILMORPH', 'SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_KILMORPH'),
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_LEAVES', 'SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_LEAVES'),
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_ORDER', 'SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_ORDER'),
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_OVERLORDS', 'SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_OVERLORDS'),
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_VEIL', 'SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_VEIL'),
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_EMPYREAN', 'SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_EMPYREAN'),
('SLTH_REQUIRES_CITY_HAS_TRAINING_YARD', 'SLTH_REQUIRES_CITY_HAS_TRAINING_YARD'),
('SLTH_REQUIRES_CITY_HAS_COURTHOUSE', 'SLTH_REQUIRES_CITY_HAS_COURTHOUSE'),
('SLTH_REQUIRES_CITY_HAS_BASILICA', 'SLTH_REQUIRES_CITY_HAS_BASILICA'),
('SLTH_REQUIRES_CITY_HAS_MARKET', 'SLTH_REQUIRES_CITY_HAS_MARKET'),
('SLTH_REQUIRES_CITY_HAS_TAVERN', 'SLTH_REQUIRES_CITY_HAS_TAVERN'),
('SLTH_REQUIRES_CITY_HAS_THEATRE', 'SLTH_REQUIRES_CITY_HAS_THEATRE'),
('SLTH_REQUIRES_CITY_HAS_LIBRARY', 'SLTH_REQUIRES_CITY_HAS_LIBRARY'),
('SLTH_REQUIRES_CITY_HAS_GROVE', 'SLTH_REQUIRES_CITY_HAS_GROVE');
INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_KILMORPH', 'REQUIREMENTSET_TEST_ALL'),
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_LEAVES', 'REQUIREMENTSET_TEST_ALL'),
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_ORDER', 'REQUIREMENTSET_TEST_ALL'),
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_OVERLORDS', 'REQUIREMENTSET_TEST_ALL'),
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_VEIL', 'REQUIREMENTSET_TEST_ALL'),
('SLTH_REQUIRES_CITY_HAS_TEMPLE_OF_THE_EMPYREAN', 'REQUIREMENTSET_TEST_ALL'),
('SLTH_REQUIRES_CITY_HAS_TRAINING_YARD', 'REQUIREMENTSET_TEST_ALL'),
('SLTH_REQUIRES_CITY_HAS_COURTHOUSE', 'REQUIREMENTSET_TEST_ALL'),
('SLTH_REQUIRES_CITY_HAS_BASILICA', 'REQUIREMENTSET_TEST_ALL'),
('SLTH_REQUIRES_CITY_HAS_MARKET', 'REQUIREMENTSET_TEST_ALL'),
('SLTH_REQUIRES_CITY_HAS_TAVERN', 'REQUIREMENTSET_TEST_ALL'),
('SLTH_REQUIRES_CITY_HAS_THEATRE', 'REQUIREMENTSET_TEST_ALL'),
('SLTH_REQUIRES_CITY_HAS_LIBRARY', 'REQUIREMENTSET_TEST_ALL'),
('SLTH_REQUIRES_CITY_HAS_GROVE', 'REQUIREMENTSET_TEST_ALL');

-- ability experience granters

INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
('ATTACH_CITIES_APPRENTICESHIP_POLICY', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER'),
('ATTACH_CITIES_CONQUEST_POLICY', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER'),
('ATTACH_CITIES_THEOCRACY_POLICY', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER');

INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('ATTACH_CITIES_APPRENTICESHIP_POLICY', 'ModifierId', 'ARGTYPE_IDENTITY', 'GRANT_EXPERIENCE_ABILITY_SMALL_APPRENTICESHIP'),
('ATTACH_CITIES_CONQUEST_POLICY', 'ModifierId', 'ARGTYPE_IDENTITY', 'GRANT_EXPERIENCE_ABILITY_SMALL_CONQUEST'),
('ATTACH_CITIES_THEOCRACY_POLICY', 'ModifierId', 'ARGTYPE_IDENTITY', 'GRANT_EXPERIENCE_ABILITY_SMALL_THEOCRACY');

INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, SubjectRequirementSetId) VALUES
('GRANT_EXPERIENCE_ABILITY_SMALL_APPRENTICESHIP', 'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS', '0', '0', NULL),
('GRANT_EXPERIENCE_ABILITY_SMALL_CONQUEST', 'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS', '0', '0', NULL),
('GRANT_EXPERIENCE_ABILITY_SMALL_THEOCRACY', 'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS', '0', '0', NULL);

INSERT INTO ModifierArguments(ModifierId, Name, Type, Value) VALUES
('GRANT_EXPERIENCE_ABILITY_SMALL_APPRENTICESHIP', 'AbilityType', 'ARGTYPE_IDENTITY', 'GRANT_EXPERIENCE_SMALL_ABILITY_APPRENTICESHIP'),
('GRANT_EXPERIENCE_ABILITY_SMALL_CONQUEST', 'AbilityType', 'ARGTYPE_IDENTITY', 'GRANT_EXPERIENCE_SMALL_ABILITY_CONQUEST'),
('GRANT_EXPERIENCE_ABILITY_SMALL_THEOCRACY', 'AbilityType', 'ARGTYPE_IDENTITY', 'GRANT_EXPERIENCE_SMALL_ABILITY_THEOCRACY');


INSERT INTO UnitAbilities(UnitAbilityType, Name, Description, Inactive, Permanent) VALUES
('GRANT_EXPERIENCE_SMALL_ABILITY_APPRENTICESHIP', 'LOC_GRANT_EXPERIENCE_ABILITY_NAME', 'LOC_GRANT_EXPERIENCE_ABILITY_DESCRIPTION', '1', '1'),
('GRANT_EXPERIENCE_SMALL_ABILITY_CONQUEST', 'LOC_GRANT_EXPERIENCE_ABILITY_NAME', 'LOC_GRANT_EXPERIENCE_ABILITY_DESCRIPTION', '1', '1'),
('GRANT_EXPERIENCE_SMALL_ABILITY_THEOCRACY', 'LOC_GRANT_EXPERIENCE_ABILITY_NAME', 'LOC_GRANT_EXPERIENCE_ABILITY_DESCRIPTION', '1', '1');

INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES
('GRANT_EXPERIENCE_SMALL_ABILITY_APPRENTICESHIP', 'GRANT_EXPERIENCE_SMALL'),
('GRANT_EXPERIENCE_SMALL_ABILITY_CONQUEST', 'GRANT_EXPERIENCE_SMALL'),
('GRANT_EXPERIENCE_SMALL_ABILITY_THEOCRACY', 'GRANT_EXPERIENCE_SMALL');


INSERT INTO TypeTags(Type, Tag) VALUES
('GRANT_EXPERIENCE_SMALL_ABILITY_APPRENTICESHIP', 'CLASS_ALL_UNITS'),
('GRANT_EXPERIENCE_SMALL_ABILITY_CONQUEST', 'CLASS_ALL_UNITS'),
('GRANT_EXPERIENCE_SMALL_ABILITY_THEOCRACY', 'CLASS_ALL_UNITS');

-- Policy banning

INSERT INTO DynamicModifiers(ModifierType, CollectionType, EffectType) VALUES
('MODIFIER_BAN_POLICY_OWNER', 'COLLECTION_OWNER', 'EFFECT_ADJUST_PLAYER_BAN_POLICY');

INSERT INTO Types(Type, Kind) VALUES
('MODIFIER_BAN_POLICY_OWNER', 'KIND_MODIFIER');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('TRAIT_LEADER_MAJOR_CIV', 'BAN_SACRIFICE_THE_WEAK'),
('TRAIT_LEADER_MAJOR_CIV', 'BAN_GUARDIAN_OF_NATURE'),
('TRAIT_LEADER_MAJOR_CIV', 'BAN_ARETE'),
('TRAIT_LEADER_MAJOR_CIV', 'BAN_SOCIAL_ORDER');

INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
('BAN_SACRIFICE_THE_WEAK', 'MODIFIER_BAN_POLICY_OWNER'),
('BAN_GUARDIAN_OF_NATURE', 'MODIFIER_BAN_POLICY_OWNER'),
('BAN_ARETE', 'MODIFIER_BAN_POLICY_OWNER'),
('BAN_SOCIAL_ORDER', 'MODIFIER_BAN_POLICY_OWNER');

INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES
('BAN_CRUSADE', 'MODIFIER_BAN_POLICY_OWNER', 'BANNOR_REQUIREMENTS');

INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
('BAN_SACRIFICE_THE_WEAK', 'PolicyType', 'SLTH_POLICY_SACRIFICE_THE_WEAK'),
('BAN_GUARDIAN_OF_NATURE', 'PolicyType', 'SLTH_POLICY_GUARDIAN_OF_NATURE'),
('BAN_ARETE', 'PolicyType', 'SLTH_POLICY_ARETE'),
('BAN_SOCIAL_ORDER', 'PolicyType', 'SLTH_POLICY_SOCIAL_ORDER'),
('BAN_CRUSADE', 'PolicyType', 'SLTH_POLICY_CRUSADE');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
('TRAIT_LEADER_MAJOR_CIV', 'BAN_CRUSADE');

INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES ('BANNOR_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES ('BANNOR_REQUIREMENTS', 'PLAYER_IS_BANNOR');
INSERT INTO Requirements(RequirementId, RequirementType, Inverse) VALUES ('PLAYER_IS_BANNOR', 'REQUIREMENT_PLAYER_TYPE_MATCHES', '1');
INSERT INTO RequirementArguments(RequirementId, Name, "Value") VALUES ('PLAYER_IS_BANNOR', 'CivilizationType', 'SLTH_CIVILIZATION_BANNOR');


INSERT INTO Types(Type, Kind) VALUES
('GRANT_EXPERIENCE_SMALL_ABILITY_APPRENTICESHIP', 'KIND_ABILITY'),
('GRANT_EXPERIENCE_SMALL_ABILITY_CONQUEST', 'KIND_ABILITY'),
('GRANT_EXPERIENCE_SMALL_ABILITY_THEOCRACY', 'KIND_ABILITY');

INSERT INTO Types(Type, Kind) VALUES
('SLTH_POLICY_DESPOTISM', 'KIND_POLICY'),
('SLTH_POLICY_CITY_STATES', 'KIND_POLICY'),
('SLTH_POLICY_GOD_KING', 'KIND_POLICY'),
('SLTH_POLICY_ARISTOCRACY', 'KIND_POLICY'),
('SLTH_POLICY_THEOCRACY', 'KIND_POLICY'),
('SLTH_POLICY_REPUBLIC', 'KIND_POLICY'),
('SLTH_POLICY_RELIGION', 'KIND_POLICY'),
('SLTH_POLICY_PACIFISM', 'KIND_POLICY'),
('SLTH_POLICY_NATIONHOOD', 'KIND_POLICY'),
('SLTH_POLICY_SACRIFICE_THE_WEAK', 'KIND_POLICY'),
('SLTH_POLICY_SOCIAL_ORDER', 'KIND_POLICY'),
('SLTH_POLICY_CONSUMPTION', 'KIND_POLICY'),
('SLTH_POLICY_SCHOLARSHIP', 'KIND_POLICY'),
('SLTH_POLICY_LIBERTY', 'KIND_POLICY'),
('SLTH_POLICY_CRUSADE', 'KIND_POLICY'),
('SLTH_POLICY_TRIBALISM', 'KIND_POLICY'),
('SLTH_POLICY_APPRENTICESHIP', 'KIND_POLICY'),
('SLTH_POLICY_SLAVERY', 'KIND_POLICY'),
('SLTH_POLICY_ARETE', 'KIND_POLICY'),
('SLTH_POLICY_MILITARY_STATE', 'KIND_POLICY'),
('SLTH_POLICY_CASTE_SYSTEM', 'KIND_POLICY'),
('SLTH_POLICY_GUILDS', 'KIND_POLICY'),
('SLTH_POLICY_DECENTRALIZATION', 'KIND_POLICY'),
('SLTH_POLICY_AGRARIANISM', 'KIND_POLICY'),
('SLTH_POLICY_CONQUEST', 'KIND_POLICY'),
('SLTH_POLICY_MERCANTILISM', 'KIND_POLICY'),
('SLTH_POLICY_FOREIGN_TRADE', 'KIND_POLICY'),
('SLTH_POLICY_GUARDIAN_OF_NATURE', 'KIND_POLICY');

UPDATE Policies SET PrereqCivic = 'CIVIC_CODE_OF_LAWS' WHERE PolicyType in ('SLTH_POLICY_DESPOTISM',
                                                                            'SLTH_POLICY_RELIGION',
                                                                            'SLTH_POLICY_PACIFISM',
                                                                           'SLTH_POLICY_NATIONHOOD',
                                                                           'SLTH_POLICY_TRIBALISM',
                                                                           'SLTH_POLICY_DECENTRALIZATION');
-- just for fast debugging
