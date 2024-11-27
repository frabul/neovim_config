-- Confgiguration for the completion plugins
require("cmp.types.cmp")
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
      --- Use <TAB> instead of <CR> to confirm auto complete item
      local mapping = opts.mapping
      -- remove the default <CR> mapping
      mapping["<CR>"] = nil
      mapping["<Tab>"] = function(fallback)
        -- we use tab also to jump to the next snippet field
        if vim.snippet.active() then
          vim.snippet.jump(1)
        else
          local f = LazyVim.cmp.confirm({ select = true })
          return f(fallback)
        end
      end
    end,
  },
  { "saadparwaiz1/cmp_luasnip" },
  {
    "garymjr/nvim-snippets",
    enabled = false,
  },
}
