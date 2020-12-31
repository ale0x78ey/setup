#!/bin/bash

# brew/install.sh

brew install rbenv
brew install ruby-build

# Set up rbenv integration with your shell
rbenv init

# Check your installation
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

rbenv install 2.7.1
rbenv global 2.7.1
ruby -v

# Runs `rbenv rehash` every time
# you install or uninstall a gem
# or use bundler instead.
