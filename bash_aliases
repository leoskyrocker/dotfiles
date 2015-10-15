alias g='git'
alias ctags="`brew --prefix`/bin/ctags"
alias e='nvim'
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
