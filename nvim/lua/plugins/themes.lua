local group = vim.api.nvim_create_augroup("Themes_cmds", { clear = true })
return {
    {
        "judah-caruso/film-noir",
        lazy = true,
        name = "film_noir",
        event = "VeryLazy",
        priority = 1000,
        init = function()
            vim.g.film_noir_color = "green"

            require("autocmds").new('ColorScheme', {
                callback = function()
                    vim.cmd("hi String ctermbg=None guibg=None")
                    vim.cmd("hi Comment ctermbg=None guibg=None")
                    vim.cmd("hi Number ctermbg=None guibg=None")
                    vim.cmd("hi SignColumn ctermbg=None guibg=None")
                    vim.cmd("hi Normal ctermbg=None guibg=None")
                    vim.cmd("hi Keyword ctermbg=None guibg=None gui=bold")
                    vim.cmd("hi Constant ctermbg=None guibg=None")
                    vim.cmd("hi link SpecialChar String")
                    vim.cmd("hi SpecialChar gui=bold")

                    vim.cmd("hi SignColumn guibg=None")
                    vim.cmd("hi VertSplit ctermbg=None guibg=None guifg=#9e9e9e")
                    vim.cmd("hi WinSeparator ctermbg=None guibg=None guifg=#9e9e9e")

                    local flavour = vim.g.film_noir_color
                    if flavour == "green" then
                        vim.cmd("hi StatusLine guifg=#9fff54 guibg=None gui=None")
                    elseif flavour == "red" then
                        vim.cmd("hi StatusLine guifg=#ff549f guibg=None gui=None")
                    elseif flavour == "blue" then
                        vim.cmd("hi StatusLine guifg=#549fff guibg=None gui=None")
                    end

                    require("utils").gen_hl_from_link("StatusLineNC", "StatusLine",
                        { fg = "None" })
                end,
                group    = group,
                pattern  = "film_noir",
                desc     = "Make some changes to film_noir colorscheme after load",
            })
        end,
    },
    {
        "ntk148v/habamax.nvim",
        lazy = true,
        name = "habamax",
        dependencies = { "rktjmp/lush.nvim" },
        priority = 1000,
        init = function()
            require("autocmds").new('ColorScheme', {
                callback = function()
                    vim.cmd("hi VertSplit    ctermbg=None guibg=None guifg=#9e9e9e")
                    vim.cmd("hi StatusLine   guifg=#9e9e9e guibg=#1c1c1c")
                    vim.cmd("hi StatusLineNC guibg=#1c1c1c")
                    vim.cmd("hi WinSeparator ctermbg=None guibg=None guifg=#9e9e9e")
                end,
                group    = group,
                pattern  = "habamax",
                desc     = "Make some changes to habamax colorscheme after load",
            })
        end,
    },
    {
        dir = "~/stuff/code/leun",
        lazy = false,
        name = "leun",
        dependencies = { "rktjmp/lush.nvim" },
        config = function()
            local leun = require("leun")

            leun.setup({
                flavour = "beetroot",
                mark_list = {
                    "lime", "beetroot", "red"
                },
            })
            leun.load()

            -- [optional]
            -- change flav. using the mark list
            local mappings = require("mappings")
            mappings.map2("n", "<leader><up>",   leun.prev_mark, {})
            mappings.map2("n", "<leader><down>", leun.next_mark, {})

            -- extra highlight for the CursorLine
            vim.cmd("autocmd InsertEnter * highlight CursorLine guibg=#181818")
            vim.cmd("autocmd InsertLeave * highlight CursorLine guibg=#121212")
        end,
    }
}
