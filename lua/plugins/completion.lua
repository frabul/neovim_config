-- Confgiguration for the completion plugins
return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        ["<C-y>"] = { "select_and_accept" },
      },
    },
  },
  -- disable nvim-snippets because it does not work with VsCode snippets
  --  and use LuaSnip
  {
    "garymjr/nvim-snippets",
    enabled = false,
  },
}
