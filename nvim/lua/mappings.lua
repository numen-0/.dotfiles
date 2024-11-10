local M = {}

-- NOTE: uhenever we add new mappings (using this module), we can perform a
--       quick check of any overrides.
M.check = false
M.maps  = {}

local function m(mode, keys, opts)
    local options = { noremap = true }

    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    if not M.check then
        return options
    end

    local print_err = vim.api.nvim_err_writeln
    if type(mode) == "string" then
        if not M.maps[mode] then M.maps[mode] = {} end
        if M.maps[mode][keys] then
            print_err(string.format("collision: {mode: '%s'; keys: '%s'}",
                mode, keys))
        end
        M.maps[mode][keys] = true
    else
        for _, mo in pairs(mode) do
            if not M.maps[mo] then M.maps[mo] = {} end
            if M.maps[mo][keys] then
                print_err(string.format("collision: {mode: '%s'; keys: '%s'}",
                    mo, keys))
            end
            M.maps[mo][keys] = true
        end
    end

    return options
end

---vim.api.nvim_set_keymap()
---@param mode string
---@param lhs  string
---@param rhs  string
---@param opts table?
function M.map(mode, lhs, rhs, opts)
    local options = m(mode, lhs, opts)
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

---vim.keymap.set()
---@param mode string | string[]
---@param lhs  string
---@param rhs  string | function
---@param opts table?
function M.map2(mode, lhs, rhs, opts)
    local options = m(mode, lhs, opts)
    vim.keymap.set(mode, lhs, rhs, options)
end

-------------------------------------------------------------------------------
-- MAPPINGS -------------------------------------------------------------------
-------------------------------------------------------------------------------
-- For each new mapping you add, try to delete or simplify an existing one ----
-- or comment out any mappings you don't use ----------------------------------
-- [Sources] ------------------------------------------------------------------
-- linuxdabble:  https://gitlab.com/linuxdabbler/dotfiles/-/blob/main/.config/nvim/init.lua?ref_type=heads
-- ThePrimeagen: https://github.com/ThePrimeagen/init.lua/tree/249f3b14cc517202c80c6babd0f9ec548351ec71
-- Launch.nvim: https://github.com/LunarVim/Launch.nvim/blob/master/lua/user/keymaps.lua
-------------------------------------------------------------------------------

-- [Split] --------------------------------------------------------------------
-- generation
-- M.map("n", "<leader>o", ":on <CR>")                                    -- make the current window the [O]nly one on the screen | there's also <C-w>o
-- <C-w>h = :vsplit | <C-w>s = :split
-- M.map("n", "<leader>v", ":vsplit<CR>")                                 -- [V]eritcal split == <C-w>v
-- M.map("n", "<leader>V", ":split<CR>")                                  -- horizontal split
-- M.map("n", "<leader>t", ":vsplit term://bash<CR><CMD>startinsert<CR>") -- veritcal [T]erminal
-- M.map("n", "<leader>T", ":split term://bash<CR><CMD>startinsert<CR>")  -- horizontal [T]erminal
-- M.map("t", "<C-t>", "<C-\\><C-n>:bd!<CR>")                             -- delete current [T]erminal

-- navigation
-- M.map("n", "<C-h>", "<C-w>h") -- switches to left split
-- M.map("n", "<C-l>", "<C-w>l") -- switches to right split
-- M.map("n", "<C-j>", "<C-w>j") -- switches to bottom split
-- M.map("n", "<C-k>", "<C-w>k") -- switches to top split

-- adjust sizes
M.map("n", "<C-Left>",  ":vertical resize +3<CR>")   -- resize vertical split +
M.map("n", "<C-Right>", ":vertical resize -3<CR>")   -- resize vertical split -
M.map("n", "<C-Up>",    ":horizontal resize +3<CR>") -- resize horizontal split +
M.map("n", "<C-Down>",  ":horizontal resize -3<CR>") -- resize horizontal split -


-- [Buffers] ------------------------------------------------------------------
M.map("n", "<Tab>", ":bnext <CR>")       -- next buffer (in :buffers)
-- M.map("n", "<S-Tab>", ":bprevious <CR>") -- previous buffer (in :buffers)
M.map("n", "<S-Tab>", ":b #<CR>")        -- previous buffer
M.map("n", "<leader>bd", ":bd <CR>")     -- [D]elets current [B]uffer


-- [Edit] ---------------------------------------------------------------------
-- move lines
M.map("v", "J", ":m '>+1<CR>gv=gv") -- move current line down
M.map("v", "K", ":m '>-2<CR>gv=gv") -- move current line up

-- stay in indent mode
M.map("v", "<", "<gv")
M.map("v", ">", ">gv")

-- cooler join
M.map("n", "J", "mzJ`z") -- [J]oin lines but dont move the cursor

-- highligh
-- M.map("n", "<leader>h", ":set hlsearch!<CR>") -- togle [H]ighligh
M.map("n", "<leader>h", ":noh<CR>") -- switch of [H]ighligh

