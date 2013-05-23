_hr_commands() {
  local cmds
  local -a commands
  cmds="$(hr commands)"
  commands=(${(ps:\n:)cmds})
  _wanted command expl "hr command" compadd -a commands
}

_hr_subcommands() {
  local cmd subcmds
  local -a commands
  cmd="${words[2]}"
  subcmds="$(hr completions $cmd ${words[3,$(($CURRENT - 1))]})"
  if [ -n "$subcmds" ]; then
    commands=(${(ps:\n:)subcmds})
    _wanted subcommand expl "hr $cmd subcommand" compadd -a commands
  else
    _default
  fi
}

_hr() {
  case $CURRENT in
    2) _hr_commands ;;
    *) _hr_subcommands ;;
  esac
}

compdef _hr hr
