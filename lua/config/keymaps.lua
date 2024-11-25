-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Open buffer symbols in the Trouble window
local map = LazyVim.safe_keymap_set
map(
  "n",
  "<Space>xs",
  "<cmd>Trouble lsp_document_symbols win.position=right<CR>",
  { desc = "(Trouble) Open buffer symbols" }
)
-- Override <leader>ft: open terminal in the current file's directory
map("n", "<leader>ft", function()
  local buffer_path = vim.api.nvim_buf_get_name(0)
  local buffer_dir = vim.fn.fnamemodify(buffer_path, ":h")
  Snacks.terminal(nil, { cwd = buffer_dir })
end, { desc = "Terminal (Buffer dir)" })
