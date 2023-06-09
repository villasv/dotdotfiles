# History
SAVEHIST=1000000 # big history file
HISTSIZE=1000000 # big history buffer
setopt HIST_REDUCE_BLANKS	# ignore whitespace when saving to file
setopt SHARE_HISTORY		# history from all shells immediately visible

eval "$(starship init zsh)"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export GIT_COMPLETION_CHECKOUT_NO_GUESS=1
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit

# Homebrew
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Python
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.pyenv/bin:$PATH"

# Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
