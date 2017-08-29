" Thomas Preston ~/.vimrc
" $ ls ~/.vim/bundle/
" file-line  vim-sensible  vim-surround
execute pathogen#infect()
syntax on
filetype plugin indent on

" tabs in all files are 8 char length actual-tab-tabs (default)
"setlocal shiftwidth=8 tabstop=8 noexpandtab
" tabs in python files are 4 spaces
autocmd FileType py setlocal shiftwidth=4 tabstop=4 expandtab
" 2 spaces in standup and html
autocmd VimEnter * if @% == "Work/standup.txt" |
	\ echom "in standup" | setlocal shiftwidth=2 tabstop=2 expandtab | endif
autocmd FileType html setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 expandtab

set number
"set relativenumber

set colorcolumn=81
highlight ColorColumn ctermbg=Black ctermfg=DarkRed

" Highlight trailing spaces
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

