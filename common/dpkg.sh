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
