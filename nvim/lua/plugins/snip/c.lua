require("luasnip.session.snippet_collection").clear_snippets("c")

local ls     = require("luasnip")

local s      = ls.snippet
local t      = ls.text_node
local sn     = ls.snippet_node
local i      = ls.insert_node
local c      = ls.choice_node
local extras = require("luasnip.extras")
local rep    = extras.rep
local fmt    = require("luasnip.extras.fmt").fmt
local fmta   = require("luasnip.extras.fmt").fmta

ls.add_snippets("c", {
    s("if", {
        c(1, {
            sn(nil, fmta("if ( <> ) { <> } <>", { i(1, "condition"), i(2), i(0) })),
            sn(nil, fmta([[
            if ( <> ) {
                <>
            }<>
            ]], { i(1, "condition"), i(2), i(0) })),
        }) }),
    s("for", {
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
    -- TODO: typedef {struct, enum}
})