-- text editing
M.map2({ "v", "n" }, "<leader>s", "mz:s/\\s\\+$//e<CR>`z")                        -- delete trailing [S]paces
-- M.map("n", "<leader>;", ":s/\\%(;$\\)\\@!\\(.\\)$/\\1;/e<CR>:set nohlsearch<CR>") -- add ';' at the end
M.map("n", "<leader>ff", [[/\<<C-r><C-w>\>]])                                     -- [F]Ind all instance of word under cursor
M.map("v", "<leader>ff", '"hy/<C-r>h')                                            -- [F]ind all instance of highlighted words
M.map("n", "<leader>rr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])  -- [R]eplace all instance of word under cursor
M.map("v", "<leader>rr", '"hy:%s/<C-r>h//g<left><left>')                          -- [R]eplace all instance of highlighted words

-- surround (  ._.)
-- M.map("v", 'cs"', 'c"<C-r><C-o>\""<ESC>`<l')     -- [S]urround "word"
-- M.map("v", "cs'", "c'<C-r><C-o>\"'<ESC>`<l")     -- [S]urround 'word'
-- M.map("v", "cs(", "c(<C-r><C-o>\")<ESC>`<l")     -- [S]urround (word)
-- M.map("v", "cs)", "c(<C-r><C-o>\")<ESC>`<l")     -- [S]urround (word)
-- M.map("v", "cs[", "c[<C-r><C-o>\"]<ESC>`<l")     -- [S]urround [word]
-- M.map("v", "cs]", "c[<C-r><C-o>\"]<ESC>`<l")     -- [S]urround [word]
-- M.map("v", "cs{", "c{<C-r><C-o>\"}<ESC>`<l")     -- [S]urround {word}
-- M.map("v", "cs}", "c{<C-r><C-o>\"}<ESC>`<l")     -- [S]urround {word}
-- M.map("v", "cs<", "c<<C-r><C-o>\"><ESC>`<l")     -- [S]urround <word>
-- M.map("v", "cs>", "c<<C-r><C-o>\"><ESC>`<l")     -- [S]urround <word>
-- M.map("v", 'cS"', 'c" <C-r><C-o>\" "<ESC>`<ll')  -- [S]urround " word "
-- M.map("v", "cS'", "c' <C-r><C-o>\" '<ESC>`<ll")  -- [S]urround ' word '
-- M.map("v", "cS(", "c( <C-r><C-o>\" )<ESC>`<ll")  -- [S]urround ( word )
-- M.map("v", "cS)", "c( <C-r><C-o>\" )<ESC>`<ll")  -- [S]urround ( word )
-- M.map("v", "cS[", "c[ <C-r><C-o>\" ]<ESC>`<ll")  -- [S]urround [ word ]
-- M.map("v", "cS]", "c[ <C-r><C-o>\" ]<ESC>`<ll")  -- [S]urround [ word ]
-- M.map("v", "cS{", "c{ <C-r><C-o>\" }<ESC>`<ll")  -- [S]urround { word }
-- M.map("v", "cS}", "c{ <C-r><C-o>\" }<ESC>`<ll")  -- [S]urround { word }
-- M.map("v", "cS<", "c< <C-r><C-o>\" ><ESC>`<ll")  -- [S]urround < word >
-- M.map("v", "cS>", "c< <C-r><C-o>\" ><ESC>`<ll")  -- [S]urround < word >


-- [Cool yank/delete/paste] ---------------------------------------------------
M.map("x", "<leader>p", [["_dP]])          -- "no register" [P]aste
M.map2({ "n", "v" }, "<leader>y", [["+y]]) -- [Y]ank to clipboard
M.map2({ "n", "v" }, "<leader>d", [["_d]]) -- "no register" [D]elete


-- [Navigation/Jumps] ---------------------------------------------------------
-- NOTE: "karb94/neoscroll.nvim" does this for us
-- M.map("n", "<C-u>", "<C-u>zz") -- move [U]p and center cursor
-- M.map("n", "<C-d>", "<C-d>zz") -- move [D]own and center cursor

-- quickfix
-- TODO: learn about this (sound really usefull)
-- M.map("n", "<leader>w", ":vimgrep TODO **/* <CR><CR>") -- set quickfix
-- M.map("n", "cn", ":cn<CR><CR>")                        -- [N]ext location
-- M.map("n", "cp", ":cp<CR><CR>")                        -- [P]rev location
-- M.map("n", "<leader>k", "<cmd>lnext<CR>zz")    -- next location
-- M.map("n", "<leader>j", "<cmd>lprev<CR>zz")    -- prev location

-- diagnostics
-- TODO: learn about this (sound really usefull)
-- M.map2("n", "<leader>de", vim.diagnostic.open_float) -- show [D]iagnostic [E]rror
-- M.map2("n", "<leader>dn", vim.diagnostic.goto_next)  -- show [D]iagnostic [N]ext
-- M.map2("n", "<leader>dp", vim.diagnostic.goto_prev)  -- show [D]iagnostic [P]rev
-- M.map2("n", "<leader>dl", vim.diagnostic.setloclist) -- show [D]iagnostic [L]ist


-- [Disable] ------------------------------------------------------------------
M.map("n", " ",    "<nop>")    -- disable
M.map("n", "<Up>",    "<nop>") -- disable
M.map("n", "<Down>",  "<nop>") -- disable
M.map("n", "<Right>", "<nop>") -- disable
M.map("n", "<Left>",  "<nop>") -- disable
M.map("n", "Q",       "<nop>") -- disable
M.map("i", "<C-c>",   "<Esc>") -- remap/disable

return M
