local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = 'Find References' })

vim.keymap.set('n', '<leader>fw', builtin.lsp_dynamic_workspace_symbols, {
  desc = "Find workspace symbols"
})
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {
  desc = "Find symbols in current buffer"
})
