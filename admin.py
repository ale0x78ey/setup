import argparse
from argparse import Namespace
from functools import partial
import logging
import sys
from typing import List

import myenv as my


def init_logging(options: Namespace) -> None:
    logging.basicConfig(level=logging.INFO)


def main(args: List[str]) -> None:
    parser = argparse.ArgumentParser()
    my.bootstrap.init_parser(parser)
    api = parser.add_subparsers(dest='api')
    openstack_parser = api.add_parser('openstack')
    my.openstack.init_parser(openstack_parser)
    system_parser = api.add_parser('system')
    my.system.init_parser(system_parser)

    options = parser.parse_args(args)
    api_functions = {
        'openstack': partial(my.openstack.main, options),
        'system': partial(my.system.main, options),
    }

    init_logging(options)

    api_func = api_functions.get(options.api, parser.print_help)
    if api_func is not parser.print_help:
        my.bootstrap.main(options)

    api_func()


if __name__ == '__main__':
    main(sys.argv[1:])
