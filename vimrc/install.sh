#!/bin/bash
set -x

source common/install.sh
install_setup

install curl   \
        flake8 \
        pylint \
        vim

if [[ "`uname -s`" == "Darwin" ]]; then
  brew tap universal-ctags/universal-ctags
  brew_install universal-ctags --with-jansson --HEAD
  install the_silver_searche yapf
fi

if [[ "`uname -s`" == "Linux" ]]; then
  install_git_repo https://github.com/universal-ctags/ctags.git
  install silversearcher-ag \
          yapf3

  BUILD_DIR=`mktemp -d -t $(date +%Y-%m-%d-%H-%M-%S)-XXXXXXXXX`
  mkdir -p ${BUILD_DIR}
  pushd ${BUILD_DIR}
  git clone https://github.com/universal-ctags/ctags.git && cd ctags
  ./autogen.sh
  ./configure
  make
  sudo checkinstall -y
  # To remove it: sudo dpkg --purge ctags
  popd
  sudo rm -rf $TEMP_DIR
fi

rm -rf ~/.vim && curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"
ln -sfv ${SCRIPT_DIR}/vimrc ~/.vimrc

vim +PlugInstall +quitall
