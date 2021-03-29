if [[ "`uname -s`" == "Darwin" ]]; then
    IP=`ifconfig -l | xargs -n1 ipconfig getifaddr | head -n1`
else
    IP=`hostname -I | tr " " "\n"  | head -n1`
fi

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support.
  # Assume it's compliant with Ecma-48 (ISO/IEC-6429).
  # Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.
  export PS1="\[\033[01;32m\]\u@$IP\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
else
  export PS1="\u@$IP:\w\$ "
fi

unset IP
