from argparse import ArgumentParser, Namespace
import logging
from pathlib import Path
import socket
import sys

import ansible_runner


logger = logging.getLogger(__file__)

HOSTNAME = socket.gethostname()
INVENTORY_DIR = str(Path(__file__).parent.parent / 'inventories.d' / 'system')
PLAYBOOK_PATH = str(Path(__file__).parent.parent / 'playbooks' / 'system.yml')


def init_parser(parser: ArgumentParser) -> None:
    parser.add_argument(
        '--hosts', dest='hosts', default=[HOSTNAME], metavar='HOSTNAME',
        nargs='*',
        help='target hosts (default: {})'.format(HOSTNAME))

    parser.add_argument(
        '--inventory', '-i', dest='inventory',
        default=INVENTORY_DIR, metavar='PATH',
        help='ansible inventory file or directory '
             '(default: {})'.format(INVENTORY_DIR))


def setup_system(options: Namespace) -> None:
    logger.info('system.setup_system')

    extra_vars = [
        'myenv_hosts={}'.format(':'.join(options.hosts)),
        'setup_vim=yes',
    ]

    extra_envs = {
        # Make ansible transform invalid characters in group
        # names supplied by inventory sources. If 'never' it
        # will allow for the group name but warn about the
        # issue. When 'ignore', it does the same as 'never',
        # without issuing a warning. When 'always' it will
        # replace any invalid characters with '_' and warn
        # the user. When 'silently', it does the same as 'always',
        # without issuing a warning.
        'ANSIBLE_TRANSFORM_INVALID_GROUP_CHARS': 'ignore',
    }

    ansible_runner.run_command(
        executable_cmd='ansible-playbook',
        cmdline_args=[PLAYBOOK_PATH,
                      '-i', options.inventory,
                      '-e', '"{}"'.format(' '.join(extra_vars))],
        envvars=extra_envs,
        input_fd=sys.stdin, output_fd=sys.stdout, error_fd=sys.stderr)


def main(options: Namespace) -> None:
    setup_system(options)
