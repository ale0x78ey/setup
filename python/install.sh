#!/bin/bash
set -x

source common/install.sh
install_setup

install curl \
        python3

if ! `python3 -m pip &>/dev/null`; then
  curl https://bootstrap.pypa.io/get-pip.py | python3 -
fi

if [[ "`uname -s`" == "Linux" ]]; then
  install python3-venv
fi

python3 -m pip install --user -U pip

#
# Remote debugging based on pdb.
#

# https://github.com/tamentis/rpdb
python3 -m pip install --user rpdb

install rlwrap telnet
# Ex: $ rlwrap telnet localhost 4444
