-- NOTE: it's a little bit ugly when we have a buf in 2 or more diferent windows
--       it is what it is.
local M = {}
local statusline = require("myplugs.statusline")
local o = vim.opt

local config = {
    default_zm = true,
    zm_opts = {
        ['colorcolumn']    = "-1",
        ['cursorline']     = false,
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
}

local zm_table = {}
local no_zm_opts = {}

function M.toggle()
    local buf = vim.api.nvim_get_current_buf()
    local opts

    if zm_table[buf] then
        zm_table[buf] = nil

        if config.default_zm then
            opts = config.zm_opts
            statusline.simple_mode()
        else
            opts = no_zm_opts
            statusline.norm_mode()
        end
    else
        zm_table[buf] = true

        if config.default_zm then
            opts = no_zm_opts
            statusline.norm_mode()
        else
            opts = config.zm_opts
            statusline.simple_mode()
        end
    end

    for opt, val in pairs(opts) do
        o[opt] = val
    end

    require("myplugs.statusline").reload()
end

function M.setup(opts)
    if opts then
        config = vim.tbl_extend("force", config, opts)
    end

    -- populate no_zm_opts and setup zm if default_zm == true
    for opt, val in pairs(config.zm_opts) do
        no_zm_opts[opt] = o[opt]
        if config.default_zm then
            o[opt] = val
        end
    end
    if config.default_zm then
        statusline.simple_mode()
    end

    -- autocmds
    local group = vim.api.nvim_create_augroup("ZenMode", { clear = true })
    vim.api.nvim_create_autocmd("BufDelete", {
        pattern  = "*",
        callback = function(ev)
            zm_table[ev.buf] = nil
        end,
        group    = group,
        desc     = "Unload buf opts"
    })
    vim.api.nvim_create_autocmd("BufEnter", {
        pattern  = "*",
        callback = function(ev)
            if zm_table[ev.buf] then
                if config.default_zm then
                    statusline.norm_mode()
                else
                    statusline.simple_mode()
                end
            else
                if config.default_zm then
                    statusline.simple_mode()
                else
                    statusline.norm_mode()
                end
            end
        end,
        group    = group,
        desc     = "Load buf opts"
    })

    -- mappings
    require("mappings").map2("n", "<leader>zm", M.toggle, { noremap = true })
end

return M
