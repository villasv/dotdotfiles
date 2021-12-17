#!/bin/bash
. "$HOME/.profile"

# Bash History
## Infinite history buffer
HISTSIZE=
## Very long history file
HISTFILESIZE=1000000
## Ignore leading whitespace
HISTCONTROL=ignorespace
## Append mode to preserve parallel history
shopt -s histappend
## Include timestamp
export HISTTIMEFORMAT="%F %T "


alias please='while [ $? -ne 0 ] && [ $? -le 130 ]; do eval "$(fc -ln -1)"; done'

# Starhship
eval "$(starship init bash)"

# git
[ -f /usr/share/bash-completion/completions/git ] \
    && source /usr/share/bash-completion/completions/git

# ⏱ ???

