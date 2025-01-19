return function()
	require("codecompanion").setup({
		strategies = {
			chat = {
				adapter = "ollama",
				roles = {
					llm = "AI-Assistant",
					user = "Me",
				},
				slash_commands = {
					file = {
						callback = "strategies.chat.slash_commands.file",
						description = "Insert a file",
						opts = {
							contains_code = true,
							max_lines = 1000,
							provider = "telescope", -- 这里可以修改为telescope|mini_pick|fzf_lua
						},
					},
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
