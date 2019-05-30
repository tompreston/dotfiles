" Show line numbers
set number

" Draw a ruler
set colorcolumn=81
highlight ColorColumn ctermbg=Black ctermfg=DarkRed

" Show leading tabs/spaces
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

" Enable spellchecker with F5
map <F5> :setlocal spell! spelllang=en_gb<CR>

" Always use system clipboard :help clipboard
set clipboard+=unnamedplus
