# .bash_profile
# Run when a login shell executes.

if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi
if [ -e /home/tpreston/.nix-profile/etc/profile.d/nix.sh ]; then . /home/tpreston/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
