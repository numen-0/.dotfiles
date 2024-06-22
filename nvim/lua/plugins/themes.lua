return {
    {
        "judah-caruso/film-noir",
        name = "film_noir",
        priority = 1000,
        config = function() end,
    },
    {
        "ntk148v/habamax.nvim",
        name = "habamax",
        dependencies = { "rktjmp/lush.nvim" },
        priority = 1000,
        config = function() end,
    },
    {
        dir = "~/stuff/code/leun",
        name = "leun",
        dependencies = { "rktjmp/lush.nvim" },
        config = function()
            -- green, rose, blue, red, yellow, orange, lime, purple, white, hotdog, doghot, militar
            vim.g.leun_flavour = "lime"

            vim.cmd("autocmd InsertEnter * highlight CursorLine guibg=#181818")
            vim.cmd("autocmd InsertLeave * highlight CursorLine guibg=#121212")
        end,
    }
}
