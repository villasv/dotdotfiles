#!/bin/bash

# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000




alias please='while [ $? -ne 0 ] && [ $? -le 130 ]; do eval "$(fc -ln -1)"; done'


############################################################
########################  Cosmetics  #######################
############################################################

# Starhship
eval "$(starship init bash)"

# ⏱ ???
