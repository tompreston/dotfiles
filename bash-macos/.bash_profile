setup_git_completion()
{
	source ~/.git-completion-v2.17.2.bash
}

# PATH update
pupdate()
{
	case ":${PATH:=$1}:" in
	*:$1:*) ;;
	*) PATH="$1:$PATH" ;;
	esac;
}

if [ -f /usr/local/etc/bash_completion ]; then
	source /usr/local/etc/bash_completion
fi

export PS1='\u:\w\[\033[33m\]\$\[\033[0m\] '

pupdate /Users/tom/Library/Python/3.7/bin
pupdate /usr/local/sbin
pupdate /usr/local/bin

setup_git_completion

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
