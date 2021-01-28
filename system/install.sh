#!/bin/bash
set -x

source common/install.sh
install_setup

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"

if [[ "`uname -s`" == "Linux" ]]; then
  install openssh-server
fi

if [ ! -e ~/.ssh/config ]; then
  cp ${SCRIPT_DIR}/ssh/config ~/.ssh/config
fi

chmod 644 ~/.ssh/config
