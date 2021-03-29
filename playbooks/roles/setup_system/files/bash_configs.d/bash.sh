#
# Bash history.
#

HISTSIZE=1000
HISTFILESIZE=2000

# Don't put duplicate lines or
# lines starting with space in the history.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it.
shopt -s histappend


#
# Bash completion.
#

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# Check the window size after each command and,
# if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize
