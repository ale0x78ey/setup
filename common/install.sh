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

    # $1 - src dir
    # $2 - install dir
    build() {
      pushd $1
      for s in ./autogen.sh ./configure
      do
        if [[ -f $s ]]; then $s; fi
      done

      if [[ -f ./Makefile ]]; then
        make
        fakeroot make install DESTDIR=$2
      fi
      popd
    }

    # $1 - src directory
    # $2 - pkg name
    # $3 - pkg description
    build_dpkg() {
      pushd $1
      mkdir -v DEBIAN
      find etc 2>/dev/null | sed "s/^/\//" > DEBIAN/conffiles
      ARCH=`dpkg --print-architecture`
      echo "\
Package: $2
Version: 0.0.1
Architecture: ${ARCH}
Maintainer: smb
Description: $3
" > DEBIAN/control
      popd
      dpkg -b $1 $2.deb
    }

    install_git_repo() {
      TEMP_DIR=`mktemp -d -t $(date +%Y-%m-%d-%H-%M-%S)-XXXXXXXX`
      mkdir -v ${TEMP_DIR}
      pushd ${TEMP_DIR}

      git clone $1
      PROJECT_NAME=`ls`
      cd ${PROJECT_NAME}
      PACKAGE_ROOT_DIR=`pwd`/${PROJECT_NAME}_$(date +%Y-%m-%d-%H-%M-%S)

      build `pwd` ${PACKAGE_ROOT_DIR}
      build_dpkg "${PACKAGE_ROOT_DIR}" ${PROJECT_NAME} $1
      sudo dpkg -i ${PROJECT_NAME}.deb

      popd
      rm -rf $TEMP_DIR
    }
  fi
fi
