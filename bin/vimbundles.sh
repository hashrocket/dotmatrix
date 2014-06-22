#!/usr/bin/env bash

if [ ! -d "$HOME/.vimbundles" ]; then
  BASE="$HOME/.vim/bundle"
else
  BASE="$HOME/.vimbundles"
fi

if [ "$1" = "log-since" ]; then
  echo "**logsince**"
  logsince="true"
  date="$2"
else
  logsince="false"
fi

if $($logsince) ; then
  echo "*** logsince ***"
fi

mkdir -p $BASE

action_from() {
  if [ -r $1 ]; then
    repos="$(cat $1)"
    for repo in $repos; do
      cd $BASE
      dir="$(basename $repo)"
      if [ -d "$BASE/$dir" ]; then
        cd "$BASE/$dir"
        if $logsince ; then
          echo "Log for repo $repo" >>/tmp/vimbundles.log
          git log --since $date --color=always >>/tmp/vimbundles.log
        else
          echo "Updating $repo"
          git pull --rebase
        fi
      else
        git clone https://github.com/"$repo".git
      fi
    done
  fi
}

action_from "$HOME/.vimbundle"
action_from "$HOME/.vimbundle.local"

if $logsince ; then
  less "/tmp/vimbundles.log"
  rm "/tmp/vimbundles.log"
fi
