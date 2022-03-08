export PATH="$HOME/.poetry/bin:$PATH"

# Don't use .pyc и .pyo.
export PYTHONDONTWRITEBYTECODE=1

if type pyenv &> /dev/null; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"

  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
  eval "$(pyenv virtualenv-init -)"
fi

