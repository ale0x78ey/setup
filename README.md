# My environment
## Operating System Support
Ubuntu 18.04 and up.

```bash
echo "${USER} ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/${USER}
```

```bash
sudo xcode-select --install
pyenv install 3.9.0
pyenv global 3.9.0
```

## Jekyll

```bash
mkdir -p ~/Projects/myblogs
cd ~/Projects/myblogs
rbenv install 2.7.2
rbenv local 2.7.2
exec su - ${USER}
./setup jekyll
hash jekyll

jekyll new myblog_1
cd myblog_1
bundle exec jekyll serve
```
