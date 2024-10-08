vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<leader>==", "<cmd>vertical resize +5<CR>", { desc = "Increase size of current split" })
keymap.set("n", "<leader>--", "<cmd>vertical resize -5<CR>", { desc = "Decrease size of current split" })
