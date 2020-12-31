apt_get_update() {
  sudo apt-get update
}

apt_get_install() {
  if [[ ! `which $1` ]]; then
    sudo apt-get install -y $1
  fi
}
