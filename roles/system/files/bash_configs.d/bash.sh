# PS1
if [[ "`uname -s`" == "Darwin" ]]; then
    IP=`ifconfig -l | xargs -n1 ipconfig getifaddr | head -n1`
else
    IP=`hostname -I | tr " " "\n"  | head -n1`
fi

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support.
  # Assume it's compliant with Ecma-48 (ISO/IEC-6429).
  # Lack of such support is extremely rare, and such a
  # case would tend to support setf rather than setaf.
  export PS1="\[\033[01;32m\]\u@$IP\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
else
  export PS1="\u@$IP:\w\$ "
fi

# Color support.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && \
    eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Make less more friendly for non-text files.
if [ -x /usr/bin/lesspipe ]; then eval "$(SHELL=/bin/sh lesspipe)"; fi


# History.
HISTSIZE=1000
HISTFILESIZE=2000

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it.
shopt -s histappend

# Check the window size after each command and, if necessary, update the
# values of LINES and COLUMNS.
shopt -s checkwinsize

# Bash completions.
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [[ "$(which brew)" ]]; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
  fi
fi
