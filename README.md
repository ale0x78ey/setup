# Setup system

It's just some ansible playbooks for local environment.

## Ubuntu

```bash
sudo apt update && sudo apt install -y python3 python3-pip python3-venv
python3 -m venv venv
. venv/bin/activate
pip install setuptools wheel ansible
ansible-playbook -i hosts setup_system.yml
./setup_vim
```

## Yandex

```bash
. venv/bin/activate
pip install awscli
aws configure
> AWS Access Key ID [None]: <идентификатор ключа>
> AWS Secret Access Key [None]: <ваш секретный ключ>
> Default region name [None]: ru-central1
> Default output format [None]: json
ls -al ~/.aws/
```
