from argparse import ArgumentParser, Namespace
import logging
from pathlib import Path
import socket
import sys

import ansible_runner


logger = logging.getLogger(__file__)

HOSTNAME = socket.gethostname()
PROJECT_DIR = Path(__file__).parent.parent
INVENTORY_DIR = str(PROJECT_DIR / 'inventories.d' / 'openstack')
PLAYBOOK_PATH = str(PROJECT_DIR / 'playbooks' / 'openstack.yml')


def init_parser(parser: ArgumentParser) -> None:
    parser.add_argument(
        '--release', '-r', dest='openstack_release', required=True,
        choices=['train', 'victoria'],
        help='openstack release name')

    parser.add_argument(
        '--docker-registry-hostname', dest='docker_registry_hostname',
        default=HOSTNAME, metavar='HOSTNAME',
        help='hostname where docker registry will be installed '
             '(default: {})'.format(HOSTNAME))

    parser.add_argument(
        '--kolla-deploy-hostname', dest='kolla_deploy_hostname',
        default=HOSTNAME, metavar='HOSTNAME',
        help='hostname where kolla will be installed '
             '(default: {})'.format(HOSTNAME))

    parser.add_argument(
        '--inventory', '-i', dest='inventory',
        default=INVENTORY_DIR, metavar='PATH',
        help='ansible inventory file or directory '
             '(default: {})'.format(INVENTORY_DIR))


def setup_openstack(options: Namespace) -> None:
    logger.info('openstack.setup_openstack')

    extra_vars = [
        f'myenv_openstack_release={options.openstack_release}',
        f'myenv_docker_registry_hostname={options.docker_registry_hostname}',
        f'myenv_kolla_deploy_hostname={options.kolla_deploy_hostname}',
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
    setup_openstack(options)
