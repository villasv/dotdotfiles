eval "$(starship init zsh)"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -Uz compinit && compinit

