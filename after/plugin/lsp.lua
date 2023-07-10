local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'rust_analyzer',
  'jdtls',
})

-- fix undefined global 'vim'
lsp.nvim_workspace()


local cmp = require('cmp')
-- local cmp_select = {behavior = cmp.selectbehavior.select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  --['<c-p>'] = cmp.mapping.select_prev_item(cmp_select),
  -- ['<c-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<c-y>'] = cmp.mapping.confirm({ select = true }),
  ["<c-space>"] = cmp.mapping.complete(),
})

cmp_mappings['<tab>'] = nil
cmp_mappings['<s-tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.configure('jdtls', {
  settings = {
    java = {
      saveActions = {
        organizeImports = true,
      }
    }
  },
  
  on_attach = function(client, bufnr)
    print('JDT Language Server attached')
  end
})


lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'e',
        warn = 'w',
        hint = 'h',
        info = 'i'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "k", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<c-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

