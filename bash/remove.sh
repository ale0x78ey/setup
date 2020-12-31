#!/bin/bash
set -ex

[ ! -e ~/.mydev ] && echo "It's not installed" && exit 0

restore() {
  for p in "$@"
  do
    if [ -L ~/$p ]; then rm -rf ~/$p; fi
    if [ -e ~/${p}_old ]; then rm -rf ~/$p && mv ~/${p}_old ~/$p; fi
  done
}

TARGETS=(.bash_profile
         .bashrc
         .inputrc
         .tmux.conf
)

restore ${TARGETS[@]}

rm ~/.mydev && echo "OK"
