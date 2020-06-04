set background=light

" Show line numbers
set number

" let vim-find search all sub directories
set path+=**

" Draw a ruler
set colorcolumn=81
highlight ColorColumn ctermbg=LightGrey ctermfg=DarkRed

" Show leading tabs, trailing spaces, nbsp
set list listchars=tab:>\ ,trail:-,nbsp:+
highlight SpecialKey ctermfg=LightGrey

" Toggle tagbar with F8
nmap <F8> :TagbarToggle<CR>

" Always use system clipboard :help clipboard
set clipboard+=unnamedplus

" Tab is 4 spaces for the following
autocmd FileType markdown setlocal shiftwidth=4 tabstop=4 expandtab
" Tab is 2 spaces for the following
autocmd VimEnter * if @% =~ "w/standup" |
	\ setlocal shiftwidth=2 tabstop=2 expandtab | endif
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 expandtab

" Rust, auto-format on save
let g:rustfmt_autosave = 1
