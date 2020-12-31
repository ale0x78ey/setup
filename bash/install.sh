#!/bin/bash
set -ex

[ -e ~/.mydev ] && echo "It's already installed" && exit 0

check() {
  for p in "$@"
  do
    if [ -e ~/.${p}_old ]; then
      echo "~/.${p}_old already exists"
      exit -1
    fi
  done
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"

install() {
  for p in "$@"
  do
    if [ -e ~/.$p ]; then mv ~/.$p ~/.${p}_old; fi
    if [ -e ${SCRIPT_DIR}/$p ]; then ln -snfv ${SCRIPT_DIR}/$p ~/.$p; fi
  done
}

TARGETS=(bash_profile
         bashrc
         inputrc
         tmux.conf
)

check ${TARGETS[@]} && install ${TARGETS[@]}

touch ~/.mydev && echo "OK"
