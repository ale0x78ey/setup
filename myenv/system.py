from argparse import ArgumentParser, Namespace
import logging
from pathlib import Path
import socket
import sys


logger = logging.getLogger(__file__)

HOSTNAME = socket.gethostname()
INVENTORY_DIR = str(Path(__file__).parent.parent / 'inventories.d' / 'system')
PLAYBOOK_PATH = str(Path(__file__).parent.parent / 'playbooks' / 'system.yml')


def init_parser(parser: ArgumentParser) -> None:
    pass


def main(options: Namespace) -> None:
    logger.info('system.main')
