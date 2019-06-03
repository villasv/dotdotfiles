. ~/.profile

export ZSH=/home/villasv/.oh-my-zsh
ZSH_THEME="agnoster"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

## fzf bootstrap
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# WSL specific
## useful mount link
[[ ! -e /c/ ]] && sudo ln -s /mnt/c /
cd $(pwd | sed 's/\/mnt\/c\//\/c\//')

## docker-toolbox boostrap
pushd '/mnt/c/Program Files/Docker Toolbox'
if ! docker-machine ls -q | grep 'default'; then
	### create machine
	pushd '/mnt/c/Program Files/Docker Toolbox'
	export VBOX_MSI_INSTALL_PATH=/mnt/c/Program Files/Oracle/VirtualBox
	./docker-machine.exe create -d virtualbox --virtualbox-memory 4096 --virtualbox-share-folder "\\\?\c:\Users:/mnt/c/Users" default
	### configure local docker-machine
	export MOCKER_CERT_PATH=~/.docker/machine/machines/default
	AUTH_OPTIONS=$(jq '.HostOptions.AuthOptions' $DOCKER_CERT_PATH/config.json)
	docker-machine create --driver none --url $DOCKER_HOST default
	jq ".HostOptions.AuthOptions=$AUTH_OPTIONS" $MOCKER_CERT_PATH/config.json \
		| sed 's?\\?/?g;s?C:/?/mnt/c/?g' \
		| sponge $MOCKER_CERT_PATH/config.json
fi
eval $(./docker-machine.exe env --shell bash | sed 's?\\?/?g;s?C:/?/mnt/c/?g')
popd

## pyenv
export PATH="/home/villasv/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

## nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

## yarn tools
export PATH="/home/villasv/.yarn/bin:$PATH"

