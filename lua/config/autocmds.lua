-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local function set_kitty_window_title()
  print("Setting window title")
  local cwd = vim.fn.getcwd()
  vim.fn.system("kitty @ set-window-title NeoVim - " .. cwd .. " - " .. vim.fn.expand("%:t"))
end
-- run on VimEnter
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = set_kitty_window_title,
})
-- run set_kitty_window_title when the cwd changes
vim.api.nvim_create_autocmd("DirChanged", {
  pattern = "global",
  callback = set_kitty_window_title,
})
-- run set_kitty_window_title when the buffer changes
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = set_kitty_window_title,
})
