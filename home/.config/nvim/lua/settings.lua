-- ⚙️  Options
vim.opt.background = "light"
vim.opt.colorcolumn = "101"
vim.opt.number = true
table.insert(vim.opt.path, "**")

-- Show listchars (inc. leading tabs)
vim.opt.list = true

-- Highlight all matches in incsearch. C-l to clear
vim.opt.hlsearch = true

-- Use fzf for file searching
-- https://github.com/junegunn/fzf/blob/master/README-VIM.md
table.insert(vim.opt.rtp, "/usr/local/opt/fzf")

-- projectionist
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

-- 🎹 Keymaps
vim.api.nvim_set_keymap('n', '<C-p>', ':<C-u>FZF<CR>', { noremap = true })

-- 🌈 Colors
-- :help highlight-groups
vim.api.nvim_set_hl(0, 'ColorColumn', {
	ctermbg = "LightGrey",
	ctermfg = "DarkRed"
})
vim.api.nvim_set_hl(0, 'Whitespace', {
	ctermfg = "LightGrey"
})
