-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Swap LazyVim default keymaps for Snacks Explorer and Picker

-- Remove the LazyVim defaults
vim.keymap.del("n", "<leader>e")
vim.keymap.del("n", "<leader><leader>")

-- Assign new ones
vim.keymap.set("n", "<leader><leader>", function()
  require("snacks").explorer()
end, { desc = "Open File Explorer (Swapped)" })

vim.keymap.set("n", "<leader>e", function()
  require("snacks.picker").files()
end, { desc = "Find Files (swapped)" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "go down half a page" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "go up half a page" })
