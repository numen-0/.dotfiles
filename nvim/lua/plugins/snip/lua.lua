local ls     = require("luasnip")

local s      = ls.snippet
local t      = ls.text_node
local sn     = ls.snippet_node
local i      = ls.insert_node
local c      = ls.choice_node
local d      = ls.dynamic_node
local f      = ls.function_node
local extras = require("luasnip.extras")
local rep    = extras.rep
local fmt    = require("luasnip.extras.fmt").fmt
local fmta   = require("luasnip.extras.fmt").fmta


ls.add_snippets("lua", {
    -- [if] --
    s("if .. then", {
        c(1, {
            sn(nil, fmta([[
            if <> then
                <>
            end<>
            ]], { i(1, "condition"), i(2), i(0) })),
            sn(nil, fmta("if <> then <> end<>", { i(1, "condition"), i(2), i(0) })),
        }) }),
    -- [for] --
    s("for .. pairs(table) do", {
        c(1, {
            sn(nil, fmta([[
            for <>, <> in pairs(<>) do
                <>
            end<>
            ]], { i(1, "k"), i(2, "v"), i(3, "table"), i(4), i(0) })),
            sn(nil, fmta([[
            for <>, <> in ipairs(<>) do
                <>
            end<>
            ]], { i(1, "i"), i(2, "v"), i(3, "arr"), i(4), i(0) })),
        }) }),
    -- [function] --
    s("function func()",
        fmta([[
        function <>(<>)
            <>
        end
    ]], { i(1, "func"), i(2), i(0) })),
    s("function()",
        fmta([[
        function(<>)
            <>
        end
    ]], { i(1), i(0) })),
    s("M.func = function()",
        fmta([[
        M.<> = function(<>)
            <>
        end
    ]], { i(1, "func"), i(2), i(0) })),
    -- [module] --
    s("M = {}",
        fmta([[
        local <> = {}
        <>
        return <>
    ]], { i(1, "M"), i(0), rep(1) })),
    -- [pcall] --
    s("pcall",
        fmta([[
        local ok, _ = pcall(<>)
        if not ok then
            <>
        end<>
    ]], { i(1, "call"), i(2), i(0) })),
})

-- [require] --
local function get_module_name(nodes)
    return string.gsub(nodes[1][1], ".*%.", "") or ""
end
ls.add_snippets("lua", {
    s('require("module")',
        fmta([[
        local <> = require("<>")<>
    ]], { f(get_module_name, { 1 }), i(1, "mod"), i(0) })),
})
