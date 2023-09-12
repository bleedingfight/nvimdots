-- Please check `lua/core/settings.lua` to view the full list of configurable settings
local settings = {}

-- Examples
settings["use_ssh"] = true

settings["colorscheme"] = "catppuccin"
settings["lsp_deps"] = {
	"bashls",
	"clangd",
	"html",
	"jsonls",
	"pylsp",
}

return settings
