set background=light

" Show line numbers
set number

" let vim-find search all sub directories
set path+=**

" Draw a ruler
set colorcolumn=101
highlight ColorColumn ctermbg=LightGrey ctermfg=DarkRed

" Show leading tabs
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

" Clipboard
"
" On Fedora, install vim-X11 to get the `vimx` program.
" vimx has +clipboard buffers like:
"
"     "*, PRIMARY, middle click, star-select, clipboard-unnamed.
"     "+, CLIPBOARD, ctrl+c, ctrl PLUS c, clipboard-unnamedplus.
"
" Since we're on Wayland, remap these vimx buffers to wl-copy.
" https://github.com/vim/vim/issues/5157#issue-516033639
xnoremap "+y y:call system("wl-copy", @")<cr>
nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
nnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', '', 'g')<cr>p

" TODO tabs/spaces should be by vim-sleuth, or vim format strings.
" Keep these here until I'm confident with the process.
"" Tab is 4 spaces for the following
"autocmd FileType markdown setlocal shiftwidth=4 tabstop=4 expandtab
"" Tab is 2 spaces for the following
"autocmd VimEnter * if @% =~ "w/standup" |
"	\ setlocal shiftwidth=2 tabstop=2 expandtab | endif
"autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 expandtab

" Rust, auto-format on save
let g:rustfmt_autosave = 1

