return function()
	require("codecompanion").setup({
		adapters = {
			fireworks = function()
				return require("codecompanion.adapters").extend("openai_compatible", {
					env = {
						url = vim.env.OPENAI_URL,
						api_key = vim.env.OPENAI_API_KEY,
						chat_url = "/chat/completions",
					},
					schema = {
						model = {
							default = vim.env.OPENAI_MODEL_NAME,
						},
						max_tokens = {
							default = 128000,
						},
					},
					parameters = {
						stream = true,
					},
					handlers = {
						form_parameters = function(self, params, messages)
							-- Clean messages by extracting only role and content
							-- This removes extra fields like id, opts, cycle that API doesn't accept
							local cleaned_messages = {}
							for _, msg in ipairs(messages) do
								table.insert(cleaned_messages, {
									role = msg.role,
									content = msg.content,
								})
							end

							-- Create a copy of parameters to avoid modifying original
							local parameters = vim.deepcopy(params)

							-- Flatten nested 'options' into top-level parameters
							-- This ensures all configuration options are at the root level
							if parameters.options then
								for k, v in pairs(parameters.options) do
									parameters[k] = v
								end
								parameters.options = nil
							end

							-- Return a clean parameter object for the API request
							return {
								model = parameters.model,
								messages = cleaned_messages,
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
		opts = {
			log_level = "DEBUG",
			language = "Chinese",
		},
	})
end
