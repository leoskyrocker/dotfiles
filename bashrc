. ~/.git-completion.sh
. ~/.git-prompt.sh
. ~/.git-prompt-extension.sh
. ~/.bash-aliases

. ~/.utopiaB
. ~/.bash-android
# . ~/.appfolio
# . ~/.ssh-completion
# . ~/.rake_autocomplete
# . ~/.ror-scripts.sh

# Unlimited history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# End Unlimted history
## PRESERVE HISTORY ACROSS WINDOWS (https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows)
export HISTCONTROL=ignoredups:erasedups # Avoid duplicates
shopt -s histappend # When the shell exits, append to the history file instead of overwriting it
# export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r" # After each command, append to the history file and reread it
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

export VISUAL=nvim
export EDITOR=nvim

if TERM_PROGRAM=Apple_Terminal; then
 source ~/.bashrc_terminal
else
 source ~/.bashrc_iterm2
fi

export PATH=$HOME/Library/Python/2.7/bin:$PATH:$HOME/.rvm/bin
# export HISTCONTROL=ignoredups
export HISTCONTROL=ignoreboth
ulimit -n 9999

if [ -n "$RVM_PROMPT" ]; then
  COLORED_RVM_PROMPT="${RED} (${RVM_PROMPT})"
else
  COLORED_RVM_PROMPT=""
fi

export PS1="\[${CYAN}\][\t]\[${COLORED_RVM_PROMPT}\] \[${YELLOW}\]\$(__git_ps1 '(%s')\[${GREEN}\]\$(git-not-dirty)\[${RED}\]\$(git-dirty)\[${MAGENTA}\]\$(git-needs-push)\[${YELLOW}\]\$(__git_ps1 ' )')\n\[${BLUE}\]\w\[${GREEN}\]\n$ \[${RESET}\]"
