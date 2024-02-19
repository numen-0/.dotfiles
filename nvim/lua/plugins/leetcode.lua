return {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim", -- required by telescope
        "MunifTanjim/nui.nvim",

        -- optional
        "nvim-treesitter/nvim-treesitter",
        "rcarriga/nvim-notify",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("leetcode").setup({
            ---@type lc.lang
            lang = "c",

            injector = {
                ["c"] = {
                    before = {
                        "#include <stdio.h>",
                        "#include <string.h>",
                        "#include <stdlib.h>",
                    },
                    after = {},
                },
            }, ---@type table<lc.lang, lc.inject>
        })
    end,
}
