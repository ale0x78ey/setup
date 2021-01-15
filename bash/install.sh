#!/bin/bash
set -x

source common/install.sh
install_setup

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"

if [[ "`uname -s`" == "Linux" ]]; then
  install locales
  sudo localedef -i en_US -f UTF-8 en_US.UTF-8
fi

TARGETS="\
bash_aliases
bash_profile
bashrc
inputrc
"

for i in $TARGETS
do
  install_ln ${SCRIPT_DIR}/$i ~/.$i
done
