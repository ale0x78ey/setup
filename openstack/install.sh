#!/bin/bash
set -x

. python/install.sh

python3 -m pip install --user 'ansible<2.10'
python3 -m pip install --user kolla-ansible

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"

if [[ `which kolla-ansible` ]]; then
  KOLLA_ETC_EXAMPLES="$(dirname $(dirname `which kolla-ansible`))"
  KOLLA_ETC_EXAMPLES=${KOLLA_ETC_EXAMPLES}/share/kolla-ansible/etc_examples/kolla
  sudo mkdir -p /etc/kolla
  sudo chown $USER:$USER /etc/kolla

  for i in globals.yml passwords.yml
  do
    if [ -e /etc/kolla/$i ]; then continue; fi
    cp ${KOLLA_ETC_EXAMPLES}/$i /etc/kolla/
  done

  # Fill blank passwords.
  kolla-genpwd
fi

if [[ `which ansible` ]]; then
  sudo mkdir -p /etc/ansible
  sudo chown $USER:$USER /etc/ansible
  install_ln ${SCRIPT_DIR}/ansible/ansible.cfg /etc/ansible/ansible.cfg

  ansible-playbook -i ansible-inventories/openstack/ \
                   -u root --private-key ~/.ssh/id_rsa \
                   ${SCRIPT_DIR}/setup_network.yml
fi
