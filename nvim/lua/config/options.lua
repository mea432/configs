-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Winbar. Now moved to autocmds.lua
--vim.opt.winbar = "%=%m %f "

-- Disable mouse
vim.opt.mouse = ""
vim.opt.mousescroll = "ver:0,hor:0"

-- Disable cursor line since it blocks the background
vim.opt.cursorline = false
