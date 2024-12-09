return function() -- This file MUST return a function accepting no parameter and has no return value
	require("llm").setup({
  model = "codellama", -- the model ID, behavior depends on backend
  backend = "ollama", -- backend ID, "huggingface" | "ollama" | "openai" | "tgi"
  context_window = 4096,
  tokens_to_clear = { "<EOT>" },
  fim = {
    enabled = true,
    prefix = "<PRE> ",
    middle = " <MID>",
    suffix = " <SUF>",
  },
  url = "http://192.168.31.217:11434", -- the http url of the backend
  request_body = {
    parameters = {
      max_new_tokens = 60,
      temperature = 0.2,
      top_p = 0.95,
    },
  },
})
end
