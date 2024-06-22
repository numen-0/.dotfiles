-- source (https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html)
Statusline = {}

--= info_str ================================================================--
-- local modes = {
    -- ["n"]  = "normal", ["no"] = "normal",
    -- ["v"]  = "visual", ["V"]  = "v+line", [""]  = "v+block",
    -- ["s"]  = "select", ["S"]  = "s+line", [""]  = "s+block",
    -- ["i"]  = "insert", ["ic"] = "insert",
    -- ["R"]  = "replace", ["Rv"] = "v+replace",
    -- ["c"]  = "command", ["cv"] = "vim ex", ["ce"] = "ex",
    -- ["r"]  = "prompt", ["rm"] = "moar", ["r?"] = "confirm", ["!"]  = "shell",
    -- ["t"]  = "terminal", ["nt"] = "terminal",
-- }
local modes = {
    ["n"]  = "n", ["no"] = "n", ["v"]  = "v", ["V"]  = "V", [""] = "B",
    ["s"]  = "s", ["S"]  = "S", [""] = "S+", ["i"]  = "i", ["ic"] = "i",
    ["R"]  = "r", ["Rv"] = "R", ["c"]  = "c", ["cv"] = "vim ex", ["ce"] = "ex",
    ["r"]  = "prompt", ["rm"] = "moar", ["r?"] = "confirm", ["!"]  = "shell",
    ["t"]  = "t", ["nt"] = "t",
}
local function mode()
    local current_mode = vim.api.nvim_get_mode().mode
    return modes[current_mode]
end

local function lsp()
    local count = {}
    local levels = {
        errors = "Error",
        warnings = "Warn",
        info = "Info",
        hints = "Hint",
    }

    for k, level in pairs(levels) do
        count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
    end

    local errors = ""
    local warnings = ""
    local hints = ""
    local info = ""

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

    return errors .. warnings .. hints .. info .. "%#Statusline#"
end
local function lineinfo()
    return "\\ \\ %02l:%02c\\ \\ "
end
local function filename()
    return vim.bo.modified and "%#StatuslineBold#%t%#Statusline#" or "%t"
end

--= macro ===================================================================--
local is_recording_macro = false
local macro_register = ""
-- Function to start recording macro
function Macro_handler()
    if not is_recording_macro then
        local key_code = vim.fn.getchar()
        if type(key_code) == "string" and (key_code < "a" or "z" < key_code) then
            return
        end
        if key_code < 97 or 122 < key_code then -- 'a' == 97; 'z' == 122;
            return
        end
        macro_register = string.char(key_code)
        vim.api.nvim_feedkeys("q" .. macro_register, "n", false)
        is_recording_macro = true
        Statusline.reload()
    else
        vim.api.nvim_feedkeys("q", "n", false)
        is_recording_macro = false
        macro_register = ""
        Statusline.reload()
    end
end

-- Define custom mappings to start and stop macro recording
require("mappings").map("n", "q", "<cmd>lua Macro_handler()<CR>", { noremap = true, silent = true })

local function macro()
    return is_recording_macro and "@" .. macro_register or ""
end

--= zenmode =================================================================--
local zenmode = require("zenmode")
Statusline.norm = function()
    local name_s = filename()
    if zenmode.getZM() then
        return table.concat({
            "%=",
            name_s,
            "%=",
        })
    end
    local mode_s = mode()
    local lsp_s = lsp()
    local info_s = lineinfo()
    local macro_s = macro()
    return table.concat({
        "\\ [",
        mode_s,
        "]\\ ",
        name_s,
        "\\ ",
        lsp_s,
        "%=",
        "%S\\ \\ ",
        macro_s,
        "\\ \\ ",
        info_s,
    })
end

--= load ====================================================================--
function Statusline.reload()
    local statusline

    if vim.bo.filetype == "neo-tree" then
        statusline = "%=%="
    elseif string.match(vim.api.nvim_buf_get_name(0), "term://.*") then
        statusline = "%=%="
    elseif string.match(vim.api.nvim_buf_get_name(0), "undotree_[0-9]+") then
        statusline = "%=%="
    elseif vim.api.nvim_buf_get_name(0) == "" then
        statusline = "\\ "
    else
        statusline = Statusline.norm()
    end

    vim.cmd("set statusline=" .. statusline)
end

local group = vim.api.nvim_create_augroup("Statusline", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "BufModifiedSet", "ModeChanged", "RecordingEnter" }, {
    callback = Statusline.reload,
    group = group,
})
-- nose porque no funciona...
-- vim.api.nvim_create_autocmd({ "RecordingLeave" }, {
--     pattern = { "*" },
--     callback = macro_off,
--     group = group,
-- })
-- vim.api.nvim_create_autocmd({ "RecordingEnter" }, {
--     pattern = { "*" },
--     callback = macro_on,
--     group = group,
-- })

return Statusline
