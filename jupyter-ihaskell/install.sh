#!/bin/bash

sudo apt-get update && sudo apt-get install -y \
  build-essential                              \
  dkms                                         \
  linux-headers-$(uname -r)

sudo apt-get install -y \
  git                   \
  gcc                   \
  g++                   \
  libblas-dev           \
  libcairo2-dev         \
  libgmp-dev            \
  liblapack-dev         \
  libmagic-dev          \
  libpango1.0-dev       \
  libtinfo-dev          \
  libzmq3-dev           \
  python3-pip

# https://github.com/gibiansky/IHaskell
