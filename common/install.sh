if [[ "`uname -s`" == "Darwin" ]]; then
  source common/brew.sh

  install_setup() {
    darwin_install_brew
    brew_update
    install gnu-tar
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
      install autoconf      \
              autotools-dev \
              git           \
              pkg-config
    }

    install() {
      for n in $@; do apt_get_install $n; done
    }

    install_from_git() {
      TEMP_DIR=`mktemp -d -t $(date +%Y-%m-%d-%H-%M-%S)-XXXXXXXX`
      mkdir -pv $TEMP_DIR
      pushd $TEMP_DIR

      git clone $1
      PROJECT_NAME=`ls`
      cd $PROJECT_NAME

      if [[ -f ./autogen.sh ]] && [[ -f ./configure ]]; then
        ./autogen.sh
        ./configure
      fi

      if [[ -f ./Makefile ]]; then
        make
        fakeroot
        make install DESTDIR="`pwd`/fakeroot_dir"
      fi

      mkdir -pv fakeroot_dir/DEBIAN
      cd fakeroot_dir

      find etc | sed "s/^/\//" > DEBIAN/conffiles

      echo "\
Package: ${PROJECT_NAME}
Version: 0.0.1
Architecture: `uname -m`
Maintainer: ${PROJECT_NAME}
Description: ${1}
" > DEBIAN/control

      # sudo checkinstall -y
      dpkg -b fakeroot_dir
      popd
      # sudo rm -rf $TEMP_DIR
    }
  fi
fi
