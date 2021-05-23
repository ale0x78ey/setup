# Don't use .pyc и .pyo.
export PYTHONDONTWRITEBYTECODE=1

if [[ "$(which pyenv)" ]]; then
  eval "$(pyenv init -)"
fi
