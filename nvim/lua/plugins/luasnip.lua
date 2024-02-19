return {
    "L3MON4D3/LuaSnip",
    tag = "v2.2",
    build = "make install_jsregexp",
    
    config = function ()
        require("luasnip").setup({
            update_events = {"TextChanged", "TextChangedI"},
        })
    end
}
