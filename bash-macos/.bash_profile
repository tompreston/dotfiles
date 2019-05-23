# Thomas Preston's macOS bash_profile
# Note: PATH is set by /usr/libexec/path_helper `man path_helper`

bash_aliases()
{
	declare -r ba=~/.bash_aliases

	if [ -f $ba ]; then
	    source $ba
	fi
}

bash_completion()
{
	declare -r bc=/usr/local/etc/bash_completion

	if [ -f $bc ]; then
		source $bc
	fi
}

# temporary while brew is fixed
git_completion()
{
	source ~/.git-completion-v2.17.2.bash
}

ps1()
{
	export PS1='\u:\w\[\033[33m\]\$\[\033[0m\] '
}

bash_aliases
bash_completion
git_completion
ps1
