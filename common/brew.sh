export HOMEBREW_NO_AUTO_UPDATE=1

darwin_install_brew() {
  if [[ ! `which brew` ]]; then
    INSTALL_URL=https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
    /bin/bash -c "$(curl -fsSL ${INSTALL_URL})"
  fi
}

brew_update() {
  brew update
}

brew_install() {
  if [[ ! "`brew list --formula | grep $1`" ]]; then
    brew install $@
  fi
}
