-- BUG: I don't know why but wen I use this plug it gives problemns when I try 
--      to save a file, wtf...
local M = {}


local config    = {
    -- match = { "TAG:", },
    hack = true,
    keywords = {
        -- TODO: ...
        TODO = { color = "info" },
        -- NOTE: ...
        NOTE = { color = "hint", alt = { "INFO", "IDEA" } },
        -- FIX:  ...
        FIX = {
            color = "error",
            alt = { "FIX", "FIXME", "BUG", "FIXIT", "ISSUE", "ERROR" },
        },
        -- HACK: ...
        HACK = { color = "warning" },
        -- WARN: ...
        WARN = {
            color = "warning",
            alt = { "WARNING", "XXX" }
        },
        -- PERF: ...
        PERF = {
            alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" }
        },
    },
    colors = {
        info    = { "DiagnosticInfo", "#2563EB" },
        hint    = { "DiagnosticHint", "#10B981" },
        error   = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        default = { "#BF7CCB", "Identifier", },
    },
    support = {
        "lua", "c",
    }
}
local highlight = {
    error   = "CommentError",
    warning = "CommentWarning",
    info    = "CommentInfo",
    hint    = "CommentHint",
    default = "CommentDefault",
}

local tags = {
    set_list   = {},
    match_list = {},
    match_tags = "",
    end_str    = "",
    tag_str    = "",
    blk_str    = "",
}

-- vim.keymap.set("n", "gt", function()
--     todo.jump_next()
-- end, { desc = "Next todo comment" })
--
-- vim.keymap.set("n", "gT", function()
--     todo.jump_prev()
-- end, { desc = "Previous todo comment" })

