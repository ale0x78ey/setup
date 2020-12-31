apt_get_update() {
  sudo apt-get update
}

apt_get_upgrade() {
  :
}

apt_get_install() {
  sudo apt-get install -y $@
}
