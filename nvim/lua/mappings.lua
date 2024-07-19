M = {}
M.__index = M

local maps = {}
local check = false

local function m(mode, keys, opts)
    local options = { noremap = true }

    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    if not check then
        return options
    end

    if type(mode) == "string" then
        if not maps[mode] then maps[mode] = {} end
        if maps[mode][keys] then
            vim.api.nvim_err_write("collision: {mode:'" .. mode .. "'; keys: '" .. keys .. "'}\n")
        end
        maps[mode][keys] = true
    else
        for _, mo in pairs(mode) do
            if not maps[mo] then maps[mo] = {} end
            if maps[mo][keys] then
                vim.api.nvim_err_write("collision: {mode:'" .. mo .. "'; keys: '" .. keys .. "'}\n")
            end
            maps[mo][keys] = true
        end
    end

    return options
end

---vim.api.nvim_set_keymap()
---@param mode string
---@param lhs string
---@param rhs string
---@param opts table?
function M.map(mode, lhs, rhs, opts)
    local options = m(mode, lhs, opts)
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

---vim.keymap.set()
---@param mode string | string[]
---@param lhs string
---@param rhs string | function
---@param opts table?
function M.map2(mode, lhs, rhs, opts)
    local options = m(mode, lhs, opts)
    vim.keymap.set(mode, lhs, rhs, options)
end

