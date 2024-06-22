return {
    {
        "L3MON4D3/LuaSnip",
        tag = "v2.2.0",
        build = "make install_jsregexp",
        dependencies = {
            "abecodes/tabout.nvim",
        },

        config = function()
            local luasnip = require("luasnip")

            luasnip.setup({
                history = true,
                update_events = { "TextChanged", "TextChangedI" },
                enable_autosnippets = true,
            })

            local function reload()
                for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/plugins/snip/*.lua", true))
                do
                    loadfile(ft_path)()
                end
            end; reload()

            local tabout = require("tabout")
            local map    = require("mappings")

            map.map2("n", "<leader><leader>s", reload)
            map.map2({ "i", "s" }, "<C-k>", function()
                if luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    tabout.tabout()
                end
            end, { silent = true })
            map.map2({ "i", "s" }, "<C-j>", function()
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    tabout.taboutBack()
                end
            end, { silent = true })
            map.map2({ "i", "s" }, "<C-l>", function()
                if luasnip.choice_active() then
                    luasnip.change_choice(1)
                end
            end, { silent = true })
        end
    },
    {
        'abecodes/tabout.nvim',
        lazy = false,
        opt = true,
        event = 'InsertCharPre',
        priority = 1000,

        config = function()
            require('tabout').setup {
                tabkey = '',
                backwards_tabkey = '',
                act_as_tab = true,
                act_as_shift_tab = false,
                default_tab = '<C-t>',
                default_shift_tab = '<C-d>',
                enable_backwards = true,
                completion = false,
                tabouts = {
                    { open = "'", close = "'" },
                    { open = '"', close = '"' },
                    { open = '`', close = '`' },
                    { open = '(', close = ')' },
                    { open = '[', close = ']' },
                    { open = '{', close = '}' }
                },
                ignore_beginning = true,
                exclude = {}
            }
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter"
        },
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },
}
