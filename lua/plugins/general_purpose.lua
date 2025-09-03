return {
  {
    "eriks47/generate.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "folke/edgy.nvim",
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        ft = "copilot-chat",
        title = "Copilot Chat",
        size = { width = 50 },
      })
    end,
  },
  {
    "mikesmithgh/kitty-scrollback.nvim",
    enabled = true,
    lazy = true,
    cmd = {
      "KittyScrollbackGenerateKittens",
      "KittyScrollbackCheckHealth",
      "KittyScrollbackGenerateCommandLineEditing",
    },
    event = { "User KittyScrollbackLaunch" },
    -- version = '*', -- latest stable version, may have breaking changes if major version changed
    -- version = '^6.0.0', -- pin major version, include fixes and features that do not have breaking changes
    config = function()
      require("kitty-scrollback").setup()
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python", --optional
      { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    lazy = false,
    branch = "main", -- This is the regexp branch, use this for the new version
    keys = {
      { ",v", "<cmd>VenvSelect<cr>" },
    },
    ---@type venv-selector.Config
    opts = {
      -- Your settings go here
    },
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       rust_analyzer = {
  --         keys = {
  --           {
  --             "K",
  --             function()
  --               vim.cmd.RustLsp({ "hover", "actions" })
  --             end,
  --             desc = "Rust hover actions",
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
}
