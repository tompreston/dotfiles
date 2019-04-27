" Thomas Preston ~/.vimrc
filetype plugin indent on

syntax enable
set background=light

" an alternative to setting manually is vim-sleuth
" tabs in all files are 8 char length actual-tab-tabs (default)
"setlocal shiftwidth=8 tabstop=8 noexpandtab
" tab is 8 spaces for the following
autocmd FileType haskell setlocal shiftwidth=8 tabstop=8 expandtab
" tab is 4 spaces for the following
autocmd FileType python setlocal shiftwidth=4 tabstop=4 expandtab
autocmd FileType css setlocal shiftwidth=4 tabstop=4 expandtab
autocmd FileType markdown setlocal shiftwidth=4 tabstop=4 expandtab
" tab is 2 spaces for the following
autocmd VimEnter * if @% =~ "w/standup.d" |
	\ echom "in standup" | setlocal shiftwidth=2 tabstop=2 expandtab | endif
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType html setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 expandtab

set number
"set relativenumber

set colorcolumn=81
highlight ColorColumn ctermbg=Black ctermfg=DarkRed

" Show leading tabs/spaces and highlight
set list
highlight SpecialKey ctermfg=LightGrey

" Highlight trailing spaces
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

map <F5> :setlocal spell! spelllang=en_gb<CR>

" local vimrc
let g:localvimrc_whitelist=[
	\'/home/tpreston/Work/co034/sel4-tutorials-manifest',
\]
