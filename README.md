# My environment
## Operating System Support
Ubuntu 18.04 and up.

## Install Ansible

```(bash)
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py
rm get-pip.py
pip3 install --user ansible
```

## Install Kolla Ansible
### Install dependencies

```(bash)
sudo apt update
sudo apt install -y gcc libffi-dev libssl-dev python3-dev
python3 -m venv .venv
pip install -U pip
pip install 'ansible<2.10'

sudo mkdir -p /etc/kolla
sudo chown $USER:$USER /etc/kolla
cp -r /usr/local/share/kolla-ansible/etc_examples/kolla/* /etc/kolla
```

### Install Kolla for development

```(bash)
git clone https://github.com/openstack/kolla
git clone https://github.com/openstack/kolla-ansible
pip install ./kolla
pip install ./kolla-ansible
sudo mkdir -p /etc/kolla
sudo chown $USER:$USER /etc/kolla
cp -v -r kolla-ansible/etc/kolla/* /etc/kolla
cp -v kolla-ansible/ansible/inventory/* .
```
