-- Please check `lua/core/settings.lua` to view the full list of configurable settings
local settings = {}

-- Examples
settings["use_ssh"] = true

settings["colorscheme"] = "catppuccin"

settings["use_copilot"] = false

settings["lsp_deps"] = function(defaults)
	return {
		defaults[0],
		defaults[1],
		defaults[2],
		defaults[3],
		defaults[4],
		"ruff_lsp",
		"rust-analyzer",
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
		defaults[10],
		defaults[11],
		defaults[12],
		defaults[13],
		defaults[14],
		defaults[15],
		defaults[16],
		defaults[17],
		defaults[19],
	}
end
return settings
