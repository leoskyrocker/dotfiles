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
