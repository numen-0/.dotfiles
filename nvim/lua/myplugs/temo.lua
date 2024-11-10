-- text emojis --
-- IDEA: use lua snips, for this stuff
local M = {}

M.raw_list = {
    ["coolguy"] = "( c-(/ )-(/ ))",
    ["buffguy"] = "G[-_-]J",
    ["puff"]    = "( -[]3[])",
}
M.components = {
    face = {
        meh  = "._.",
        oh   = "0o0",
        hmm  = "-_-",
        wtf  = ".7.",
        ill  = "o_O",
        wii  = "OwO",
        good = "OuO",
        uwu  = "UwU",
        rip  = "X3X",
    },
    body = {
        round  = { "(", ")" },
        square = { "[", "]" },
        curly  = { "{", "}" },
        line   = { "|", "|" },
        arrow  = { "<", ">" },
    }
}
return M
