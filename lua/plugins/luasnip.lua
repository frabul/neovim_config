return {

    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
      dependencies = { "rafamadriz/friendly-snippets" },
      config = function()
        print("Loading the snippets")
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    {
      "hrsh7th/nvim-cmp",
      dependencies = { "saadparwaiz1/cmp_luasnip" },
      ---@param opts cmp.ConfigSchema
      opts = function(_, opts)
        table.insert(opts.sources, { name = "luasnip" })
      end,
    },
    { "saadparwaiz1/cmp_luasnip" },
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
  
    {
      "garymjr/nvim-snippets",
      enabled = false,
    },
  }
  