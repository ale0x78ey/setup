export HOMEBREW_NO_AUTO_UPDATE=1

darwin_install_brew() {
  :
}

brew_update() {
    brew update
}

# $1 - program name
# $2 - flags
brew_install() {
  if [[ ! "`brew list --formula | grep $1`" ]]; then
    brew install $1 $2
  fi
}
