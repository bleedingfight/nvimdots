return function()
	require("img-clip").setup({
		opts = {
			filetypes = {
				codecompanion = {
					prompt_for_file_name = false,
					template = "[Image]($FILE_PATH)",
					use_absolute_path = true,
				},
			},
		},
	})
end
