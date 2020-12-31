#!/bin/bash

sudo apt update && sudo apt install -y \
  dict                                 \
  dictd                                \
  dictfmt                              \
  espeak-ng                            \
  libxml-libxml-perl                   \
  libicu-dev                           \
  libxml-libxslt-perl                  \
  make                                 \
  pkg-config                           \
  python3                              \
  python3-dev                          \
  python3-icu                          \
  python3-virtualenv                   \
  unzip                                \
  virtualenv                           \
  xsltproc

git clone https://github.com/freedict/tools
mv tools freedict-tools
cd freedict-tools
export FREEDICT_TOOLS=`pwd`
make mk_env
cd ../

git clone https://github.com/freedict/fd-dictionaries.git
cd fd-dictionaries
export FREEDICT_TOOLS=`pwd`/../freedict-tools

make

sudo cp eng-fra/build/dictd/* /usr/share/dictd/
sudo cp fra-eng/build/dictd/* /usr/share/dictd/
sudo cp eng-rus/build/dictd/* /usr/share/dictd/

sudo dictdconfig -w
sudo dictd
dict -I -D
