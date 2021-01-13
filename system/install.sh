#!/bin/bash
set -x

source common/install.sh
install_setup

if [[ "`uname -s`" == "Linux" ]]; then
  install openssh-server
fi
