#!/bin/bash
# Run with `bash --rcfile bws.bashrc`
# Or even `alias bws="bash --rcfile ~/.bws.bashrc"`
pr_err()
{
	>&2 echo "Error: $@"
}

echo "Bitwarden session shell."
if ! bw_session="$(bw unlock --raw)"; then
	pr_err 'Failed to run `bw unlock --raw`'
	exit 1
fi
echo "Unlocked, starting session."
export BW_SESSION="$bw_session"
export PS1="bws> "
