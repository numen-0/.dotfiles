ZenMode = {}
ZenMode.__index = ZenMode
local zm = false

function ZenMode.getZM() return zm end

function ZenMode.toggle()
    zm = not zm
    if zm then
        vim.cmd("set signcolumn=no")
        vim.cmd("set colorcolumn=-1")
        vim.cmd("set nonumber")
        vim.cmd("set norelativenumber")
        vim.diagnostic.hide()
    else
        vim.cmd("set signcolumn=yes")
        vim.cmd("set colorcolumn=80")
        vim.cmd("set number")
        vim.cmd("set relativenumber")
        vim.diagnostic.show()
    end
    require("statusline").reload()
end

require("mappings").map2("n", "<leader>zm", ZenMode.toggle, { noremap = true })

return ZenMode
