Theme = {}
Theme.__index = Theme

vim.cmd("sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=")
vim.cmd("sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=")
vim.cmd("sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=")
vim.cmd("sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=")

-- https://github.com/omerxx/dotfiles/blob/master/nvim/lua/misc.ua
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({ higroup = "YankHighlight" })
    end,
    group = highlight_group,
    pattern = '*',
})

-- plugins hl
vim.cmd("hi default IlluminatedWordText  gui=underline")
vim.cmd("hi default IlluminatedWordRead  gui=reverse")
vim.cmd("hi default IlluminatedWordWrite gui=reverse")

vim.cmd("hi default DiffAdd    gui=reverse")
vim.cmd("hi default DiffChange gui=reverse")
vim.cmd("hi default DiffDelete gui=reverse")


-- https://www.reddit.com/r/neovim/comments/wcmqi7/a_simple_utility_function_to_override_and_update/
local function modify_hl(hl_name, opts)
    local is_ok, hl_def = pcall(vim.api.nvim_get_hl_by_name, hl_name, true)
    if is_ok then
        for k, v in pairs(opts) do hl_def[k] = v end
        vim.api.nvim_set_hl(0, hl_name, hl_def)
    end
end

local function fix()
    vim.cmd("hi default YankHighlight guifg=black guibg=white gui=bold")

    vim.cmd("hi default link StatuslineBold Statusline")
    modify_hl("StatuslineBold", { bold = true })
end

---def.: lime
---@param flavour string | nil {green, rose, blue, red, yellow, orange, lime, purple, white, hotdog, doghot, militar}
function Theme.leun(flavour)
    vim.g.leun_base = flavour

    vim.cmd.colorscheme("leun")

    fix()
end

function Theme.habamax(_)
    vim.cmd.colorscheme("habamax")

    vim.cmd("hi VertSplit ctermbg=None guibg=None guifg=#9e9e9e")
    vim.cmd("hi StatusLineNC guibg=#9e9e9e")
    vim.cmd("hi WinSeparator ctermbg=None guibg=None guifg=#9e9e9e")

    fix()
end

---def.: green
---@param flavour string | nil {red, green, blue}
function Theme.film_noir(flavour)
    if flavour == nil or
        (flavour ~= "red" and flavour ~= "green" and flavour ~= "blue") then
        flavour = "green"
    end

    vim.g.film_noir_color = flavour
    vim.cmd.colorscheme("film_noir")

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
    vim.cmd("hi StatusLineNC guibg=#9e9e9e")
    vim.cmd("hi WinSeparator ctermbg=None guibg=None guifg=#9e9e9e")

    if flavour == "green" then
        vim.cmd("hi StatusLine guibg=#9fff54")
    elseif flavour == "red" then
        vim.cmd("hi StatusLine guibg=#ff549f")
    elseif flavour == "blue" then
        vim.cmd("hi StatusLine guibg=#549fff")
    end

    fix()
end

return Theme
