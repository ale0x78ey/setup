brew_setup() {
  if [[ ! `which brew` ]]; then
    INSTALL_URL=https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
    /bin/bash -c "$(curl -fsSL ${INSTALL_URL})"
  fi

  export HOMEBREW_NO_AUTO_UPDATE=1

  brew update
  install gnu-tar
}

brew_update() {
  brew update
}

brew_install() {
  if [[ ! "`brew list --formula | grep $1`" ]]; then
    brew install $@
  fi
}
