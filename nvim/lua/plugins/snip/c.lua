-- require("luasnip.session.snippet_collection").clear_snippets("c")

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

-- TODO: typedef {struct, enum}, switch case:
ls.add_snippets("c", {
    s("if", {                           -- [if]
        c(1, {
            sn(nil, fmta("if ( <> ) { <> } <>", { i(1, "condition"), i(2), i(0) })),
            sn(nil, fmta([[
            if ( <> ) {
                <>
            }<>
            ]], { i(1, "condition"), i(2), i(0) })),
        }) }),
    s("for", {                          -- [for]
        c(1, {
            sn(nil, fmta([[
            for ( int <> = 0; <> << <>; <>++ ) {
                <>
            }<>
            ]], { i(1, "var"), rep(1), i(2, "max"), rep(1), i(3), i(0) })),
            sn(nil, fmta([[
            for ( <>; <>; <> ) {
                <>
            }<>
            ]], { i(1, "var"), i(2, "condition"), i(3, "step"), i(4), i(0) })),
        }) }),
    s("typedef", {                      -- [typedef enum/struct]
        c(1, {
            sn(nil, fmta([[
            typedef struct {
                <>
            } <>;
            ]], { i(2), i(1, "S") })),
            sn(nil, fmta([[
            typedef enum {
                <>
            } <>;
            ]], { i(2), i(1, "T") })),
        }) }),
    s("fptr", fmta("<> (*<>)(<>)<>",    -- [function ptr]
        { i(2, "void"), i(1, "func_ptr"), i(3, "void"), i(0) })
    ),
})


-- [#ifndef]
local function header_name(_)
    local name = vim.fn.bufname():gsub(vim.fn.getcwd(), "")
    if name then
        name = "_" .. string.upper(name)
        name = string.gsub(name, "[./]", "_")
    else
        name = "_HEADER_H"
    end
    return sn(nil, i(1, name))
end
ls.add_snippets("c", {
    s("#ifndef",
        fmta([[
        #ifndef <>
        #define <>
        <>
        #endif // !<>
    ]], { d(1, header_name, {}), rep(1), i(0), rep(1) })),
})

-- [switch]
local function switch_case(_)
    return sn(nil, c(1, {
        sn(nil, fmta([[
        } default: {
            <>
            break;
        ]], { i(1) })),
        sn(nil, fmta([[
        } case <>: {
            <>
            break;
        <>
        ]], { i(1, "CASE"), i(2), d(3, switch_case, {}) })),
        }))
end
ls.add_snippets("c", {
    s("switch",
        fmta([[
        switch ( <> ) {
          case <>: {
            <>
            break;
        <>
        }}<>
        ]], { i(1, "val"), i(2, "CASE"), i(3), d(4, switch_case, {}), i(0) })
    ),
})
