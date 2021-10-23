# Don't use .pyc и .pyo.
export PYTHONDONTWRITEBYTECODE=1

if type pyenv &> /dev/null; then
  eval "$(pyenv init -)"
fi
