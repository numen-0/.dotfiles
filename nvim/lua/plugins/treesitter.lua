return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            ensure_installed = { "lua", "javascript", "java", "c", "python" },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
