#!/bin/sh

if [ -d "$HOME/bin" ]; then PATH="$HOME/bin:$PATH"; fi
if [ -d "$HOME/.local/bin" ]; then PATH="$HOME/.local/bin:$PATH"; fi

# Runtimes

## Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

## Python
export PATH="/home/villasv/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

## Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

## Rust
export PATH="$HOME/.cargo/bin:$PATH"
