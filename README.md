# Thomas Preston's dotfiles
Here are my dotfiles so I can remain consistent across distributions.

    git clone --recurse-submodules https://github.com/tompreston/dotfiles \
        .dotfiles
    make install

It uses [GNU stow](https://www.gnu.org/software/stow/manual/stow.html) to
symlink the files in place - whose default target directory is ..

# TODO
- Check out https://www.chezmoi.io/
- Consider vim http://majutsushi.github.io/tagbar/

# Live linting
- I tried installing syntastic but it hangs for large files when using neovim.
- I also tried neomake but it doesn't work with vim's native package handler.
  https://github.com/neomake/neomake/issues/2482
- I've decided not to bother for now. It's very easy to get linting in the
  terminal, so just do that instead.
- I've installed vim-dispatch which is cool but it clashes with the features of
  neomake. I still kind of want live-linting, so I might give vim8 a go.
