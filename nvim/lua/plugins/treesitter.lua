return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            highlight = {
                enable = true,
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            autotag = { enable = true, },
            ensure_installed = {
                "asm",
                "bash",
                "c",
                "gitignore",
                "html",
                "css",
                "javascript",
                "html",
                "lua",
                "markdown",
                "python",
                "vim",
                "vimdoc",
            },
            -- incremental_selection = { -- I dont use this
            --     enable = true,
            --     keymaps = {
            --         init_selection = "gnn",
            --         node_incremental = "grn",
            --         scope_incremental = "grc",
            --         node_decremental = "grm",
            --     },
            -- },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj

                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
            },
        })
    end
}
