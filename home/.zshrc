# zshrc Tom Preston

# Profile this startup (put `zprof` at the end)
#zmodload zsh/zprof

# Functions / aliases.
# Don't over do it, otherwise you'll lose muscle memory for the defaults.

# source file if it exists
function sourcefile() {
	if [ -s $1 ]; then
		source $1
	fi
}

# Docker run some image as an env
function dr() {
	local image="$1"
	docker run \
		-v "$PWD:/w" \
		--workdir /w \
		-it "${image}" \
		/bin/bash
}

# Set Neovim as preferred editor
export VISUAL="nvim"
export VIMCONFIG="$HOME/.config/nvim"
export VIMDATA="$HOME/.local/share/nvim"

export FZF_DEFAULT_COMMAND="rg --files"

# Use Neovim instead of vim or vi
alias vim="$VISUAL"
alias vi="$VISUAL"

# Open the vim configs
alias vimconf="$VISUAL $VIMCONFIG/init.lua"

# Use emacs keybindings, which I'm used to
bindkey -e

alias cdw="cd ~/src/github.com/monzo/wearedev"
alias cdd="cd ~/Downloads"
alias todo="vim ~/Documents/todo.md"
alias eod="open https://docs.google.com/document/d/1kBld3aUUazEdx-tK-YNUholDqxMon4LuVqGytgQpYPU/edit"
alias brag="open https://docs.google.com/document/d/1CB8e5D6PAZU6YtRIW2Ic0gSOZlwfHbtiJj2EbN5Jf_8/edit"
alias jn="open https://docs.google.com/document/d/1ZdQ7HEUv5xqDOYGkemFH9RLcNwljpnPwck6Hh9Sf-6M/edit"
alias grep="grep --color=auto"
alias la="ls -A"
alias ll="ls -l"
alias ls="ls -G"
alias l="ls -CF"

# Kubernetes completion (adds latency)
if type kubectl >/dev/null; then
	autoload -U +X compinit && compinit
	source <(kubectl completion zsh)
	alias k="kubectl"
fi

# Bash-like navigation
autoload -U select-word-style
select-word-style bash

# Set the prompt
PROMPT='%n %3~ %# '

sourcefile ~/.fzf.zsh

# Monzo stuff
sourcefile "$HOME/src/github.com/monzo/starter-pack/zshrc"

# NVM settings (adds latency)
export NVM_DIR="$HOME/.nvm"
sourcefile "/usr/local/opt/nvm/nvm.sh"
sourcefile "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

# Set up SSH AUTH SOCK if not already set up
# TODO delete if we don't need this, ignoring until I see the problem again
#export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
#if [ -z $(pgrep gpg-agent) ]; then
#	gpg-agent --daemon
#fi

# Export tail
# Random setup scripts like to append here.
#

# This already happens in starter-pack
#export PYENV_ROOT=$(brew --prefix)/var/pyenv
#export PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
#if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi

export PATH="$HOME/.poetry/bin:$PATH"
export PATH="${CURRENT_USER}/.poetry/bin:$PATH"
sourcefile /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
sourcefile /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc

export OAUTHLIB_RELAX_TOKEN_SCOPE=1
sourcefile "$HOME/src/github.com/monzo/analytics/dbt/misc/shell/source.sh"

