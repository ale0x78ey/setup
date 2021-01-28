#!/bin/bash

export EXTRA_OPTS="--private-key ~/.ssh/id_rsa -u root"

# kolla-ansible -i ansible-inventories.d/ bootstrap-servers
# kolla-ansible -i ansible-inventories.d/ prechecks
kolla-ansible -i ansible-inventories.d/ deploy
