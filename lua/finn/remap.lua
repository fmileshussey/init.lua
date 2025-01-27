vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- TODO this isn't auto indenting for some reason
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Moves selection up' })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Moves selection down' })

vim.keymap.set("n", "J", "mzJ`z", { desc = 'Moves line underneath, keeps cursor' })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Half page down, centers cursor' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Half page up, centers cursor' })
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })

-- vim.keymap.set('n', '<leader>bb', '<C-o>', { desc = 'Go back (jump list)' })
-- vim.keymap.set('n', '<leader>bf', '<C-i>', { desc = 'Go forward (jump list)' })

-- TODO need to look into this?
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'Format document' })
