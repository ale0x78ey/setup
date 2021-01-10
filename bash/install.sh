#!/bin/bash
set -x

source common/install.sh
install_setup

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"

TARGETS="\
bash_aliases
bash_profile
bashrc
inputrc
tmux.conf
"

for i in $TARGETS
do
  install_ln ${SCRIPT_DIR}/$i ~/.$i
done
