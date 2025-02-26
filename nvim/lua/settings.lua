-- some config taken from:
--     linuxdabble  (https://gitlab.com/linuxdabbler/dotfiles/-/blob/main/.config/nvim/init.lua?ref_type=heads)
--     ThePrimeagen (https://github.com/ThePrimeagen/init.lua/tree/249f3b14cc517202c80c6babd0f9ec548351ec71)

local o = vim.opt
local g = vim.g


g.mapleader               = " "
g.loaded_node_provider    = 0
g.loaded_perl_provider    = 0
g.loaded_python3_provider = 0
g.c_syntax_for_h          = 1


o.shadafile      = ""
o.autoindent     = true
o.backup         = false
o.belloff        = "all"
o.breakindent    = false
-- o.clipboard      = unnamedplus
o.cmdheight      = 0
o.colorcolumn    = "80"
o.compatible     = false -- turn off vi compatibility mode
o.cursorline     = true
o.cursorlineopt  = "both"
o.expandtab      = true
o.encoding       = "utf-8"
o.fileencoding   = "utf-8" -- encoding set to utf-8
o.hlsearch       = true    -- enable all highlighted search results
o.ignorecase     = true    -- enable case insensitive searching
o.incsearch      = true    -- enable incremental searching
o.laststatus     = 3       -- always and ONLY the last window
o.linebreak      = true
o.mouse          = ""      -- disable the mouse in all modes
o.mousehide      = true    -- hide while typping
o.number         = true    -- turn on line numbers
o.numberwidth    = 4
o.pumheight      = 10      -- number of items in popup menu
o.relativenumber = true    -- turn on relative line numbers
o.ruler          = false
o.scrolloff      = 8       -- scroll page when cursor is 8 lines from top/bottom
o.shiftround     = true
o.shiftwidth     = 4
o.showbreak      = "++"
o.showcmd        = true
o.showcmdloc     = "statusline"
o.showmode       = false
o.showtabline    = 0    -- never show the tab line
o.sidescrolloff  = 8    -- scroll page when cursor is 8 spaces from left/right
o.signcolumn     = "yes"
o.smartcase      = true -- all searches are case insensitive unless there's a capital letter
o.smartindent    = true
o.splitbelow     = true -- split go below
o.splitright     = true -- vertical split to the right
o.syntax         = "ON"
o.tabstop        = 4    -- tabs=4spaces
o.termguicolors  = true -- terminal gui colors
o.timeoutlen     = 400  -- time to wait for a mapped sequence to complete (in milliseconds)
o.undofile       = true
o.updatetime     = 4000
o.wrap           = true -- enable text rapping

vim.cmd("set path+=**")

vim.cmd("sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=")
vim.cmd("sign define DiagnosticSignWarn  text= texthl=DiagnosticSignWarn  linehl= numhl=")
vim.cmd("sign define DiagnosticSignInfo  text= texthl=DiagnosticSignInfo  linehl= numhl=")
vim.cmd("sign define DiagnosticSignHint  text= texthl=DiagnosticSignHint  linehl= numhl=")
