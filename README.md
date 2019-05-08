# Thomas Preston's dotfiles
Here are my dotfiles so I can remain consistent across distributions.

    git clone --recurse-submodules https://github.com/tompreston/dotfiles \
        .dotfiles
    make fedora

It uses [GNU stow](https://www.gnu.org/software/stow/manual/stow.html) to
symlink the files in place - whose default target directory is ..

# TODO
[Figure out](https://shreevatsa.wordpress.com/2008/03/30/zshbash-startup-files-loading-order-bashrc-zshrc-etc/)
which .bashrc .profile files to use for each distro, for crying out loud [1]. I
always forget the contents of:

    man bash # /INVOCATIONS

Some handy examples in:

    sudo apt install bash-doc
    less /usr/share/doc/bash/examples/startup-files/README
