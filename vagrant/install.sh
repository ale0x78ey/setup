#!/bin/bash

VERSION="2.2.6"
f="vagrant\_${VERSION}\_x86\_64.deb"
wget https://releases.hashicorp.com/vagrant/${VERSION}/$f
sudo dpkg -i $f && rm -f $f
sudo apt update && sudo apt -f install

# https://github.com/vagrant-libvirt/vagrant-libvirt
