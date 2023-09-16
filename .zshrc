# History
SAVEHIST=1000000 # big history file
HISTSIZE=1000000 # big history buffer
setopt HIST_REDUCE_BLANKS	# ignore whitespace when saving to file
setopt SHARE_HISTORY		# history from all shells immediately visible

## Colors!
alias diff='diff --color=always'
alias grep='grep --color=always'
alias ls='ls --color=always'

# Homebrew
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Starship
eval "$(starship init zsh)"
source ~/.fzf.zsh
eval $(thefuck --alias)
export GIT_COMPLETION_CHECKOUT_NO_GUESS=1
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit

# Python
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

# Node
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"
source "$NVM_DIR/bash_completion"

## Rust
export PATH="$HOME/.cargo/bin:$PATH"
source "$HOME/.cargo/env"

## Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

## Dotnet
export PATH="$PATH:$HOME/.dotnet/tools"

## Website
export PATH="$PATH:$HOME/Projects/victor.villas"
