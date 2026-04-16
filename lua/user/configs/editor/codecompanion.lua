return function()
	require("codecompanion").setup({
		extensions = {
			mcphub = {
				callback = "mcphub.extensions.codecompanion",
				opts = {
					make_vars = true,
					make_slash_commands = true,
					show_result_in_chat = true,
				},
			},
		},
		adapters = {
			fireworks = function()
				return require("codecompanion.adapters").extend("openai_compatible", {
					env = {
						url = vim.env.OPENAI_URL,
						api_key = vim.env.OPENAI_API_KEY,
						chat_url = "/chat/completions",
					},
					opts = {
						log_level = "DEBUG",
						language = "Chinese",
						stream = true,
					},
					schema = {
						model = {
							default = vim.env.OPENAI_MODEL_NAME,
						},
						max_tokens = {
							default = 128000,
						},
					},
					handlers = {
						form_parameters = function(self, params, messages)
							-- 过滤掉 content 为 nil 或空字符串的消息，避免 API 报 "must not be empty"
							-- content 为 table（多模态 parts）时保持原样传递
							local cleaned_messages = {}
							for _, msg in ipairs(messages) do
							local content = msg.content
							if content == nil then
								goto continue
							end
							if type(content) == "string" and vim.trim(content) == "" then
								goto continue
							end
							if type(content) == "table" and vim.tbl_isempty(content) then
								goto continue
							end
								table.insert(cleaned_messages, {
									role = msg.role,
									content = content,
								})
								::continue::
							end

							-- Create a copy of parameters to avoid modifying original
							local parameters = vim.deepcopy(params)

							-- Flatten nested 'options' into top-level parameters
							if parameters.options then
								for k, v in pairs(parameters.options) do
									parameters[k] = v
								end
								parameters.options = nil
							end

						return {
							model = parameters.model,
							messages = cleaned_messages,
							stream = true,
							temperature = parameters.temperature,
							max_tokens = parameters.max_tokens,
							top_p = parameters.top_p,
							top_k = parameters.top_k,
						}
						end,
					},
				})
			end,
		},
		strategies = {
			chat = {
				adapter = "fireworks",
			},
			inline = {
				adapter = "fireworks",
			},
		},
	})
end
