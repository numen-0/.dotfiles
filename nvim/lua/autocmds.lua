local M = {}
-- NOTE: we could group autocmds by events, and just have one autocmd for each
--       event and patter group that calls all the respective callback, but it
--       may overcomplicate stuff

M.group = vim.api.nvim_create_augroup('UserAutocmds', { clear = true })

M.autocmds = {}

---@param event string|string[]
---@param opts  table
M.new = function(event, opts)
    table.insert(M.autocmds, { event, opts })
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

return M
