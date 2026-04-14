-- Must be set before any plugin loads to prevent Nvim 0.12 async treesitter
-- parse crashes ("attempt to call method 'range' (a nil value)").
vim.g._ts_force_sync_parsing = true

if not vim.g.vscode then
	require("core")
end
