require("luasnip.session.snippet_collection").clear_snippets("markdown")

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

ls.add_snippets("markdown", {
    s("![img_alt](link)", fmta("![<>](<>)<>", -- img
        { i(1, "img_alt"), i(2, "link"), i(0) })
    ),
    s("[link_text](link)", fmta("[<>](<>)<>", -- link
        { i(1, "link_text"), i(2, "link"), i(0) })
    ),
})
