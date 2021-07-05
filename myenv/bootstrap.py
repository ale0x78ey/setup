from argparse import ArgumentParser, Namespace
import logging
import platform


logger = logging.getLogger(__file__)


def init_parser(parser: ArgumentParser) -> None:
    pass


def init_linux(options: Namespace) -> None:
    logger.info('bootstrap.init_linux')


def init_macos(options: Namespace) -> None:
    logger.info('bootstrap.init_macos')


def _do_nothing(*args, **kwargs) -> None:
    pass


def main(options: Namespace) -> None:
    init_functions = {
        'Linux': init_linux, 'Darwin': init_macos
    }

    system = platform.system()
    init_func = init_functions.get(system, _do_nothing)
    init_func(options)
