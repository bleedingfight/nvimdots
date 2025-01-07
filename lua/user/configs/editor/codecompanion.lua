return function()
	require("codecompanion").setup({
		strategies = {
			chat = {
				adapter = "ollama",
				roles = {
					llm = "AI-Assistant",
					user = "Me",
				},
			},
			inline = {
				adapter = "ollama",
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
							default = "gpt-4",
						},
					},
					env = {
						url = "https://api.360.cn",
						api_key = function()
							return os.getenv("OPENAI_API_KEY")
						end,
						chat_url = "/v1/chat/completions", -- optional: default value, override if different
					},
				})
			end,
		},
	})
end
