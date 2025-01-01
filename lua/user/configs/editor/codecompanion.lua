return function()
	require("codecompanion").setup({
		strategies = {
			chat = {
				adapter = "ollama",
			},
			inline = {
				adapter = "openai_compatible",
			},
		},
		opts = {
			log_level = "DEBUG",
			language = "Chinese",
		},
		adapters = {
			ollama = function()
				return require("codecompanion.adapters").extend("openai_compatible", {
					schema = {
						model = {
							default = "deepseek-chat",
						},
					},
					env = {
						url = "https://api.deepseek.com",
						api_key = function()
							return os.getenv("OPENAI_API_KEY")
						end,
						chat_url = "/chat/completions", -- optional: default value, override if different
					},
				})
			end,
		},
	})
end
