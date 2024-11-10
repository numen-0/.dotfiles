local M = {}
local zm_table = {}
local zm_opts = {
    ['colorcolumn']    = "-1",
    -- ['cursorline']     = false,
    ['cursorcolumn']   = false,
    ['fillchars']      = "eob: ",
    ['foldcolumn']     = "0",
    ['list']           = false,
    ['number']         = false,
    ['relativenumber'] = false,
    ['signcolumn']     = "no",
    ['spell']          = false,
    ['statuscolumn']   = "",
    ['concealcursor']  = "nvic"
}
local norm_opts = {}
for opt, _ in pairs(zm_opts) do
    norm_opts[opt] = vim.api.nvim_win_get_option(0, opt)
end

function M.getZM(win)
    if not win then win = vim.api.nvim_get_current_win() end
    return zm_table[win]
end

function M.toggle(win)
    if not win then win = vim.api.nvim_get_current_win() end
    local opts

    if zm_table[win] then
        opts = norm_opts

        zm_table[win] = nil
    else
        opts = zm_opts

        zm_table[win] = true
    end

    for opt, val in pairs(opts) do
        vim.api.nvim_win_set_option(win, opt, val)
    end

    require("myplugs.statusline").reload()
end

require("mappings").map2("n", "<leader>zm", M.toggle, { noremap = true })

return M
