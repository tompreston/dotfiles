require("lsp_config")

-- ⚙️  Options
vim.opt.background = "light"
vim.opt.colorcolumn = "101"
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

-- 🐻 Fuzzy finder
-- The vim.fzf interface is much faster than Telescope and this related issue
-- was closed.
-- https://github.com/nvim-telescope/telescope.nvim/issues/1837#issuecomment-1113962736
--
-- Use the Telescope shortcut to launch it. If it gets fixed in telescope
-- switch back over.
-- TODO look into this.
vim.keymap.set('n', '<leader>ff', ':<C-u>FZF<CR>', { noremap = true })

-- 🔭 Telescope
local telescopebuiltin = require('telescope.builtin')
-- Use fzf.vim instead of Telescope.find_files because it's faster
--vim.keymap.set('n', '<leader>ff', telescopebuiltin.find_files)
vim.keymap.set('n', '<leader>fg', telescopebuiltin.live_grep)
vim.keymap.set('n', '<leader>fb', telescopebuiltin.buffers)
vim.keymap.set('n', '<leader>fh', telescopebuiltin.help_tags)

local telescope = require('telescope')
telescope.setup()
telescope.load_extension('fzf')

-- ✂️  Snippets
require("luasnip.loaders.from_vscode").lazy_load({
	paths = { "./friendly-snippets" }
})
require("luasnip").setup({
	-- Update more often, :h events for more info.
	update_events = "TextChanged,TextChangedI",
})

-- press <Tab> to expand or jump in a snippet. These can also be mapped separately
-- via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
vim.cmd("imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'")
vim.cmd("inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>")
vim.cmd("snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>")
vim.cmd("snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>")
-- For changing choices in choiceNodes (not strictly necessary for a basic setup).
vim.cmd("imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'")
vim.cmd("smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'")
