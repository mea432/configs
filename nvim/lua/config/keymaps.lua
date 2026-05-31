-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Faster insert mode exit
vim.keymap.set("i", "kj", "<Esc>", { desc = "Escape insert mode with kj" })

-- Resize splits using <leader> + arrows
vim.keymap.set("n", "<leader><Left>", "<C-w><", { desc = "Resize window left" })
vim.keymap.set("n", "<leader><Right>", "<C-w>>", { desc = "Resize window right" })
vim.keymap.set("n", "<leader><Up>", "<C-w>+", { desc = "Resize window up" })
vim.keymap.set("n", "<leader><Down>", "<C-w>-", { desc = "Resize window down" })

-- Paste over selection without yanking it
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without overwriting register" })

-- tmux sessionizer
-- vim.keymap.set("n", "<leader>t", "<cmd>silent !tmux neww ~/tmux-sessionizer.sh<CR>")
