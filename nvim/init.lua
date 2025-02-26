-- LAZY -----------------------------------------------------------------------
require("lazy_setup")

-- CONF -----------------------------------------------------------------------
require("settings")
require("mappings")
require("autocmds")
local utils = require("utils")
-- utils.cowboy()

require("myplugs.zenmode").setup()
require("myplugs.statusline")
-- require("myplugs.time")
-- require("myplugs.comment-blocks").setup({})

-- UNLOAD ---------------------------------------------------------------------
-- https://github.com/letieu/nvim-config/blob/master/lua/options.lua
-- https://www.reddit.com/r/neovim/comments/opipij/guide_tips_and_tricks_to_reduce_startup_and/
-- disable some builtin vim plugins
local disabled_built_ins = {
    "2html_plugin",
    "bugreport",
    "compiler",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "matchit",
    -- "matchparen",
    "netrw",
    "netrwFileHandlers",
    "netrwPlugin",
    "netrwSettings",
    "optwin",
    "rplugin",
    "rrhelper",
    "spellfile_plugin",
    "sql_completion",
    "synmenu",
    "tar",
    "tarPlugin",
    "tutor",
    "tutor_mode_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
    -- "ftplugin",
    -- "syntax",
}
for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

utils.unload("mappings")
utils.unload("autocmds")
