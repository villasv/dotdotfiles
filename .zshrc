eval "$(starship init zsh)"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit

# Homebrew
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

