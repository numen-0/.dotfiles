local M = {}
-- NOTE: we could group autocmds by events, and just have one autocmd for each
--       event and patter group that calls all the respective callback, but it
--       may overcomplicate stuff

M.group = vim.api.nvim_create_augroup('UserAutocmds', { clear = true })


---@param event string|string[]
---@param opts  table
M.new = function(event, opts)
    opts.group = opts.group or M.group
    vim.api.nvim_create_autocmd(event, opts)
end

-------------------------------------------------------------------------------

M.new('ColorScheme', {
    callback = function(_)
        vim.cmd("hi default YankHighlight guifg=black guibg=white gui=bold")
    end,
    pattern  = "*",
    desc     = "Reload YankHighlight highlight"
})

-- https://github.com/omerxx/dotfiles/blob/master/nvim/lua/misc.ua
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
M.new('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({ higroup = "YankHighlight" })
    end,
    pattern  = '*',
    desc     = "Cool on yank highlight"
})

M.new('FileType', {
    callback = function(_)
        local opt         = vim.bo

        opt.commentstring = "; %s"
        -- opt.shiftwidth    = 8
        -- opt.softtabstop   = 8
        -- opt.tabstop       = 8
    end,
    pattern  = "asm",
    desc     = "Set comment style for asm"
})

M.new('FileType', {
    callback = function(_)
        vim.keymap.set("n", "<leader>x", ":.lua<CR>")
        vim.keymap.set("v", "<leader>x", ":lua<CR>")
    end,
    pattern  = "lua",
    desc     = "Execute lua using keymaps"
})

M.new({ 'BufReadPre', 'BufNewFile' }, {
    desc = 'Set filetype for wool files',
    pattern = { '*.wool' },
    callback = function(_)
        vim.cmd('set filetype=wool')
    end,
})
M.new({ 'BufReadPre', 'BufNewFile' }, {
    desc = 'Set filetype for todo files',
    pattern = { '.todo' },
    callback = function(ev)
        vim.cmd('set filetype=todo')
        local buf = ev.buf
        if not buf then return end

        vim.api.nvim_buf_set_keymap(buf, "n", "<leader>x", "mz_ci[x<esc>`z", {})
        vim.api.nvim_buf_set_keymap(buf, "n", "<leader>X", "mz_ci[ <esc>`z", {})
    end,
})

return M
