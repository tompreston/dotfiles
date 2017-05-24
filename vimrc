" Thomas Preston ~/.vimrc
" $ ls ~/.vim/bundle/
" file-line
" vim-sensible
execute pathogen#infect()
syntax on
filetype plugin indent on

" tabs in all files are 4 spaces
setlocal shiftwidth=4 tabstop=4 expandtab
" tabs in python files are 4 spaces
"autocmd FileType py setlocal shiftwidth=4 tabstop=4 expandtab
" tabs in C lang are real tabs of 8 chars
autocmd FileType c setlocal shiftwidth=8 tabstop=8 noexpandtab
" TODO standup tabs 2 chars
" tabs in standup.txt are 2 chars
"autocmd VimEnter * if @% == 'standup.txt' | setlocal shiftwidth=2 tabstop=2 expandtab | endif

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

