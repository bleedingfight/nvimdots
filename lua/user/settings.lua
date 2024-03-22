-- Please check `lua/core/settings.lua` to view the full list of configurable settings
local settings = {}

-- Examples
settings["use_ssh"] = true

settings["colorscheme"] = "catppuccin"

settings["use_copilot"] = false

settings["lsp_deps"] = {
	"bashls",
	"clangd",
	"html",
	"jsonls",
	"lua_ls",
	"pylsp",
	"rust_analyzer",
	"ruff_lsp",
}

settings["dap_deps"] = {
	"cpptools", -- C-Family
	"python", -- Python (debugpy)
}

settings["null_ls_deps"] = {
	"clang_format",
	"prettier",
	"shfmt",
	"stylua",
}
return settings
