-- 🔌 Plugins
require('packer').startup({
function(use)
	use "wbthomason/packer.nvim"

	-- Neovim LSP features
	use "neovim/nvim-lspconfig"

	-- Telescope
	use {
		"nvim-telescope/telescope-fzf-native.nvim",
		-- this didn't work, I had to run make manually
		run = "make"
	}
	use {
		"nvim-telescope/telescope.nvim",
		requires = {"nvim-lua/plenary.nvim"}
	}

	-- Language support
	use {
		"nvim-treesitter/nvim-treesitter",
		run = function() require("nvim-treesitter.install").update({ with_sync = true }) end,
	}
	-- TODO not sure I need these with treesitter
	use "elubow/cql-vim"
	use "rust-lang/rust.vim"
	use "sirtaj/vim-openscad"

	-- Building
	use "tpope/vim-dispatch"
	use "radenling/vim-dispatch-neovim"

	-- Snippets
	use "L3MON4D3/LuaSnip"
	use "rafamadriz/friendly-snippets"

	-- Fuzzy finding
	use "junegunn/fzf"
	use "junegunn/fzf.vim"

	-- Toggle pairs with [ and ]
	use "tpope/vim-unimpaired"

	-- Tests
	use "vim-test/vim-test"

	-- comments
	use "tpope/vim-commentary"

	-- git stuff
	use "tpope/vim-fugitive"
	use "tpope/vim-rhubarb"

	-- project structure and alternative files
	use "tpope/vim-projectionist"

	-- sensible defaults, not sure if I still need this with neovim
	use "tpope/vim-sensible"

	-- Check .editorconfig for indents
	use "editorconfig/editorconfig-vim"

	-- detect file types, not sure if I still need this with treesitter
	use "tpope/vim-surround"

	-- jump to line from filename
	use "wsdjeg/vim-fetch"

	use "AndrewRadev/splitjoin.vim"

	-- archive, maybe try these out another time
	-- use "tmux-plugins/tmux-open"
	-- use "majutsushi/tagbar"
end,
config = {
	-- Workaround for Packer hanging
	-- https://github.com/wbthomason/packer.nvim/issues/756#issuecomment-1006695781
	max_jobs = 10,
},
})

-- ⚙️  Options
vim.opt.background = "light"
vim.opt.colorcolumn = "121"
vim.opt.textwidth = 120
vim.opt.number = true
table.insert(vim.opt.path, "**")

-- Show listchars (inc. leading tabs)
vim.opt.list = true

-- Highlight all matches in incsearch. C-l to clear
vim.opt.hlsearch = true

-- 🎥 Projectionist
-- https://github.com/tpope/vim-projectionist
-- help expand
vim.g.projectionist_heuristics = {
	["go.work|go.mod|main.go"] = {
		["*.go"] = {
			["alternate"] = "{}_test.go",
			["type"] = "source",
			["dispatch"] = "go build %",
		},
		["*_test.go"] = {
			["alternate"] = "{}.go",
			["type"] = "test",
			["dispatch"] = "go test %:p:h",
		},
	},
}

-- 🌈 Colors
-- :help highlight-groups
vim.api.nvim_set_hl(0, 'ColorColumn', {
	ctermbg = "LightGrey",
	ctermfg = "DarkRed"
})
vim.api.nvim_set_hl(0, 'Whitespace', {
	ctermfg = "LightGrey"
})

