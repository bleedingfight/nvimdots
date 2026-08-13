-- Please check `lua/core/settings.lua` to view the full list of configurable settings
local settings = {}

settings["use_ssh"] = false

settings["colorscheme"] = "catppuccin"

settings["use_copilot"] = true

settings["lsp_deps"] = function(defaults)
	return {
		defaults[1], -- bashls
		defaults[2], -- clangd
		defaults[3], -- html
		defaults[4], -- jsonls
		defaults[5], -- lua_ls
		"pyright", -- Python navigation: definition/hover/references (ruff handles lint+format)
		"ruff", -- Python: lint + format (mason-lspconfig 1.32 renamed ruff_lsp -> ruff)
		"rust_analyzer", -- lspconfig name (mason-lspconfig handler defers to rustaceanvim; mason package is "rust-analyzer")
	}
end

settings["dap_deps"] = function(defaults)
	return {
		defaults[0], -- C-Family
		defaults[2], -- Python (debugpy)
	}
end

settings["null_ls_deps"] = function(defaults)
	return {
		defaults[0],
		defaults[3],
		defaults[4],
		defaults[5],
		defaults[5], -- markdownlint-cli2
		"stylua",
	}
end

settings["treesitter_deps"] = function(defaults)
	return {
		defaults[0],
		defaults[1],
		defaults[2],
		defaults[3],
		defaults[6],
		defaults[7],
		defaults[8],
		defaults[9],
		defaults[11],
		defaults[12],
		defaults[13],
		defaults[14],
		defaults[15],
		defaults[16],
		defaults[17],
		defaults[19],
		"cuda",
		"slint",
		"yaml",
		"typst",
	}
end

-- Disable the following two plugins
settings["disabled_plugins"] = {
	"ray-x/go.nvim",
}
return settings
