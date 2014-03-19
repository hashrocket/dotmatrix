#!/usr/bin/env bash

# use call with -l to list github address of all bundles
# use with -l -v to see the head of all readmes

LIST_ONLY=false
VERBOSE=false

OPTIND=1
while getopts "lv" opt; do
  case "$opt" in
    l)
      LIST_ONLY=true
      ;;
    v)
      VERBOSE=true
      ;;
  esac
done

if [ ! -d "$HOME/.vimbundles" ]; then
  BASE="$HOME/.vim/bundle"
else
  BASE="$HOME/.vimbundles"
fi

mkdir -p $BASE

install_from() {
  if [ -r $1 ]; then
    repos="$(cat $1)"
    for repo in $repos; do
      cd $BASE
      dir="$(basename $repo)"
      if $LIST_ONLY; then
        echo "https://github.com/$repo"
        if $VERBOSE; then
          find "$dir" -maxdepth 1 -iname "README*" | xargs head
          echo "============================================================="
          echo "============================================================="
        fi
      else
        echo
        if [ -d "$BASE/$dir" ]; then
          echo "Updating $repo"
          cd "$BASE/$dir"
          git pull --rebase
        else
          git clone https://github.com/"$repo".git
        fi
      fi
    done
  fi
}

install_from "$HOME/.vimbundle"
install_from "$HOME/.vimbundle.local"
vim -c 'call pathogen#helptags()|q'