local function unique_add(t, val)
    for _, v in ipairs(t) do
        if v == val then return end
    end
    t[#t + 1] = val
end
---@param t    table
---@param skip boolean
---@param sep  string
---@param tail string
---@return string
local function join(t, skip, sep, tail)
    local str = ""
    if not tail then tail = "" end
    for _, v in ipairs(t) do
        if skip then
            str = v
            skip = false
        else
            str = str .. sep .. v .. tail
        end
    end
    return str
end
local function gen_hl_from_rgb(hl, rgb)
    local link = {}

    link.fg = rgb
    link.cterm = { bold = true }
    link.bold = true
    -- link.cterm = { bold = true, reverse = true }
    -- link.reverse = true

    vim.api.nvim_set_hl(0, hl .. "Block", link)

    local tmp = link.bg
    link.bg = link.fg
    vim.api.nvim_set_hl(0, hl .. "End", link)

    link.fg = tmp or "black"
    vim.api.nvim_set_hl(0, hl .. "Tag", link)
end
local function gen_hl_from_link(hl, link)
    link = vim.api.nvim_get_hl(0, { name = link })
    if vim.tbl_isempty(link) then return false end

    link.cterm = link.cterm or {}
    link.cterm.bold = true
    link.bold = true
    -- link.cterm.reverse = true
    -- link.reverse = true

    vim.api.nvim_set_hl(0, hl .. "Block", link)

    local tmp = link.bg
    link.bg = link.fg
    vim.api.nvim_set_hl(0, hl .. "End", link)

    link.fg = tmp or "black"
    vim.api.nvim_set_hl(0, hl .. "Tag", link)
    return true
end

---@param start_sl string
---@param start_ml string|?
---@param end_ml   string|?
local function gen_syntax(start_sl, start_ml, end_ml)
    for c, _ in pairs(tags.set_list) do -- @Block
        local color = highlight[c]
        vim.cmd(string.format([[syntax region %sBlock start=/\(%s\)\?\s\+%s:/]] ..
            [[ end=/\(%s\)\?\s\+%s\+:/he=s-1,me=s-1]] ..
            [[ contained containedin=CommentBlock contains=%sTag]],
            color, start_sl, tags.match_list[c], start_sl, tags.match_tags, color))
    end

    -- vim.cmd(string.format([[syntax region CommentBlock start=/%s\s\+\S/]] ..
    vim.cmd(string.format([[syntax region CommentBlock start=/%s/]] ..
        [[ end=/^\s*\($\|%s\s*$\|\([^%s]\&\S\)\)/he=s-1,me=s-1]] ..
        [[ containedin=NONE contains=%s keepend]],
        -- [[ containedin=NONE contains=%s transparent keepend]],
        start_sl, start_sl, start_sl:sub(1, 1), tags.blk_str))

    if not start_ml or not start_sl then return end

    vim.cmd(string.format([[syntax region CommentBlock start=/%s/]] ..
        [[ end=/%s/he=s-1,me=s-1]] ..
        [[ containedin=NONE contains=%s keepend]],
        -- [[ containedin=NONE contains=%s transparent keepend]],
        start_ml, end_ml, tags.blk_str))
end
---@param basic        string
---@param multy_s      string?
---@param multy_e      string?
local function gen_syntax_str(basic, multy_s, multy_e)
    vim.cmd(string.format([[
        syntax region String start=/%s/ skip=/\\%s/ end=/%s/
    ]], basic, basic, basic))

    if not multy_e or not multy_s then return end

    vim.cmd(string.format([[
        syntax region String start=/%s/ end=/%s/ transparent
    ]], multy_s, multy_e))
end
M.any = function()
    if config.hack then
        vim.api.nvim_set_hl(0, "CommentBlock",
                vim.api.nvim_get_hl(0, { name = "Comment" }))
        vim.api.nvim_set_hl(0, "Comment", {})
    end
    for id, colors in pairs(config.colors) do -- hl
        for _, str in ipairs(colors) do
            local name = highlight[id]
            if #str == 7 and str:match("#[0-9a-fA-F]+") then
                gen_hl_from_rgb(name, str)
                break
            end
            if gen_hl_from_link(name, str) then
                break
            end
        end
    end

    local s = tags.set_list
    for TAG, t in pairs(config.keywords) do -- tags.set_list
        local c = t.color or "default"

        if not s[c] then
            s[c] = { TAG }
        else
            unique_add(s[c], TAG)
        end

        if not t.alt then goto skip end
        for _, tag in ipairs(t.alt) do
            unique_add(tags.set_list[c], tag)
        end
        ::skip::
    end

    local m, ma, e, t, b
    m = tags.match_list; e = ""; t = ""; b = "";

    for c, _ in pairs(s) do -- syn @Tag @End
        e = e .. "," .. highlight[c] .. "End"
        t = t .. "," .. highlight[c] .. "Tag"
        b = b .. "," .. highlight[c] .. "Block"
        local mt = join(s[c], true, "\\|", "")
        m[c] = "\\(" .. mt .. "\\)"
        if not ma then
            ma = mt
        else
            ma = ma .. "\\|" .. mt
        end

        vim.cmd(string.format("syn match %sTag / %s:/he=e-1,me=e-1 " ..
            "contained containedin=%sBlock nextgroup=%sEnd",
            highlight[c], m[c], highlight[c], highlight[c]))
        vim.cmd(string.format("syn match %sEnd /:/ contained containedin=%sTag",
            highlight[c], highlight[c]))
    end
    tags.end_str = e
    tags.tag_str = t
    tags.blk_str = b
    tags.match_tags = "\\(" .. ma .. "\\)"
end

M.lua = function()
    -- vim.api.nvim_err_writeln("hello")
    M.any()
    gen_syntax_str('"', "\\[\\[", "\\]\\]")
    -- gen_syntax("--", "--\\[\\[", "--\\]\\]")
    gen_syntax("--", "--\\[\\z(*\\)\\[", "--\\]\\z1\\]")
end
M.c = function()
    M.any()
    gen_syntax_str('"')
    gen_syntax("\\/\\/", "\\/\\*", "\\*\\/") -- TODO: maybe a function that scapes the string???
end
M.python = function()
    M.any()
    gen_syntax_str('"')
    gen_syntax("#", "'''", "'''")
end


M.setup = function(_)
    local group = vim.api.nvim_create_augroup('CommentBlocks', { clear = true })
    for _, ft in ipairs(config.support) do
        if not M[ft] then
            vim.api.nvim_err_writeln("comment-blocks: unsuported ft '"..ft.."'")
            goto continue
        end
        vim.api.nvim_create_autocmd("FileType", {
            pattern = ft,
            group = group,
            callback = M[ft],
        })
        ::continue::
    end
end

return M
