-- some config taken from:
--     linuxdabble  (https://gitlab.com/linuxdabbler/dotfiles/-/blob/main/.config/nvim/init.lua?ref_type=heads)
--     ThePrimeagen (https://github.com/ThePrimeagen/init.lua/tree/249f3b14cc517202c80c6babd0f9ec548351ec71)

local opt = vim.opt
local g   = vim.g

g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_python3_provider = 0
g.mapleader        = " "
g.c_syntax_for_h   = 1

opt.shadafile = ""
opt.autoindent     = true
opt.backup         = false
opt.belloff        = "all"
opt.breakindent    = false
opt.clipboard      = unnamedplus
opt.cmdheight      = 0
opt.colorcolumn    = "80"
opt.compatible     = false -- turn off vi compatibility mode
opt.cursorline     = true
opt.cursorlineopt  = "both"
opt.expandtab      = true
opt.fileencoding   = "utf-8" -- encoding set to utf-8
opt.hlsearch       = true  -- enable all highlighted search results
opt.ignorecase     = true  -- enable case insensitive searching
opt.incsearch      = true  -- enable incremental searching
opt.laststatus     = 3     -- always and ONLY the last window
opt.linebreak      = true
opt.mouse          = ""    -- disable the mouse in all modes
opt.mousehide      = true  -- hide while typping
opt.number         = true  -- turn on line numbers
opt.numberwidth    = 4
opt.pumheight      = 10    -- number of items in popup menu
opt.relativenumber = true  -- turn on relative line numbers
opt.ruler          = false
opt.scrolloff      = 8     -- scroll page when cursor is 8 lines from top/bottom
opt.shiftround     = true
opt.shiftwidth     = 4
opt.showbreak      = "++"
opt.showcmd        = true
opt.showcmdloc     = "statusline"
opt.showmode       = true
opt.showtabline    = 0   -- never show the tab line
opt.sidescrolloff  = 8   -- scroll page when cursor is 8 spaces from left/right
opt.signcolumn     = "yes"
opt.smartcase      = true -- all searches are case insensitive unless there's a capital letter
opt.smartindent    = true
opt.splitbelow     = true -- split go below
opt.splitright     = true -- vertical split to the right
opt.syntax         = "ON"
opt.tabstop        = 4   -- tabs=4spaces
opt.termguicolors  = true -- terminal gui colors
opt.timeoutlen     = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.undofile       = true
opt.updatetime     = 200
opt.wrap           = true -- enable text rapping

vim.cmd("set path+=**")

vim.cmd("sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=")
vim.cmd("sign define DiagnosticSignWarn  text= texthl=DiagnosticSignWarn  linehl= numhl=")
vim.cmd("sign define DiagnosticSignInfo  text= texthl=DiagnosticSignInfo  linehl= numhl=")
vim.cmd("sign define DiagnosticSignHint  text= texthl=DiagnosticSignHint  linehl= numhl=")

