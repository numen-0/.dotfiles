return {
    {
        "lukas-reineke/virt-column.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        opts = { char = "▕", }
    },
    {
        "numToStr/Comment.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("Comment").setup({})
            local ft = require('Comment.ft')
            ft.asm = "; %s"
        end,
    },
    {
        "mbbill/undotree",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        init = function()
            vim.g.undotree_WindowLayout       = 3
            vim.g.undotree_DiffAutoOpen       = false
            vim.g.undotree_HelpLine           = false
            vim.g.undotree_SetFocusWhenToggle = 1
            require("mappings").map2("n", "<leader>u", vim.cmd.UndotreeToggle) -- TODO: maybe this needs to go down here
        end,
    },
    {
        "NvChad/nvim-colorizer.lua",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        -- event = "VeryLazy",
        opts = {
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
        }
    },
    {
        "RRethy/vim-illuminate",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
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

            require("autocmds").new('ColorScheme', {
                callback = function()
                    vim.cmd("hi default IlluminatedWordText  gui=underline")
                    vim.cmd("hi default IlluminatedWordRead  gui=underline")
                    vim.cmd("hi default IlluminatedWordWrite gui=underline")
                end,
                pattern  = '*',
                desc     = "Reload vim-illuminate highlights"
            })
        end
    },
    {
        "karb94/neoscroll.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            easing = "sine",
            mappings = {
                '<C-u>', '<C-d>',
                '<C-b>', '<C-f>',
                '<C-y>', '<C-e>',
                'zt', 'zz', 'zb',
            },
        },
    },
    {
        'kwakzalver/duckytype.nvim',
        lazy = true,
        event = "VeryLazy",
        opts = {
            expected = "english_common",
            number_of_words = 60,
            average_word_length = 5.8,

            window_config = {
                border = "single",
            },

            highlight = {
                good = "Comment",
                bad = "Error",
                remaining = "keyword",
            },
        }
    },
    -- local plugs --
    {
        dir = "~/stuff/code/magic_macro",
        enabled = false,
        lazy = true,
        event = "VeryLazy",
        init = function()
            require("autocmds").new("FileType", {
                callback = function()
                    vim.keymap.set("v", "<leader>mm",
                        require("magic_macro").do_the_magic, { buffer = true })
                end,
                pattern  = 'c',
                desc     = "Do the magic"
            })
        end,
    },
    {
        dir = "~/stuff/code/lumberjack",
        config = function()
            require("lumberjack").setup({})
        end,
    },
    {
        dir = "~/stuff/code/beta",
        priority = 500,
        opts = {
            logo = {
                lines = {
                    [[┳┓    ┓┏•    ]],
                    [[┃┃┏┓┏┓┃┃┓┏┳┓ ]],
                    [[┛┗┗ ┗┛┗┛┗┛╹┗•]],
                },
                align = { offset = 0, style = "center" },
            },
            text = {
                lines = {
                    [["An idiot admires complexity, a genius admires simplicity"]],
                    [[                                            Terry A. Davis]],
                },
                align = { offset = 0, style = "center" },
            },
            gap = 0,
            user_command = false,
            hide_cursor = true,
            unload_after = true,
        }
    },
}
