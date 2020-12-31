#!/bin/bash
set -e

OS_NAME="`uname -s`"

if [[ $OS_NAME == "Darwin" ]]; then
    if [[ ! `which brew` ]]; then
        echo "install brew..." && curl -fsSL \
            https://raw.githubusercontent.com/Homebrew/install/master/install.sh
    fi

    echo "install docker and docker utils..."
    brew update && brew install docker docker-compose docker-machine

    echo "install virtualbox..."
    brew cask install virtualbox

    if [[ ! `docker-machine ls -q` ]]; then
        docker-machine create --driver virtualbox default
    fi

    # docker-machine restart default && eval `docker-machine env default`
    brew cask install docker

    #!!! add user to 'docker' group

elif [ $OS_NAME == "Linux" ]; then
    echo "install docker and docker-compose..."
    sudo apt-get update && sudo apt-get install -y docker docker-compose

else
    echo "unsupported system $OS_NAME"
    exit -1
fi

