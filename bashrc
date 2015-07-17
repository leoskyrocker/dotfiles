. ~/git-completion.bash
. ~/.ssh-completion
. ~/.appfolio
. ~/.rake_autocomplete
. ~/.git-prompt.sh

APM_BUNDLE='/Users/leolei/src/apm_bundle'
 
alias g='git'
alias ctags="`brew --prefix`/bin/ctags"
alias e='mvim'
alias update_gems='gems && find . -type d -depth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull origin master \; && cd -'

#### RAILS ####
alias reset='rake db:reset; RAILS_ENV=test rake db:reset;'
alias create='rake db:create; RAILS_ENV=test rake db:create;'
alias drop='rake db:drop; RAILS_ENV=test rake db:drop;'
alias m='rake db:migrate; RAILS_ENV=test rake db:migrate;'
alias rollback='rake db:rollback; RAILS_ENV=test rake db:rollback'
alias b='bundle install --local'

#### git ####
alias st='git status'
alias scm='git story-commit'
alias pullreq='git story-pull-request'
alias cm='git commit'
alias c='git co -'
alias lg='git log --graph'
alias branch='git co master && git pull && git co -b '
alias add='git add -p'
alias amend='git commit --amend --no-edit'
alias amendwith='git commit --amend -m'

alias pr='pry-remote'

export VISUAL=mvim
export EDITOR=mvim
 
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
BLUE=$(tput setaf 033)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export PS1="${GREEN}[\t]${RED} (\$(~/.rvm/bin/rvm-prompt)) ${YELLOW}\$(__git_ps1 '(%s')${GREEN}\$(git-not-dirty)${RED}\$(git-dirty)${VIOLET}\$(git-needs-push)${YELLOW}\$(__git_ps1 ' )')\n${BLUE}\w${WHITE} $ \n"
export PATH=$PATH:$HOME/.rvm/bin
export NGINX_VERSION=/usr/local/bin/nginx
export HISTCONTROL=ignoredups
export HISTCONTROL=ignoreboth
ulimit -n 9999

function git-not-dirty {
    st=$(git status 2>/dev/null)
    if [[ $st == "" ]]
    then
        echo ""
    elif [[ $st =~ "nothing to commit, working directory clean" ]]
    then
        echo " ✔"
    fi
}
 
function git-dirty {
    st=$(git status 2>/dev/null)
    if [[ $st == "" ]]
    then
        echo ""
    elif [[ ! ($st =~ "nothing to commit, working directory clean") ]]
    then
        echo " ✖"
    fi
}
 
function git-needs-push {
    st=$(git status 2>/dev/null | tail -n 1)
    if [[ $st == "" ]]
    then
        echo ""
    elif [[ `echo $(git status) | grep -c "Your branch is ahead of"` = 1 ]] 
    then
        echo " ⇪"
    elif [[ -z `git remote 2> /dev/null` ]] 
    then
        if [[ `echo $(git cherry trunk) | grep -c "+"` = 1 ]] 
        then
            echo " ⇪"
        fi
    fi
}

function nuke_solr() {
  BLUE="\033[34m"
  launchctl stop homebrew.mxcl.apache-solr-48
  launchctl start homebrew.mxcl.apache-solr-48
  echo -e "${BLUE}Fixing Solr for property"
  rm config/solr_48/core.properties 2> /dev/null
  rake solr:generate_data_config
  rake solr:destroy_core 2> /dev/null
  rake solr:create_core
  echo -e "${BLUE}Fixing Solr for property test"
  RAILS_ENV=test rake solr:destroy_core 2> /dev/null
  RAILS_ENV=test rake solr:create_core
  echo -e "${BLUE}Fixing Solr for property search engine"
  cd engines/search
  rm config/solr_48/core.properties 2> /dev/null
  RAILS_ENV=test rake solr:destroy_core 2> /dev/null
  RAILS_ENV=test rake solr:create_core
  cd - > /dev/null
  echo -e "${BLUE}Reindexing solr"
  rake solr:reindex
}

function copy_vhost_dbs()
{
  cd "$APM_BUNDLE/apps"

  [ -z "$1" ] && echo "You have to specify a vhost name" && return

  set -ex
  for app in *; do
    pushd "$app"
    remote_dbname="${app}_$1"
    local_dbname="${app}_development"
    mysql -uroot -e "drop database $local_dbname; create database $local_dbname"
    ssh back1.qa4 "mysqldump ${remote_dbname} | gzip" |
    gunzip |
    mysql -uroot "$local_dbname"
    popd
  done
}

function tall_unit()
{
  find test/unit test/functional -name *$1*_test.rb
  find test/unit test/functional -name *$1*_test.rb | xargs -t ruby -I test -e "ARGV.each{|f| require Dir.pwd + '/' + f}" 2>/dev/null
}
 
function tall_selenium()
{
  find test/selenium test/selenium2 test/selenium_flaky -name *$1*_test.rb
  find test/selenium test/selenium2 test/selenium_flaky -name *$1*_test.rb | xargs -t ruby -I test -e "ARGV.each{|f| require Dir.pwd + '/' + f}" 2>/dev/null
}
 
function tall()
{
  tall_unit $1
  tall_selenium $1
}
