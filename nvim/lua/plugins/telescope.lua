return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            local map = require("mappings")
            map.map2("n", "<C-p>", builtin.find_files)
            map.map2("n", "<leader>fg", builtin.live_grep)
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            local telescope = require("telescope")

            local vimgrep_arguments = {
                "rg",
                -- "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--trim",
                -- hidden files
                "--hidden",
                "--glob",
                "!**/.git/*",
            }

            telescope.setup({
                defaults = {
                    -- `hidden = true` is not supported in text grep commands.
                    vimgrep_arguments = vimgrep_arguments,
                },
                pickers = {
                    find_files = {
                        find_command = { "rg", "--files", "--hidden", "--no-ignore", "--glob", "!**/.git/*" },
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            telescope.load_extension("ui-select")
        end,
    },
}
