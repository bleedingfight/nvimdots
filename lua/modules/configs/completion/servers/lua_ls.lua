-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/lua_ls.lua
return {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
				disable = { "different-requires", "undefined-field" },
			},
			workspace = {
				library = {
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/lua",
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
			format = { enable = false },
			telemetry = { enable = false },
			-- Do not override treesitter lua highlighting with lua_ls's highlighting
			semantic = { enable = false },
		},
	},
}
