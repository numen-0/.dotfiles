-- LazyPlug
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local opts = {}

require("settings")
require("lazy").setup("plugins")

-- themes
local theme = "habamax"

if string.match(theme, "kanagawa") then
    vim.cmd.colorscheme "kanagawa-dragon" -- {-dragon, -lotus, -wave}
elseif string.match(theme, "catppuccin") then
    vim.cmd.colorscheme "catppuccin" -- {-latte, -frappe, -macchiato, -mocha}
elseif string.match(theme, "habamax") then
    vim.cmd.colorscheme "habamax"
    vim.cmd("hi VertSplit ctermbg=None guibg=None guifg=#9e9e9e")
    vim.cmd("hi StatusLineNC guibg=#9e9e9e")
    vim.cmd("hi WinSeparator ctermbg=None guibg=None guifg=#9e9e9e")
elseif string.match(theme, "film_noir") then
	vim.g.film_noir_color = "blue" -- {red, blue, green} 
	vim.cmd.colorscheme("film_noir")
	vim.cmd("highlight SignColumn guibg=#000000")

    vim.cmd("hi String ctermbg=None guibg=None")
    vim.cmd("hi Comment ctermbg=None guibg=None")
    vim.cmd("hi Number ctermbg=None guibg=None")
    vim.cmd("hi SignColumn ctermbg=None guibg=None")
    vim.cmd("hi Normal ctermbg=None guibg=None")
    vim.cmd("hi Keyword ctermbg=None guibg=None gui=bold")
    vim.cmd("hi Constant ctermbg=None guibg=None")
    -- vim.cmd("hi link Delimiter Keyword")
    vim.cmd("hi link SpecialChar String")
    vim.cmd("hi SpecialChar gui=bold")
    -- vim.cmd("hi Operator gui=None")

    vim.cmd("highlight ColorColumn guibg=#13263a")
	vim.cmd("autocmd InsertEnter * highlight CursorLine guibg=#181818")
	vim.cmd("autocmd InsertLeave * highlight CursorLine guibg=#121212")
end


require("zenmode").toggleZenMode()
require("statusline").reload()


--============================================================================--
-- function Foo()
-- end
-- function GetDiagnostics()
--     local bufnr = vim.api.nvim_get_current_buf()
--     local diagnostics = vim.diagnostic.get(bufnr)
--     for index, data in ipairs(diagnostics) do
--         print(index)
--         for key, value in pairs(data) do
--             print('  ', key, value)
--         end
--     end
-- end
-- local function filter_diagnostics(diagnostic)
--     return diagnostic.severity ~= vim.lsp.protocol.DiagnosticSeverity.Hint
--             and diagnostic.severity ~= vim.lsp.protocol.DiagnosticSeverity.Information
-- end
-- vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
--   function(_, result, ctx, config)
--         local arr = {}
--         local len = 0
--         for i, diagnostic in ipairs(result.diagnostics) do
--             if filter_diagnostics(diagnostic) then
--                 len = len + 1
--                 arr[len] = i
--             end
--         end
--         for i = len, 1, -1 do
--             table.remove(result.diagnostics, arr[i])
--         end
--         vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
--   end,
--   {}
-- )
