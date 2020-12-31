if [[ "`uname -s`" == "Darwin" ]]; then
  source common/brew.sh

  install_setup() {
    darwin_install_brew
    brew_update
    brew_install gnu-tar
  }

  install() {
    for n in $@; do brew_install $n; done
  }
fi

if [[ "`uname -s`" == "Linux" ]]; then
  if [[ `which apt-get` ]]; then
    source common/apt-get.sh

    install_setup() {
      apt_get_update
    }

    install() {
      for n in $@; do apt_get_install $n; done
    }
  fi
fi
