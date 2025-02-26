return {
    "hrsh7th/nvim-cmp",
    lazy = false,
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "neovim/nvim-lspconfig",

        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",

        "onsails/lspkind.nvim",
    },
    config = function()
        vim.opt.completeopt = { "menu", "menuone", "preview", "noselect" }
        local cmp = require("cmp")
        local lspkind = require("lspkind")
        local luasnip = require("luasnip")

        cmp.setup({
            sources = cmp.config.sources({
                { name = "nvim_lua" },
                { name = "luasnip" },
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "path" },
            }),
            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Inset }),
                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Inset }),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<C-y>"] = cmp.mapping(
                    cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    }), { "i", "c" }
                ),
            }),
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                completion    = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol",
                    show_labelDetails = true,
                    menu = {
                        buffer   = "[buff]",
                        nvim_lsp = "[lsp]",
                        nvim_lua = "[api]",
                        path     = "[path]",
                        luasnip  = "[snip]",
                    },
                }),
            },
            experimental = {
                ghost_text = true,
            }
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
        })
        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            }
        })

        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lspconfig = require("lspconfig")
        local servers = {
            "lua_ls",
            "clangd",
            "bashls",
            "cssls",
            "html",
            "jdtls",
            -- "basedpyright",
            "pyright",
            "biome",
            "html",
        }
        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup({
                capabilities = capabilities,
            })
        end
    end,
}
