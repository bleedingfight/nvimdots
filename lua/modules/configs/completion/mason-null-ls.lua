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
		},
	})
end

return M
