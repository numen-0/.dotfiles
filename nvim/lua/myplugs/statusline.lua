-- source (https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html)
local M = {}

--= mode ====================================================================--
local modes = {
    ["n"]  = "n",      ["no"] = "n",
    ["v"]  = "v",      ["V"]  = "V",        [""] = "B",
    ["s"]  = "s",      ["S"]  = "S",        [""] = "S+",
    ["i"]  = "i",      ["ic"] = "i",
    ["R"]  = "r",      ["Rv"] = "R",
    ["c"]  = "c",      ["cv"] = "vim ex",   ["ce"] = "ex",
    ["r"]  = "prompt", ["rm"] = "moar",     ["r?"] = "confirm",
    ["!"]  = "shell",  ["t"]  = "t",        ["nt"] = "nt",
}
local function mode()
    local current_mode = vim.api.nvim_get_mode().mode
    return modes[current_mode] or ""
end

--= ruler ===================================================================--
local function ruler()
    return [[\ \ %02l:%02c\ \ ]]
end

--= filename ================================================================--
local function filename()
    return vim.bo.modified and "%#StatusLineBold#%t%#StatusLine#" or "%t"
end

--= lsp =====================================================================--
local levels = {
    errors   = "Error",
    warnings = "Warn",
    info     = "Info",
    hints    = "Hint",
}
local function lsp()
    local count = {}

    for k, level in pairs(levels) do
        count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
    end

    local errors   = ""
    local warnings = ""
    local hints    = ""
    local info     = ""

    if count["errors"] ~= 0 then
        -- errors = count["errors"] .. "\\ "
        errors = "%#DiagnosticSignError#"..count["errors"] .. "\\ "
    end
    if count["warnings"] ~= 0 then
        -- warnings = count["warnings"] .. "\\ "
        warnings = "%#DiagnosticSignWarning#".. count["warnings"] .. "\\ "
    end
    if count["hints"] ~= 0 then
        -- hints = count["hints"] .. "\\ "
        hints = "%#DiagnosticSignHint#" .. count["hints"] .. "\\ "
    end
    if count["info"] ~= 0 then
        -- info = count["info"] .. "\\ "
        info = "%#DiagnosticSignInformation#" .. count["info"] .. "\\ "
    end

    return errors .. warnings .. hints .. info .. "%#StatusLine#"
end

--= macro ===================================================================--
local macro_register = ""
local function macro_on()
    macro_register = "@" .. vim.fn.reg_recording()
    M.reload()
end
local function macro_off()
    macro_register = ""
    M.reload()
end

local function macro()
    return macro_register
end

--= norm statusline =========================================================--
local zenmode = require("myplugs.zenmode")
M.norm = function()
    local name_s = filename()

    if zenmode.getZM() then return "%=" .. name_s .. "%=" end

    local mode_s  = "[" .. mode() .. "]"
    local lsp_s   = lsp()
    local info_s  = ruler()
    local macro_s = macro()
    return "\\ " .. mode_s .. "\\ " .. name_s .. "%r%h\\ " .. lsp_s .. "%=" ..
           "%S\\ \\ " .. macro_s .. "\\ \\ " .. info_s
end

--= load ====================================================================--
local line_map = {
    ft = {
        ["neo-tree"]    = [[%=%=]],
        ["undotree"]    = [[%=%=]],
    },
    name = {
        [""]            = "\\ ",
    },
    match = {
        ["term://.*"]   = [[%=%=]],
        ["lumber://.*"] = [[%=\ %t/\ \ %=]],
    },
}
function M.reload()
    local statusline, name

    statusline = line_map.ft[vim.bo.filetype]
    if statusline then goto set end

    name = vim.api.nvim_buf_get_name(0)
    statusline = line_map.name[name]
    if statusline then goto set end

    for match, line in pairs(line_map.match) do
        if name:match(match) then
            statusline = line
            goto set
        end
    end

    statusline = M.norm()

    ::set::
    -- if type(statusline) == "function" then statusline = statusline() end
    vim.cmd("set statusline=" .. statusline)
end

--= autocmd =================================================================--
local group = vim.api.nvim_create_augroup("Statusline", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufModifiedSet", "ModeChanged", }, {
    pattern = { "*" },
    callback = M.reload,
    group = group,
})
vim.api.nvim_create_autocmd({ "RecordingLeave" }, {
    pattern = { "*" },
    callback = macro_off,
    group = group,
})
vim.api.nvim_create_autocmd({ "RecordingEnter" }, {
    pattern = { "*" },
    callback = macro_on,
    group = group,
})

return M
