#!/bin/sh

if [ -d "$HOME/bin" ]; then PATH="$HOME/bin:$PATH"; fi
if [ -d "$HOME/.local/bin" ]; then PATH="$HOME/.local/bin:$PATH"; fi

# Runtimes

## Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

## Rust
. "$HOME/.cargo/env"

# CLI Goodies

## thefuck
eval "$(thefuck --alias)"

