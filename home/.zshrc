# zshrc Tom Preston

# Profile this startup (put `zprof` at the end)
#zmodload zsh/zprof

# Monzo stuff
[ -f $HOME/src/github.com/monzo/starter-pack/zshrc ] && source $HOME/src/github.com/monzo/starter-pack/zshrc

# NVM settings
# Too slow and I don't use nvm. Ignore for now.
#export NVM_DIR="$HOME/.nvm"
#[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
#[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
#[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Functions / aliases.
# Don't over do it, otherwise you'll lose muscle memory for the defaults.

# Open vim with fzf
function vimf() {
	local file=$(fzf)
	vim $file
	echo file
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

alias cdw="cd ~/src/github.com/monzo/wearedev"
alias todo="vim ~/Documents/todo.md"
alias eod="vim ~/Documents/eod.md"
alias grep="grep --color=auto"
alias la="ls -A"
alias ll="ls -l"
alias ls="ls -G"
alias l="ls -CF"

# Bash-like navigation
autoload -U select-word-style
select-word-style bash

# Set the prompt, with some VCS info
autoload -Uz vcs_info
setopt PROMPT_SUBST
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '[%b]'
precmd () {
	vcs_info
}
PROMPT='%n %3~ %# '
RPROMPT='${vcs_info_msg_0_}'

# Export tail
# Random setup scripts like to append here.
export PYENV_ROOT=$(brew --prefix)/var/pyenv
export PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi

export PATH="$HOME/.poetry/bin:$PATH"
export PATH="${CURRENT_USER}/.poetry/bin:$PATH"
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
export OAUTHLIB_RELAX_TOKEN_SCOPE=1
source /Users/thomaspreston/src/github.com/monzo/analytics/dbt/misc/shell/source.sh
