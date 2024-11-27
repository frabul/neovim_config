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
