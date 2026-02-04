return function()
	vim.g.rustaceanvim = {
		dap = {
			autoload_configurations = true,
		},
		server = {
			default_settings = {
				["rust-analyzer"] = {
					checkOnSave = {
						command = "clippy",
					},
				},
			},
		},
	}

	require("modules.utils").load_plugin("rustaceanvim", nil, true)
end
