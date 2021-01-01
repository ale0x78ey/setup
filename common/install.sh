install_setup() {
  if [[ "`uname -s`" == "Linux" ]]; then
    if [[ `which apt-get` ]]; then
      source common/apt-get.sh
      apt_get_setup
    fi
  fi

  if [[ "`uname -s`" == "Darwin" ]]; then
    source common/brew.sh
    brew_setup
  fi

  build_setup
  install_git_repo_setup
}

install() {
  if [[ "`uname -s`" == "Linux" ]]; then
    for n in $@
    do
      if [[ `which apt-get` ]]; then
        apt_get_install $n;
      fi
    done
  fi

  if [[ "`uname -s`" == "Darwin" ]]; then
    for n in $@; do brew_install $n; done
  fi
}

build_setup() {
  install autoconf \
          automake \
          fakeroot \
          libtool  \
          make     \
          pkg-config

  if [[ "`uname -s`" == "Linux" ]]; then
    install autotools-dev
  fi

  if [[ "`uname -s`" == "Darwin" ]]; then
    :
  fi
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

install_git_repo_setup() {
  install git

  if [[ `which dpkg` ]]; then
    source common/dpkg.sh
  fi
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

  if [[ `which dpkg` ]]; then
    build_dpkg "${PACKAGE_ROOT_DIR}" ${PROJECT_NAME} $1
    sudo dpkg -i ${PROJECT_NAME}.deb
  fi

  popd
  rm -rf $TEMP_DIR
}
