return {
    {
        "lukas-reineke/virt-column.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        opts = { char = "▕", },
    },
    {
        "smjonas/inc-rename.nvim",
        lazy = true,
        event = { 'LspAttach' },
        opts = {},
        init = function()
            vim.keymap.set("n", "<leader>rn", function()
                return ":IncRename " .. vim.fn.expand("<cword>")
            end, { expr = true })
        end
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
            require("mappings").map2("n", "<leader>u", vim.cmd.UndotreeToggle)
        end,
    },
    {
        "NvChad/nvim-colorizer.lua",
        lazy = true,
        -- event = { "BufReadPost", "BufNewFile" },
        ft = { "css", "html", "lua", "vim" },
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
        },
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
        cmd = "DuckyType",
        opts = {
            expected = "english_common",
            number_of_words = 60,
            average_word_length = 5.8,

            window_config = {
                border = "single",
            },

            highlight = {
                good      = "Constant",
                bad       = "DiagnosticError",
                remaining = "Normal",
            },
        },
    },
    {
        "OXY2DEV/markview.nvim",
        enabled = false,
        lazy = true,
        ft = "markdown",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
    },
    -- local plugs --
    {
        dir = "~/stuff/code/magic_macro.nvim",
        enabled = false,
        lazy = true,
        ft = { "c" },
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
        dir = "~/stuff/code/lumberjack.nvim",
        config = function()
            require("lumberjack").setup({})
        end,
    },
    {
        dir = "~/stuff/code/sketch.nvim",
        config = function()
            require("sketch").setup({})
        end,
    },
    {
        dir = "~/stuff/code/glide.nvim",
        config = function()
            require("glide").setup({})
        end,
    },
    {
        dir = "~/stuff/code/beta.nvim",
        priority = 500,
        opts = {
            logo         = {
                lines = {
                    [[┳┓    ┓┏•    ]],
                    [[┃┃┏┓┏┓┃┃┓┏┳┓ ]],
                    [[┛┗┗ ┗┛┗┛┗┛╹┗•]],
                },
                align = { offset = 0, style = "center" },
            },
            text         = {
                lines = {
                    [["An idiot admires complexity, a genius admires simplicity"]],
                    [[                                            Terry A. Davis]],
                },
                align = { offset = 0, style = "center" },
            },
            gap          = 0,
            user_command = false,
            hide_cursor  = false,
            unload_after = true,
        },
    },
}
