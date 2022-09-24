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

" Highlight all matches in incsearch. C-l clears.
set hlsearch

" Highlight trailing spaces
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Use fzf for file searching
" https://github.com/junegunn/fzf/blob/master/README-VIM.md
set rtp+=/usr/local/opt/fzf

" projectionist
" https://github.com/tpope/vim-projectionist
" help expand
let g:projectionist_heuristics = {
	\ "go.work|go.mod|main.go": {
		\ "*.go": {
			\ "alternate": "{}_test.go",
			\ "type": "source",
			\ "dispatch": "go build %"
		\ },
		\ "*_test.go": {
			\ "alternate": "{}.go",
			\ "type": "test",
			\ "dispatch": "go test %:p:h"
		\ },
	\ }}

" Rust, auto-format on save
" TODO use LSP for Rust
" https://rust-analyzer.github.io/manual.html#nvim-lsp
let g:rustfmt_autosave = 1

" LSP config for Go
" https://www.getman.io/posts/programming-go-in-neovim/
lua require("lsp_config")
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePre *.go lua go_org_imports()
autocmd FileType go setlocal omnifunc=v:lua.vim.lsp.omnifunc

" vim-vsnip
" Expand
imap <expr> <C-]>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-]>'
smap <expr> <C-]>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-]>'

"" Expand or jump
"imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
"smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" TODO golang, bash, python, c
" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']
