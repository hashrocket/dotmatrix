path=(
  "$HOME/bin"
  /usr/local/bin
  /usr/local/sbin
  /opt/local/bin
  /usr/bin
  /bin
  /usr/sbin
  /sbin
  /usr/X11/bin
)

source "$HOME/.hashrc"

# color term
export CLICOLOR=1
export LSCOLORS=Dxfxcxdxbxegedabadacad
export ZLS_COLORS=$LSCOLORS
export TERM=xterm
export LC_CTYPE=en_US.UTF-8
export LESS=FRX

# make with the nice completion
autoload -U compinit; compinit

# Completion for kill-like commands
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

# Load known hosts file for auto-completion with ssh and scp commands
if [ -f ~/.ssh/known_hosts ]; then
  hostlist() {
    local hosts=''
    hosts+= cat $HOME/.ssh/config | grep '^Host [^\*]' | sed 's/^Host //'
    hosts+= sed 's/[, ].*$//' $HOME/.ssh/known_hosts
    return hosts
  }
  zstyle ':completion:*' hosts $(hostlist)
  zstyle ':completion:*:*:(ssh|scp):*:*' hosts $(hostlist)
  zstyle ':completion:*:ssh:*' tag-order hosts users
  zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr
fi

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
        named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
        avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail

# make with the pretty colors
autoload colors; colors

# options
setopt appendhistory autocd extendedglob histignoredups correctall nonomatch prompt_subst

# Bindings
# external editor support
autoload edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Partial word history completion
bindkey '\ep' up-line-or-search
bindkey '\en' down-line-or-search
bindkey '\ew' kill-region
bindkey '^r' history-incremental-search-backward

# prompt
PROMPT='%{$fg_bold[green]%}%n@%m%{$reset_color%}:%{$fg_bold[cyan]%}%~%{$reset_color%}$(git_prompt_info "(%s)")%# '

# show non-success exit code in right prompt
RPROMPT="%(?..{%{$fg[red]%}%?%{$reset_color%}})"

# history
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

# default apps
(( ${+PAGER}   )) || export PAGER='less'
(( ${+EDITOR}  )) || export EDITOR='vim'
export PSQL_EDITOR='vim -c"set syntax=sql"'

# just say no to zle vim mode:
bindkey -e

# aliases
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias spec='nocorrect spec'
alias rspec='nocorrect rspec'
alias ll="ls -l"
alias l.='ls -ld .[^.]*'
alias lsd='ls -ld *(-/DN)'
alias md='mkdir -p'
alias rd='rmdir'
alias cd..='cd ..'
alias ..='cd ..'
alias spec='spec -c'
alias heroku='nocorrect heroku'

# set cd autocompletion to commonly visited directories
cdpath=(~ ~/src $DEV_DIR $HASHROCKET_DIR)

# rvm-install added line:
if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then source "$HOME/.rvm/scripts/rvm" ; fi

cuke() {
  local file="$1"
  shift
  cucumber "features/$file" $@
}
compctl -g '*.feature' -W features cuke

# import local zsh customizations, if present
zrcl="$HOME/.zshrc.local"
[[ -a $zrcl ]] && source $zrcl
