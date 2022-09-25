# Thomas Preston's dotfiles

    git clone --recurse-submodules https://github.com/tompreston/dotfiles .dotfiles
    make install

It uses [GNU stow](https://www.gnu.org/software/stow/manual/stow.html) to
symlink the files in place - whose default target directory is ..

## Neovim plugins
* unimpaired toggle pairs
* vim-commentary comments
* vim-projectionist project structure
* vim-sleuth file types
* vim-sensible defaults
* vim-fetch jump to line from filename

LSP
* nvim-lspconfig

Git
* fugitive for git integrations
* rhubarb to make GBrowse work with GitHub

Fuzzy finding
* fzf for `<C-p>` which depends on rg
* fzf.vim for vim-specific fzf control (eg `:Buffers`)

Building
* vim-dispatch
* vim-dispatch-neovim
