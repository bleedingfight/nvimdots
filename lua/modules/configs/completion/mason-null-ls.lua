local M = {}

M.setup = function()
	require("modules.utils").load_plugin("mason-null-ls", {
		ensure_installed = require("core.settings").null_ls_deps,
		automatic_installation = false,
		automatic_setup = true,
		handlers = {
			mdformat = function() end,
			-- Suppress automatic_setup for prettier; it is manually registered
			-- in null-ls.lua with an explicit filetype list that excludes markdown.
			-- Without this, automatic_setup would re-register prettier with its
			-- default filetypes (which include markdown), causing null-ls to format
			-- markdown even when no markdown-specific formatter is available.
			prettier = function() end,
			-- Pass --disable flags to markdownlint to suppress noisy rules.
			markdownlint = function(_source, _types)
				local null_ls = require("null-ls")
				null_ls.register(null_ls.builtins.diagnostics.markdownlint.with({
					extra_args = {
						"--disable",
						"MD013",
						"MD025",
						"MD033",
						"MD041",
						"MD055",
						"MD056",
						"MD058",
						"MD060",
						"MD103",
						"MD022",
					},
				}))
			end,
		},
	})
end

return M
