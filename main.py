from civilizations import Civilizations
from units import Units
from techs import techs_sql, prereq_techs
from buildings import Buildings, districts_build
from delete_n_patch import delete_rows
from misc import build_resource_string, build_terrains_string, build_features_string, build_policies, build_improvements
from promotions import Promotions
from modifiers import Modifiers
from utils import Sql, setup_tables, make_or_add, update_sql_table
from localiser import Localizer, custom_loc
from db_checker import check_primary_keys, localize_check
from prebuilt_transfer import main as prebuilt_transfer
from artdef_wrangler import Artdef
from leader_art import make_colors

import json
import logging


def main():
    logging.basicConfig(level=logging.WARNING)
    setup_tables()
    civs = ['AMURITES', 'BALSERAPHS', 'BANNOR', 'CALABIM', 'CLAN_OF_EMBERS', 'DOVIELLO', 'ELOHIM', 'GRIGORI', 'HIPPUS',
            'ILLIANS', 'INFERNAL', 'KHAZAD', 'KURIOTATES', 'LANUN', 'LJOSALFAR', 'LUCHUIRP', 'MALAKIM', 'MERCURIANS',
            'SHEAIM', 'SIDAR', 'SVARTALFAR', 'BARBARIAN']

    with open("data/kept.json", 'r') as json_file:
        kept = json.load(json_file)
    model_obj = {'kinds': {}, 'traits': {}, 'sql_strings': [], 'sql_inserts': {}, 'sql_updates': {}, 'sql_config': {},
                 'civilizations': Civilizations(), 'modifiers': Modifiers(), 'sql': Sql(), 'units': Units(),
                 'select_civs': civs, 'loc': {}, 'updates': {}, 'deletes': {}, 'sql_deletes': {}, 'tags': {}}
    make_colors(model_obj)
    artdef = Artdef().do_artdef()
    # prebuilt_transfer()


if __name__ == "__main__":
    main()
