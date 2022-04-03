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
let g:projectionist_heuristics = {
	\ "go.work|go.mod": {
		\ "*.go": {
			\ "alternate": "{}_test.go",
			\ "type": "source",
			\ "dispatch": "go build %"
		\ },
		\ "*_test.go": {
			\ "alternate": "{}.go",
			\ "type": "test",
			\ "dispatch": "go test ."
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
autocmd BufWritePre *.go lua org_imports(1000)
