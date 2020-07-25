#!/bin/sh

if [ -d "$HOME/bin" ]; then PATH="$HOME/bin:$PATH"; fi
if [ -d "$HOME/.local/bin" ]; then PATH="$HOME/.local/bin:$PATH"; fi

# Runtimes
## Node
load_nvm () {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
}
for cmd in $(
    find "${HOME}/.nvm/versions/node" -maxdepth 3 -type l -wholename '*/bin/*' -print0 \
    | xargs -0 -n1 basename | sort | uniq; echo "node" "nvm"
); do
    eval "${cmd}(){ unset -f ${cmd}; load_nvm; ${cmd} \$@; }"
done

## Python
export PATH="/home/villasv/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

## Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

## Rust
export PATH="$HOME/.cargo/bin:$PATH"
