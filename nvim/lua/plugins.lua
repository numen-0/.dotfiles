return {
    {
        "lukas-reineke/virt-column.nvim",
        config = function()
            require("virt-column").setup({
                char = "▕",
            })
        end
    },
    {
        "numToStr/Comment.nvim",
        lazy = false,
        config = function()
            require("Comment").setup({})
        end,
    },
    {
        "mbbill/undotree",
        lazy = false,
        config = function()
            vim.g.undotree_WindowLayout = 3
            vim.g.undotree_DiffAutoOpen = false
            vim.g.undotree_HelpLine = false
            require("mappings").map2("n", "<leader>u", vim.cmd.UndotreeToggle)
        end,
    },
    {
        "NvChad/nvim-colorizer.lua",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },

        config = function()
            require("colorizer").setup({
                filetypes = {
                    css  = { names = true, rgb_fn = true, hsl_fn = true },
                    html = { names = true },
                    "lua",
                    "vim",
                },
                user_default_options = {
                    names = false,
                },
                buftypes = {},
            })
        end,
    },
    {
        "RRethy/vim-illuminate",
        config = function()
            require('illuminate').configure({
                providers = {
                    'lsp',
                    'treesitter',
                    'regex',
                },
                delay = 100,
                filetypes_denylist = {
                    'dirbuf',
                    'dirvish',
                    'fugitive',
                },
                under_cursor = true,
                large_file_cutoff = nil,
                large_file_overrides = nil,
                min_count_to_highlight = 1,
                should_enable = function(_) return true end,
                case_insensitive_regex = false,
            })
        end
    },
    {
        "karb94/neoscroll.nvim",
        config = function()
            require('neoscroll').setup({
                easing = "sine",
                mappings = {
                    '<C-u>', '<C-d>',
                    '<C-b>', '<C-f>',
                    '<C-y>', '<C-e>',
                    'zt', 'zz', 'zb',
                },
            })
        end
    },
    {
        dir = "~/stuff/code/magic_macro",
        config = function()
            require("mappings").map2("v", "<leader>mm", require("magic_macro").do_the_magic, {})
        end,
    }
}
