return function()
	require("codecompanion").setup({
		strategies = {
			chat = {
				adapter = "ollama",
<<<<<<< HEAD
			},
			inline = {
				adapter = "openai_compatible",
=======
				roles = {
					llm = "AI Assistant:",
					user = "Me:",
				},
			},

			inline = {
				adapter = "ollama",
>>>>>>> 39694ba (修改配置文件)
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
<<<<<<< HEAD
							default = "deepseek-chat",
						},
					},
					env = {
						url = "https://api.deepseek.com",
						api_key = function()
							return os.getenv("OPENAI_API_KEY")
						end,
						chat_url = "/chat/completions", -- optional: default value, override if different
=======
							default = "gpt-4",
						},
					},
					env = {
						url = "https://api.360.cn",
						api_key = function()
							return os.getenv("OPENAI_API_KEY")
						end,
						chat_url = "/v1/chat/completions", -- optional: default value, override if different
>>>>>>> 39694ba (修改配置文件)
					},
				})
			end,
		},
	})
end