-------------------------------------------------------------------------------
-- MAPPINGS -------------------------------------------------------------------
-------------------------------------------------------------------------------
-- some mappings taken from:
--     linuxdabble  (https://gitlab.com/linuxdabbler/dotfiles/-/blob/main/.config/nvim/init.lua?ref_type=heads)
--     ThePrimeagen (https://github.com/ThePrimeagen/init.lua/tree/249f3b14cc517202c80c6babd0f9ec548351ec71)
--     https://github.com/LunarVim/Launch.nvim/blob/master/lua/user/keymaps.lua

-- split generation
M.map("n", "<leader>o", ":on <CR>")                                    -- make the current window the [O]nly one on the screen
-- <C-w>h = :vsplit | <C-w>s = :split
M.map("n", "<leader>v", ":vsplit<CR>")                                 -- [V]eritcal split
M.map("n", "<leader>V", ":split<CR>")                                  -- horizontal split
M.map("n", "<leader>t", ":vsplit term://bash<CR><CMD>startinsert<CR>") -- veritcal [T]erminal
M.map("n", "<leader>T", ":split term://bash<CR><CMD>startinsert<CR>")  -- horizontal [T]erminal
M.map("t", "<C-t>", "<C-\\><C-n>:bd!<CR>")                             -- delete current [T]erminal

-- split navigation
-- M.map("n", "<C-h>", "<C-w>h") -- switches to left split
-- M.map("n", "<C-l>", "<C-w>l") -- switches to right split
-- M.map("n", "<C-j>", "<C-w>j") -- switches to bottom split
-- M.map("n", "<C-k>", "<C-w>k") -- switches to top split

-- buffer navigation
-- M.map("n", "<Tab>", ":bnext <CR>")       -- Tab goes to next buffer
-- M.map("n", "<S-Tab>", ":bprevious <CR>") -- Shift+Tab goes to previous buffer
M.map("n", "<leader>bn", ":bnext <CR>")     -- go to [N]ext [B]uffer
M.map("n", "<leader>bp", ":bprevious <CR>") -- go to [P]revious [B]uffer
M.map("n", "<leader>bd", ":bd <CR>")        -- [D]elets current [B]uffer

-- adjust split sizes
M.map("n", "<C-Left>", ":vertical resize +3<CR>")   -- resize vertical split +
M.map("n", "<C-Right>", ":vertical resize -3<CR>")  -- resize vertical split -
M.map("n", "<C-Up>", ":horizontal resize +3<CR>")   -- resize horizontal split +
M.map("n", "<C-Down>", ":horizontal resize -3<CR>") -- resize horizontal split -

-- Visual Maps
M.map("v", "<C-s>", ":sort<CR>")    -- [S]ort highlighted text in visual mode
M.map("v", "J", ":m '>+1<CR>gv=gv") -- move current line down
M.map("v", "K", ":m '>-2<CR>gv=gv") -- move current line up

-- highligh
M.map("n", "<leader>h", ":set hlsearch!<CR>") -- togle [H]ighligh

-- text editing
M.map2({ "v", "n" }, "<leader>s", ":s/\\s\\+$//e<CR>")                            -- delete trailing [S]paces
-- M.map("n", "<leader>;", ":s/\\%(;$\\)\\@!\\(.\\)$/\\1;/e<CR>:set nohlsearch<CR>") -- add ';' at the end
M.map("n", "<leader>f", [[/\<<C-r><C-w>\>]])                                      -- [F]Ind all instance of word under cursor
M.map("v", "<leader>f", '"hy/<C-r>h')                                             -- [F]ind all instance of highlighted words
M.map("n", "<leader>rr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])  -- [R]eplace all instance of word under cursor
M.map("v", "<leader>rr", '"hy:%s/<C-r>h//g<left><left>')                          -- [R]eplace all instance of highlighted words

-- wrap
M.map("v", '<leader>w"', 'c"<ESC>pa"<ESC>') -- [W]rap word ""
M.map("v", "<leader>w'", "c'<ESC>pa'<ESC>") -- [W]rap word ''
M.map("v", "<leader>w(", "c(<ESC>pa)<ESC>") -- [W]rap word ()
M.map("v", "<leader>w)", "c(<ESC>pa)<ESC>") -- [W]rap word ()
M.map("v", "<leader>w[", "c[<ESC>pa]<ESC>") -- [W]rap word []
M.map("v", "<leader>w]", "c[<ESC>pa]<ESC>") -- [W]rap word []
M.map("v", "<leader>w{", "c{<ESC>pa}<ESC>") -- [W]rap word {}
M.map("v", "<leader>w}", "c{<ESC>pa}<ESC>") -- [W]rap word {}

-- navigation
-- M.map("n", "E", "$", { noremap = false })
-- M.map("n", "B", "^", { noremap = false })
-- M.map("n", "<C-u>", "<C-u>zz") -- move [U]p and center cursor
-- M.map("n", "<C-d>", "<C-d>zz") -- move [D]own and center cursor

-- cool yank/delete/copy
M.map("x", "<leader>p", [["_dP]])          -- secure [P]ut
M.map2({ "n", "v" }, "<leader>y", [["+y]]) -- [Y]ank to register
M.map2({ "n", "v" }, "<leader>d", [["_d]]) -- secure [D]elete
-- M.map("n", "<leader>Y", [["+Y]])        -- upper [Y]ank to register

-- quickfix
M.map("n", "<leader>w", ":vimgrep TODO **/* <CR><CR>") -- set quickfix
M.map("n", "cn", ":cn<CR><CR>")                        -- [N]ext location
M.map("n", "cp", ":cp<CR><CR>")                        -- [P]rev location
-- M.map("n", "<leader>k", "<cmd>lnext<CR>zz")    -- next location
-- M.map("n", "<leader>j", "<cmd>lprev<CR>zz")    -- prev location

-- diagnostics
M.map2("n", "<space>de", vim.diagnostic.open_float) -- show [D]iagnostic [E]rror
M.map2("n", "<leader>dn", vim.diagnostic.goto_next) -- show [D]iagnostic [N]ext
M.map2("n", "<leader>dp", vim.diagnostic.goto_prev) -- show [D]iagnostic [P]rev
M.map2("n", "<space>dl", vim.diagnostic.setloclist) -- show [D]iagnostic [L]ist

-- Stay in indent mode
M.map("v", "<", "<gv")
M.map("v", ">", ">gv")

-- extra
M.map("n", "J", "mzJ`z") -- [J]oin lines but dont move the cursor

-- disable
M.map("n", "<Up>", "<nop>")    -- disable
M.map("n", "<Down>", "<nop>")  -- disable
M.map("n", "<Right>", "<nop>") -- disable
M.map("n", "<Left>", "<nop>")  -- disable
M.map("i", "<C-c>", "<Esc>")   -- scape
M.map("n", "Q", "<nop>")       -- disable "Q"

return M
