# $1 - src directory
# $2 - pkg name
# $3 - pkg description
package_build() {
  pushd $1
  if [[ `which dpkg` ]]; then
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
  fi
  popd

  if [[ `which dpkg` ]]; then
    dpkg -b $1 $2.deb
  fi
}

package_install() {
  if [[ `which dpkg` ]]; then
    sudo dpkg -i $1.deb
  fi
}
