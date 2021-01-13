#!/bin/bash
set -x

source common/install.sh
install_setup

install tmux

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"
install_ln ${SCRIPT_DIR}/tmux.conf ~/.tmux.conf