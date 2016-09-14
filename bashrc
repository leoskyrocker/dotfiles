. ~/.git-completion.sh
. ~/.git-prompt.sh
. ~/.git-prompt-extension.sh
. ~/.bash-aliases

# . ~/.appfolio
# . ~/.ssh-completion
# . ~/.rake_autocomplete
# . ~/.ror-scripts.sh

export VISUAL=nvim
export EDITOR=nvim

if TERM_PROGRAM=Apple_Terminal; then
 source ~/.bashrc_terminal
else
 source ~/.bashrc_iterm2
fi

export PATH=$PATH:$HOME/.rvm/bin
# export HISTCONTROL=ignoredups
export HISTCONTROL=ignoreboth
ulimit -n 9999

if [ -n "$RVM_PROMPT" ]; then
  COLORED_RVM_PROMPT="${RED} (${RVM_PROMPT})"
else
  COLORED_RVM_PROMPT=""
fi

export PS1="${GREEN}[\t]${COLORED_RVM_PROMPT} ${YELLOW}\$(__git_ps1 '(%s')${GREEN}\$(git-not-dirty)${RED}\$(git-dirty)${MAGENTA}\$(git-needs-push)${YELLOW}\$(__git_ps1 ' )')\n${BLUE}\w${RED} $ ${RESET}"
