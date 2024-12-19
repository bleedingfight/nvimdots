return function()
require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "ollama",
    },
  },
  opts = {
    log_level = "DEBUG",
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
          url = "https://api.360.cn", -- optional: default value is ollama url http://127.0.0.1:11434
          api_key = "you api key", -- optional: if your endpoint is authenticated
          chat_url = "/v1/chat/completions", -- optional: default value, override if different
        },
      })
    end,
  },
})
end
