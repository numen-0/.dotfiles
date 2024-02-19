-- zen mode
ZenMode = { }
ZenMode.__index = ZenMode
local zm = false

function ZenMode.getZM()
    return zm
end

function ZenMode.toggleZenMode()
    zm = not zm
    vim.cmd("set nonu!")
    vim.cmd("set rnu!")
    if zm then
        vim.cmd("set signcolumn=no")
        vim.cmd("set colorcolumn=-1")
        vim.diagnostic.disable()
    else
        vim.cmd("set signcolumn=yes")
        vim.cmd("set colorcolumn=80")
        vim.diagnostic.enable()
    end
    require("statusline").reload()
end

-- KeyMap
vim.api.nvim_set_keymap("n", "<Leader>zm", ":lua ZenMode.toggleZenMode()<CR>", { noremap = true })

return ZenMode

