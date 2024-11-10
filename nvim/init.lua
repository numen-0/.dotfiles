-- LAZY -----------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
-- NOTE: I don't use this but the doc says is better to have different for each
vim.g.maplocalleader = "\\"

require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    defaults = {
        -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
        -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
        lazy = false,
        -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
        -- have outdated releases, which may break your Neovim install.
        version = false, -- always use the latest git commit
        -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    checker = {          -- automatically check for plugin updates
        enabled = false, -- check for plugin updates periodically
        notify  = false, -- notify on update
    },
    rocks = {
        enabled = false,
        hererocks = false,
    },
    performance = {
        rtp = { -- disable some rtp plugins
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})


-- CONF -----------------------------------------------------------------------
require("settings")
require("mappings")
require("autocmds")
local utils = require("utils")

-- require("myplugs.time")
require("myplugs.zenmode").toggle()
-- require("myplugs.statusline").reload()
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
    "netrw",
    "netrwFileHandlers",
    "netrwPlugin",
    "netrwSettings",
    "optwin",
    "rplugin",
    "rrhelper",
    "spellfile_plugin",
    "synmenu",
    "tar",
    "tarPlugin",
    "tutor",
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
