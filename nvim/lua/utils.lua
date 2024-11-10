local M = {}

-------------------------------------------------------------------------------

---@param  hl   string
---@param  link string
---@param  opts table?
---@return boolean
M.gen_hl_from_link = function(hl, link, opts)
    link = vim.api.nvim_get_hl(0, { name = link })

    if vim.tbl_isempty(link) then
        vim.api.nvim_err_writeln("utils: unkonw hl '" .. link .. "'")
        return false
    end

    if opts then
        for k, v in pairs(opts) do link[k] = v end
    end

    vim.api.nvim_set_hl(0, hl, link)
    return true
end

-------------------------------------------------------------------------------

local get_str = function(v)
    if type(v) ~= "table" then
        return tostring(v)
    else
        return vim.inspect(v)
    end
end
local helper = function(f)
    return function(v)
        f(get_str(v)); return v
    end
end
P = helper(print)
N = helper(vim.notify)
E = helper(vim.api.nvim_err_writeln)

T = function(fun, ...)
    local start_time = os.clock()

    local result = fun(...)

    local end_time = os.clock()

    local elapsed_time = end_time - start_time
    print(string.format("time: %.4f seconds", elapsed_time))

    return result
end

R = function(module)
    package.loaded[module] = nil

    -- clear any submodules if your plugin has them
    for k in pairs(package.loaded) do
        if k:match('^' .. module) then
            package.loaded[k] = nil
        end
    end
    vim.notify("reloaded")
    return require(module)
end
U = function(module)
    package.loaded[module] = nil

    -- clear any submodules if your plugin has them
    for k in pairs(package.loaded) do
        if k:match('^' .. module) then
            package.loaded[k] = nil
        end
    end
end

RR = function()
    R("lumberjack").setup({})
    R("beta").setup({})
    -- R("myplugs.comment-blocks").setup({})
end

-------------------------------------------------------------------------------

M.reload = R
M.unload = U

require("mappings").map2('n', '<leader>rl', RR, { noremap = true })

return M
