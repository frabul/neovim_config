return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    strategies = {
      inline = {
        adapter = "openrouter",
      },
      chat = {
        adapter = "gemini",
        keymaps = {
          completion = {
            modes = { i = "<C-;>" },
            index = 1,
            callback = "keymaps.completion",
            description = "Completion menu",
          },
        },
      },
      cmd = {
        adapter = "openrouter",
      },
    },
    adapters = {
      http = {
        openrouter = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://openrouter.ai/api",
              api_key = "OPENROUTER_API_KEY",
              chat_url = "/v1/chat/completions",
            },
            schema = {
              model = {
                -- default = "nvidia/nemotron-nano-9b-v2:free",
                default = "qwen/qwen3-coder:free",
              },
            },
          })
        end,
      },
    },
    -- NOTE: The log_level is in `opts.opts`
    opts = {
      log_level = "TRACE",
    },
  },
}
