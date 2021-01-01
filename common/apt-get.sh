apt_get_setup() {
  sudo apt-get update
}

apt_get_install() {
  if [[ ! `which $1` ]]; then
    sudo apt-get install -y $1
  fi
}