-- 🌲 Treesitter
require('nvim-treesitter.configs').setup({
  ensure_installed = { "c", "lua", "rust", "go", "bash", "python", "javascript" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})
-- Turn off error highlighting, because it highlights in insert mode
vim.treesitter.highlighter.hl_map.error = nil

-- 🐻 Fuzzy finder
-- C-p shortcut from Modern vim
vim.keymap.set('n', '<C-p>', ':<C-u>FZF<CR>', { noremap = true })

-- Create a second FZF Windows command
-- This is workaround to prevent the W key, which I accidentally press all the
-- time, aliasing to Windows
vim.cmd("command! WindowFZF call fzf#vim#windows(<bang>0)")

-- 🔭 Telescope
local telescopebuiltin = require('telescope.builtin')
-- Use fzf.vim instead of Telescope.find_files because it's faster
-- https://github.com/nvim-telescope/telescope.nvim/issues/1837#issuecomment-1113962736
--vim.keymap.set('n', '<leader>f', telescopebuiltin.find_files)
vim.keymap.set('n', '<leader>*', telescopebuiltin.grep_string)
vim.keymap.set('n', '<leader>/', telescopebuiltin.live_grep)
vim.keymap.set('n', '<leader>fb', telescopebuiltin.buffers)
vim.keymap.set('n', '<leader>fh', telescopebuiltin.help_tags)

local telescope = require('telescope')
telescope.setup()
telescope.load_extension('fzf')

-- ✂️  Snippets
require("luasnip.loaders.from_vscode").lazy_load({
	paths = { "/Users/tompreston/.local/share/nvim/site/pack/packer/start/friendly-snippets/" }
})
require("luasnip").setup({
	-- Update more often, :h events for more info.
	update_events = "TextChanged,TextChangedI",
})

-- press <Tab> to expand or jump in a snippet. These can also be mapped
-- separately via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
vim.cmd("imap <expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'")
vim.cmd("inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>")
vim.cmd("snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>")
vim.cmd("snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>")
-- For changing choices in choiceNodes (not strictly necessary for a basic setup).
vim.cmd("imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'")
vim.cmd("smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'")

-- 🔮 LSP config
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wl', function()
	  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- LSP Python
require('lspconfig')['pyright'].setup{
	on_attach = on_attach,
}

-- LSP Bash
require('lspconfig')['bashls'].setup{}

-- LSP Rust, auto-format on save
-- https://rust-analyzer.github.io/manual.html#nvim-lsp
-- let g:rustfmt_autosave = 1
require('lspconfig')['rust_analyzer'].setup{
	on_attach = on_attach,
	-- Server-specific settings...
	settings = {
		["rust-analyzer"] = {}
	}
}

-- LSP Golang
local util = require "lspconfig.util"
require('lspconfig')['gopls'].setup{
	cmd = {"gopls", "serve"},
	filetypes = {"go", "gomod"},

	-- Ignore typical project roots which cause gopls to ingest large monorepos.
	--root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	root_dir = util.root_pattern("main.go", "README.md", "LICENSE"),

	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,

			-- Don't try to find the go.mod file, otherwise we ingest large monorepos
			expandWorkspaceToModule = false,
			memoryMode = "DegradeClosed",
			directoryFilters = {
				"-vendor",
				"-manifests",
			},
		},
	},

	on_attach = on_attach,
}

-- LSP config for Go
-- On save, organise imports like goimports
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#imports
function go_org_imports(wait_ms)
	local params = vim.lsp.util.make_range_params()
	params.context = {only = {"source.organizeImports"}}
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
	for cid, res in pairs(result or {}) do
		for _, r in pairs(res.result or {}) do
			if r.edit then
				local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
				vim.lsp.util.apply_workspace_edit(r.edit, enc)
			end
		end
	end
end
vim.cmd("autocmd BufWritePre *.go lua go_org_imports()")

-- On save, organise imports
vim.cmd("autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)")

-- 🧪 Testing with vim-test
vim.keymap.set('n', '<leader>t', ':TestNearest<CR>', { noremap = true })
vim.keymap.set('n', '<leader>T', ':TestFile<CR>', { noremap = true })
vim.keymap.set('n', '<leader>l', ':TestLast<CR>', { noremap = true })
vim.cmd("let test#strategy = 'dispatch'")

-- 🦾 Terminal mode
-- Use Esc to go to normal-terminal mode (C-c to exit terminal overlays like
-- Telescope and FZF)
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
vim.keymap.set('t', '<C-v><Esc>', '<Esc>', { noremap = true })
-- highlight the terminal cursor (from Modern Vim)
vim.cmd("highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15")
-- window switching (from Modern Vim)
-- normal mode
vim.keymap.set('n', '<M-h>', '<c-w>h', { noremap = true })
vim.keymap.set('n', '<M-j>', '<c-w>j', { noremap = true })
vim.keymap.set('n', '<M-k>', '<c-w>k', { noremap = true })
vim.keymap.set('n', '<M-l>', '<c-w>l', { noremap = true })
-- insert mode
vim.keymap.set('i', '<M-h>', '<Esc><c-w>h', { noremap = true })
vim.keymap.set('i', '<M-j>', '<Esc><c-w>j', { noremap = true })
vim.keymap.set('i', '<M-k>', '<Esc><c-w>k', { noremap = true })
vim.keymap.set('i', '<M-l>', '<Esc><c-w>l', { noremap = true })
-- visual mode
vim.keymap.set('v', '<M-h>', '<Esc><c-w>h', { noremap = true })
vim.keymap.set('v', '<M-j>', '<Esc><c-w>j', { noremap = true })
vim.keymap.set('v', '<M-k>', '<Esc><c-w>k', { noremap = true })
vim.keymap.set('v', '<M-l>', '<Esc><c-w>l', { noremap = true })
-- terminal mode
vim.keymap.set('t', '<M-l>', '<c-\\><c-n><c-w>l', { noremap = true })
vim.keymap.set('t', '<M-j>', '<c-\\><c-n><c-w>j', { noremap = true })
vim.keymap.set('t', '<M-k>', '<c-\\><c-n><c-w>k', { noremap = true })
vim.keymap.set('t', '<M-l>', '<c-\\><c-n><c-w>l', { noremap = true })

-- Don't nest nvim sessions, use nvr (from Modern Vim)
if vim.fn.executable("nvr") then
	vim.env.VISUAL = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
end
