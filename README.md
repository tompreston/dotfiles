# Thomas Preston's dotfiles
Here are my dotfiles so I can remain consistent across distributions.

    git clone --recurse-submodules https://github.com/tompreston/dotfiles \
        .dotfiles
    make fedora

It uses [GNU stow](https://www.gnu.org/software/stow/manual/stow.html) to
symlink the files in place - whose default target directory is ..
