return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      strategies = {
        inline = {
          adapter = {
            name = "copilot",
            model = "GPT-5 mini",
          },
        },
        chat = {
          adapter = {
            name = "copilot",
            model = "GPT-5 mini",
          },
        },
        cmd = {
          adapter = {
            name = "copilot",
            model = "GPT-5 mini",
          },
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
                models_endpoint = "/v1/models",
              },
              handlers = {
                parse_message_meta = function(self, data)
                  local extra = data.extra
                  if extra and extra.reasoning then
                    data.output.reasoning = { content = extra.reasoning }
                    if data.output.content == "" then
                      data.output.content = nil
                    end
                  end
                  return data
                end,
              },
              schema = {
                ---@type CodeCompanion.Schema
                model = {
                  order = 1,
                  mapping = "parameters",
                  type = "enum",
                  desc = "ID of the model to use. See the model endpoint compatibility table for details on which models work with the Chat API.",
                  default = "minimax/minimax-m2",
                  choices = function(self)
                    local get_models = require("openrouter_get_models")
                    return get_models(self)
                  end,
                },
              },
            })
          end,
          openrouter_no_reasoning = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "https://openrouter.ai/api",
                api_key = "OPENROUTER_API_KEY",
                chat_url = "/v1/chat/completions",
                models_endpoint = "/v1/models",
              },
              parameters = {
                reasoning = { enabled = false },
              },
              handlers = {
                parse_message_meta = function(self, data)
                  local extra = data.extra
                  if extra and extra.reasoning then
                    data.output.reasoning = { content = extra.reasoning }
                    if data.output.content == "" then
                      data.output.content = nil
                    end
                  end
                  return data
                end,
              },
              schema = {
                ---@type CodeCompanion.Schema
                model = {
                  order = 1,
                  mapping = "parameters",
                  type = "enum",
                  desc = "ID of the model to use. See the model endpoint compatibility table for details on which models work with the Chat API.",
                  default = "minimax/minimax-m2",
                  choices = function(self)
                    local get_models = require("openrouter_get_models")
                    return get_models(self)
                  end,
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
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      model = "auto",
    },
  },
  {
    "folke/sidekick.nvim",
    opts = {
      nes = {
        enabled = false,
      },
      cli = {
        tools = {
          pi_sandboxed = {
            cmd = { "pi_sandboxed" },
            keys = {
              acx = {
                "<C-M-x>",
                function(t)
                  vim.api.nvim_chan_send(vim.bo[t.buf].channel, "\x1b[120;7u")
                end,
              },
            },
          },
        },
      },
    },
  },
}
