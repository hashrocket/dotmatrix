if [[ ! -o interactive ]]; then
    return
fi

compctl -K _hr hr

_hr() {
  local word words completions
  read -cA words
  word="${words[2]}"

  if [ "${#words}" -eq 2 ]; then
    completions="$(hr commands)"
  else
    completions="$(hr completions "${word}")"
  fi

  reply=("${(ps:\n:)completions}")
}
