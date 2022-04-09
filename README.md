## Setup system

It's just some ansible playbooks for local environment.

## Ubuntu

```bash
sudo apt update && sudo apt install -y \
  git                                  \
  python3                              \
  python3-pip                          \
  python3-venv

python3 -m venv venv
. venv/bin/activate
pip install --upgrade pip
pip install setuptools wheel ansible
ansible-playbook -i hosts setup_system.yml
./setup_vim_debian
```

## CentOS

```bash
sudo yum update && sudo yum install -y \
  git                                  \
  python3                              \
  python3-pip                          \
  python3-virtualenv

python3 -m venv venv
. venv/bin/activate
pip install --upgrade pip
pip install setuptools wheel ansible
ansible-playbook -i hosts setup_system.yml
./setup_vim_centos
```
