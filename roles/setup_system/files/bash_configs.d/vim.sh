# Set up fzf shortcuts.
export FZF_DEFAULT_OPTS='--bind "ctrl-j:preview-page-down,ctrl-k:preview-page-up" '

export BAT_THEME='GitHub'
FZF_DEFAULT_OPTS+='--preview "bat --color=always --style=numbers {}" '

# Disable XON/XOFF flow control to fix Vim freezes.
if [[ $- == *i* ]]; then
  # We are in an interactive shell.
  stty -ixon
fi
