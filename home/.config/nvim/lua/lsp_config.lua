-- LSP configuration
--
-- For some baseline configs, see:
--
--     https://github.com/golang/tools/blob/master/gopls/doc/vim.md#imports
--     https://www.getman.io/posts/programming-go-in-neovim/
--     https://github.com/neovim/nvim-lspconfig
--

-- See logs with
--
--     :lua vim.cmd('e'..vim.lsp.get_log_path())
--     tail -f ~/.cache/nvim/lsp.log
--
--vim.lsp.set_log_level("debug")

function on_attach(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	-- Mappings.
	local opts = {
		noremap=true,
		silent=true
	}
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'ga', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	elseif client.resolved_capabilities.document_range_formatting then
		buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end

	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec([[
		hi LspReferenceRead cterm=bold ctermbg=DarkMagenta guibg=LightYellow
		hi LspReferenceText cterm=bold ctermbg=DarkMagenta guibg=LightYellow
		hi LspReferenceWrite cterm=bold ctermbg=DarkMagenta guibg=LightYellow
		augroup lsp_document_highlight
		autocmd! * <buffer>
		autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
		autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
		augroup END
		]], false)
	end
end

-- Organise imports like goimports
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

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

-- Setup Go LSP client
lspconfig.gopls.setup {
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
