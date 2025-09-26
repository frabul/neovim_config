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
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = "AIzaSyDiydMa0tVfZFNnBoLShu1fBF9pBJEzVQI",
            },
          })
        end,
        openrouter = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://openrouter.ai/api",
              api_key = "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",
              chat_url = "/v1/chat/completions",
            },
            schema = {
              model = {
                default = "x-ai/grok-4-fast:free",
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
