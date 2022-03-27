# zshrc Tom Preston

# Profile this startup (put `zprof` at the end)
#zmodload zsh/zprof

# Functions / aliases.
# Don't over do it, otherwise you'll lose muscle memory for the defaults.

# source file if it exists
function sourcefile() {
	if [ -f $1 ]; then
		source $1
	fi
}

# Open vim with fzf
function vimf() {
	local file=$(fzf)
	vim $file
	echo $file
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

alias vim="nvim"
alias vimconf="nvim ~/.config/nvim/{init.vim,lua/lsp_config.lua}"
alias cdw="cd ~/src/github.com/monzo/wearedev"
alias todo="vim ~/Documents/todo.md"
alias eod="open https://docs.google.com/document/d/1kBld3aUUazEdx-tK-YNUholDqxMon4LuVqGytgQpYPU/edit"
alias brag="open https://docs.google.com/document/d/1CB8e5D6PAZU6YtRIW2Ic0gSOZlwfHbtiJj2EbN5Jf_8/edit"
alias grep="grep --color=auto"
alias la="ls -A"
alias ll="ls -l"
alias ls="ls -G"
alias l="ls -CF"
alias s101_tel=">&2 echo 'Use s101_tng!'"

# Bash-like navigation
autoload -U select-word-style
select-word-style bash

# Set the prompt
PROMPT='%n %3~ %# '

# Monzo stuff
sourcefile $HOME/src/github.com/monzo/starter-pack/zshrc

# NVM settings
# Too slow and I don't use nvm. Ignore for now.
#export NVM_DIR="$HOME/.nvm"
#[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
#[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
#[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# Export tail
# Random setup scripts like to append here.

# This already happens in starter-pack
#export PYENV_ROOT=$(brew --prefix)/var/pyenv
#export PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
#if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi

export PATH="$HOME/.poetry/bin:$PATH"
export PATH="${CURRENT_USER}/.poetry/bin:$PATH"
sourcefile /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
sourcefile /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc

export OAUTHLIB_RELAX_TOKEN_SCOPE=1
sourcefile /Users/thomaspreston/src/github.com/monzo/analytics/dbt/misc/shell/source.sh
