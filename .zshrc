#!/bin/sh

# shellcheck source=.profile
. "$HOME/.profile"

alias please='while [ $? -ne 0 ] && [ $? -le 130 ]; do eval "$(fc -ln -1)"; done'

export ZSH=/home/villasv/.oh-my-zsh
ZSH_THEME="agnoster"
plugins=(git)
DISABLE_AUTO_UPDATE="true"  # >0.1s faster load
ZSH_DISABLE_COMPFIX="true"  # >0.1s faster load
rm -f $ZSH/lib/grep.zsh     # >0.1s faster load
source $ZSH/oh-my-zsh.sh    # >60% load is compinit


# Tools
## fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## thefuck
eval "$(thefuck --alias)"
