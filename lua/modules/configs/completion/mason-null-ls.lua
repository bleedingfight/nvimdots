local M = {}

M.setup = function()
	require("modules.utils").load_plugin("mason-null-ls", {
		ensure_installed = require("core.settings").null_ls_deps,
		automatic_installation = false,
		automatic_setup = true,
		handlers = {
			-- mdformat is installed via mason but we don't want it formatting
			-- markdown (no null-ls source registration at all).
			mdformat = function() end,
			-- Suppress automatic_setup for prettier; it is manually registered
			-- in null-ls.lua with an explicit filetype list that excludes markdown.
			-- Without this, automatic_setup would re-register prettier with its
			-- default filetypes (which include markdown), causing null-ls to format
			-- markdown even when no markdown-specific formatter is available.
			prettier = function() end,
		},
	})
end

return M
