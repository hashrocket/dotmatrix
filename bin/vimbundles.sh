#!/usr/bin/env bash

BASE="$HOME/.vimbundles"

mkdir -p $BASE

install_from() {
  if [ -r $1 ]; then
    repos="$(cat $1)"
    for repo in $repos; do
      cd $BASE
      dir="$(basename $repo)"
      echo
      if [ -d "$BASE/$dir" ]; then
        echo "Updating $repo"
        cd "$BASE/$dir"
        git pull --rebase
      else
        git clone https://github.com/"$repo".git
      fi
    done
  fi
}

install_from "$HOME/.vimbundle"
install_from "$HOME/.vimbundle.local"
