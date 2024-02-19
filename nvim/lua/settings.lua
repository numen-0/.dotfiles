-- DOWNLOADED + EDITED
-- linuxdabble  (https://gitlab.com/linuxdabbler/dotfiles/-/blob/main/.config/nvim/init.lua?ref_type=heads)
-- ThePrimeagen (https://github.com/ThePrimeagen/init.lua/tree/249f3b14cc517202c80c6babd0f9ec548351ec71)
local opt = vim.opt
local g = vim.g


-- Functional wrapper for mapping custom keybindings
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- SETTINGS --------------------------------------------------------------------
--------------------------------------------------------------------------------
g.mapleader = " "
g.c_syntax_for_h = 1

opt.autoindent = true
opt.backup = false
opt.belloff = "all"
opt.breakindent = false
opt.clipboard = unnamedplus
opt.cmdheight = 0
opt.colorcolumn = "80"
opt.compatible = false -- turn off vi compatibility mode
opt.cursorline = true
opt.cursorlineopt = "both"
opt.expandtab = true
opt.fileencoding = "utf-8" -- encoding set to utf-8
opt.hlsearch = true        -- enable all highlighted search results
opt.ignorecase = true      -- enable case insensitive searching
opt.incsearch = true       -- enable incremental searching
opt.laststatus = 3         -- always and ONLY the last window
opt.mouse = "a"            -- enable the mouse in all modes
opt.number = true          -- turn on line numbers
opt.numberwidth = 4
opt.pumheight = 10         -- number of items in popup menu
opt.relativenumber = true  -- turn on relative line numbers
opt.ruler = false
opt.scrolloff = 8          -- scroll page when cursor is 8 lines from top/bottom
opt.shiftround = true
opt.shiftwidth = 4
opt.showbreak = "++"
opt.showcmd = true
opt.showcmd = true
opt.showcmdloc = "statusline"
opt.showmode = true
opt.showtabline = 0      -- never show the tab line
opt.sidescrolloff = 8    -- scroll page when cursor is 8 spaces from left/right
opt.signcolumn = "yes"
opt.smartcase = true     -- all searches are case insensitive unless there's a capital letter
opt.smartindent = true
opt.splitbelow = true    -- split go below
opt.splitright = true    -- vertical split to the right
opt.syntax = "ON"
opt.tabstop = 4          -- tabs=4spaces
opt.termguicolors = true -- terminal gui colors
opt.updatetime = 200
opt.wrap = true          -- enable text rapping
vim.cmd("set path+=**")

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- MAPPINGS --------------------------------------------------------------------
--------------------------------------------------------------------------------
-- easy split generation
map("n", "<leader>v", ":vsplit<CR>")              -- space+v creates a veritcal split
map("n", "<leader>s", ":split<CR>")               -- space+s creates a horizontal split
map("n", "<leader>t", ":vsplit term://bash<CR>i") -- space+t creates a veritcal terminal
map("n", "<leader>T", ":split term://bash<CR>i")  -- space+T creates a horizontal terminal
map("t", "<C-t>", "<C-\\><C-n>:bd!<CR>")          -- space+T delete current terminal

-- easy split navigation
map("n", "<C-h>", "<C-w>h") -- control+h switches to left split
map("n", "<C-l>", "<C-w>l") -- control+l switches to right split
map("n", "<C-j>", "<C-w>j") -- control+j switches to bottom split
map("n", "<C-k>", "<C-w>k") -- control+k switches to top split

-- buffer navigation
map("n", "<Tab>", ":bnext <CR>")       -- Tab goes to next buffer
map("n", "<S-Tab>", ":bprevious <CR>") -- Shift+Tab goes to previous buffer
-- map("n", "<leader>d", ":bd <CR>")				    -- Space+d delets current buffer

-- adjust split sizes easier
map("n", "<C-Left>", ":vertical resize +3<CR>")   -- Control+Left resizes vertical split +
map("n", "<C-Right>", ":vertical resize -3<CR>")  -- Control+Right resizes vertical split -
map("n", "<C-Up>", ":horizontal resize +3<CR>")   -- Control+Up resizes horizontal split +
map("n", "<C-Down>", ":horizontal resize -3<CR>") -- Control+Down resizes horizontal split -

-- Easy way to get back to normal mode from home row
-- map("i", "kj", "<Esc>") -- kj simulates ESC
-- map("i", "jk", "<Esc>") -- jk simulates ESC

-- Visual Maps
map("v", "<C-s>", ":sort<CR>")    -- Sort highlighted text in visual mode with Control+S
map("v", "J", ":m '>+1<CR>gv=gv") -- Move current line down
map("v", "K", ":m '>-2<CR>gv=gv") -- Move current line up

-- highligh
map("n", "?", ":set hlsearch<CR>:noh<CR>?") -- search hl correction
map("n", "/", ":set hlsearch<CR>:noh<CR>/") -- search hl correction
map("n", "<leader>h", ":set hlsearch!<CR>") -- togle highligh

-- text editing
vim.keymap.set({ "v", "n" }, "<leader>s", ":s/\\s\\+$//e<CR>:set hlsearch<CR>:set hlsearch!<CR>") --  delete trailing spaces
vim.keymap.set("n", "<leader>;", ":s/\\%(;$\\)\\@!\\(.\\)$/\\1;/e<CR>:set hlsearch<CR>:set hlsearch!<CR>") --  delete trailing spaces
map("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])                     -- Replace all instance of word under cursor
map("v", "<leader>r", '"hy:%s/<C-r>h//g<left><left>')                                             -- Replace all instance of highlighted words
map("v", '<leader>w"', 'c"<ESC>pa"<ESC>')                                                         -- wrap word ""
map("v", "<leader>w'", "c'<ESC>pa'<ESC>")                                                         -- wrap word ''
map("v", "<leader>w(", "c(<ESC>pa)<ESC>")                                                         -- wrap word ()
map("v", "<leader>w)", "c(<ESC>pa)<ESC>")                                                         -- wrap word ()
map("v", "<leader>w[", "c[<ESC>pa]<ESC>")                                                         -- wrap word []
map("v", "<leader>w]", "c[<ESC>pa]<ESC>")                                                         -- wrap word []
map("v", "<leader>w{", "c{<ESC>pa}<ESC>")                                                         -- wrap word {}
map("v", "<leader>w}", "c{<ESC>pa}<ESC>")                                                         -- wrap word {}

-- diagnostics
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
