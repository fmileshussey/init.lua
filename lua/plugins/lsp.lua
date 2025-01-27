return {
    {
        'neovim/nvim-lspconfig',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        config = function()
            local lspconfig = require("lspconfig")
            local on_attach = function(client, bufnr)
                -- Here you can define keybindings or other LSP-related configs
                local opts = { noremap = true, silent = true, buffer = bufnr }
                -- Examples of typical LSP keymaps
                vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
                vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
                -- if client.server_capabilities.documentFormattingProvider then
                --     vim.keymap.set("n", "<leader>f", function()
                --         vim.lsp.buf.format({ async = true })
                --     end, { buffer = bufnr, desc = "Format code" })
                -- end
            end

            local capabilities = require("cmp_nvim_lsp")
                and require("cmp_nvim_lsp").default_capabilities()
                or vim.lsp.protocol.make_client_capabilities()

            -- Lua (lua_ls)
            lspconfig.lua_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            -- Make the server recognize 'vim' as a global
                            globals = { "vim" },
                        },
                        workspace = {
                            checkThirdParty = false, -- Avoid prompting for .luarc.json
                        },
                    },
                },
            })

            -- TypeScript (tsserver)
            lspconfig.ts_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                -- If you use denols for certain projects, you may want to disable
                -- tsserver in those projects or have a root_dir function that picks
                -- between denols and tsserver.
            })

            -- Svelte
            lspconfig.svelte.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
            lspconfig.zls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                -- By default, the root_dir is found by scanning for a zls.json or a .git directory.
                -- You usually do not need to override this unless you have a special project structure.
                --
                -- Optional server-specific settings
                settings = {
                    zls = {
                        enable_snippets = true,
                        enable_inlay_hints = true,
                        -- more zls config options...
                    },
                },

            })
            lspconfig.eslint.setup({
                on_attach = function(client, bufnr)
                    -- Enable auto-fixing on save
                    if client.server_capabilities.documentFormattingProvider then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            command = "EslintFixAll",
                        })
                    end
                end,
            })
        end,
    },
    { 'hrsh7th/cmp-nvim-lsp' },
    {
        'hrsh7th/nvim-cmp',
        dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip' },
        event = "InsertEnter",
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            -- Keymaps for nvim-cmp
            local cmp_mappings = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),            -- Trigger completion menu
                ["<C-e>"] = cmp.mapping.abort(),                   -- Close completion menu
                ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            })

            -- nvim-cmp setup
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp_mappings,
                sources = {
                    { name = "nvim_lsp" }, -- LSP source
                    { name = "luasnip" },  -- Snippets source
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                formatting = {
                    format = function(entry, vim_item)
                        -- Customize completion menu appearance
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snippet]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
            })
        end,
    },
}
