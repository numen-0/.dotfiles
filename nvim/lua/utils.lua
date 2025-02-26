local M = {}

-------------------------------------------------------------------------------

---@param  hl   string
---@param  link string
---@param  opts table?
---@return boolean err
M.gen_hl_from_link = function(hl, link, opts)
    link = vim.api.nvim_get_hl(0, { name = link })

    if vim.tbl_isempty(link) then
        vim.api.nvim_err_writeln("utils: unkonw hl '" .. link .. "'")
        return false
    end

    if opts then
        link = vim.tbl_extend("force", link, opts)
    end

    vim.api.nvim_set_hl(0, hl, link)
    return true
end

-------------------------------------------------------------------------------

-- src: https://github.com/craftzdog/dotfiles-public/blob/master/.config/nvim/lua/craftzdog/discipline.lua
M.cowboy = function()
    ---@type table?
    local id
    local ok = true
    for _, key in ipairs({ "h", "j", "k", "l", "+", "-" }) do
        local count = 0
        local timer = assert(vim.loop.new_timer())
        local map = key
        vim.keymap.set("n", key, function()
            if vim.v.count > 0 then
                count = 0
            end
            if count >= 10 then
                ok, id = pcall(vim.notify, "Hold it Cowboy!  ",
                    vim.log.levels.WARN, {
                        icon = "",
                        replace = id,
                        keep = function()
                            return count >= 10
                        end,
                    })
                if not ok then
                    id = nil
                    return map
                end
            else
                count = count + 1
                timer:start(2000, 0, function()
                    count = 0
                end)
                return map
            end
        end, { expr = true, silent = true })
    end
end

-------------------------------------------------------------------------------

local get_str = function(v)
    if type(v) ~= "table" then
        return tostring(v)
    else
        return vim.inspect(v)
    end
end
local p = function(f)
    return function(v)
        f(get_str(v)); return v
    end
end
P = p(print)
N = p(vim.notify)
E = p(vim.api.nvim_err_writeln)

T = function(fun, ...)
    local start_time = os.clock()

    local result = fun(...)

    local end_time = os.clock()

    local elapsed_time = end_time - start_time
    print(string.format("time: %.4f seconds", elapsed_time))

    return result
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
R = function(module)
    U(module)
    return require(module)
end

RR = function()
    -- R("lumberjack").setup({})
    -- R("glide").setup({})
    R("sketch").setup({})
    vim.notify("plugins reloaded")
end

-------------------------------------------------------------------------------

M.reload = R
M.unload = U

require("mappings").map2('n', '<leader>rl', RR, { noremap = true })
require("mappings").map2('n', '<leader>S', ':source %<cr>', { noremap = true })

return M
