return function()
	require("render-markdown").setup({
		file_types = { "markdown", "codecompanion" },
		render_modes = { "n", "c", "t", "i" },
		anti_conceal = {
			enabled = true,
			ignore = {
				code_background = true,
				sign = true,
			},
		},
		overrides = {
			buftype = {
				nofile = {
					render_modes = { "n", "c", "t", "i" },
					padding = { highlight = "NormalFloat" },
					sign = { enabled = false },
				},
			},
		},
	})
end
