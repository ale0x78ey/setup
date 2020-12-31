#!/bin/bash
set -e

# Install dependences.
if [[ "`uname -s`" == "Darwin" ]]; then
    # Vim.
    export HOMEBREW_NO_AUTO_UPDATE=1
    if [[ "$(brew list --formula | grep vim)" ]]; then
        brew upgrade vim
    else
        brew install vim
    fi

    # Flake8 is a wrapper around these tools: PyFlakes, pycodestyle,
    # Ned Batchelder’s McCabe script.
    if [[ "$(brew list --formula | grep flake8)" ]]; then
        brew upgrade flake8
    else
        brew install flake8
    fi

    # Pylint is a Python static code analysis tool
    # which looks for programming errors, helps enforcing
    # a coding standard, sniffs for code smells and offers
    # simple refactoring suggestions.
    if [[ "$(brew list --formula | grep pylint)" ]]; then
        brew upgrade pylint
    else
        brew install pylint
    fi

    # Google/YAPF is a formatter for Python that
    # is based off of 'clang-format', developed by Daniel Jasper.
    if [[ "$(brew list --formula | grep yapf)" ]]; then
        brew upgrade yapf
    else
        brew install yapf
    fi
else
    sudo apt-get install -y \
        autoconf            \
        autotools-dev       \
        checkinstall        \
        curl                \
        flake8              \
        git                 \
        pkg-config          \
        pylint              \
        vim                 \
        yapf3
fi

# Universal-ctags generates an index (tag) file
# of language objects found in source files for
# many popular programming languages.
if [[ "`uname -s`" == "Darwin" ]]; then
    brew tap universal-ctags/universal-ctags
    brew install --with-jansson --HEAD \
        universal-ctags/universal-ctags/universal-ctags
else
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

# The Silver Searcher is a code searching tool similar
# to ack, with a focus on speed.
if [[ "`uname -s`" == "Darwin" ]]; then
    if [[ "$(brew list --formula | grep the_silver_searcher)" ]]; then
        brew upgrade the_silver_searcher
    else
        brew install the_silver_searcher
    fi
else
    sudo apt-get install silversearcher-ag -y
fi

# Install vim plugins.
rm -rf ~/.vim && curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"
ln -sfv ${SCRIPT_DIR}/vimrc ~/.vimrc

vim +PlugInstall +PlugUpdate +quitall
