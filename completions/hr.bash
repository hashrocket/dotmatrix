_hr() {
  COMPREPLY=()
  local word="${COMP_WORDS[COMP_CWORD]}"

  if [ "$COMP_CWORD" -eq 1 ]; then
    COMPREPLY=( $(compgen -W "$(hr commands)" -- "$word") )
  else
    local command="${COMP_WORDS[1]}"
    local completions="$(hr completions "$command" ${COMP_WORDS[@]:2})"
    if [ "$completions" ]; then
      COMPREPLY=( $(compgen -W "$completions" -- "$word") )
    else
      return 1
    fi
  fi
}

complete -o default -F _hr hr
