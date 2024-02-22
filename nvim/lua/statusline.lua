-- source (https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html)
Statusline = {}
Statusline.__index = Statusline

vim.cmd("hi StatusNorm guibg=#1c1c1c guifg=#9e9e9e")
vim.cmd("hi StatusInvert guibg=#9e9e9e guifg=#1c1c1c")
vim.cmd("hi StatusDark guibg=#1c1c1c guifg=#767676")
vim.cmd("hi StatusLight guibg=#9e9e9e guifg=#1c1c1c")
vim.cmd("hi StatusTerm guibg=#81ad7d guifg=#1c1c1c")
vim.cmd("hi StatusBold guibg=#1c1c1c guifg=#9e9e9e gui=bold")

-- -- vim.cmd("hi LspDiagnosticsSignError guibg=NONE guifg=#e12729") -- 730220")
-- -- vim.cmd("hi LspDiagnosticsSignWarning guibg=NONE guifg=#f37324") -- d7875f")
-- -- vim.cmd("hi LspDiagnosticsSignHint guibg=NONE guifg=#f29f05")
-- -- vim.cmd("hi LspDiagnosticsSignInformation guibg=NONE guifg=#95b8d1")
vim.cmd("hi LspDiagnosticsSignError guibg=NONE guifg=#9e9e9e") -- 730220")
vim.cmd("hi LspDiagnosticsSignWarning guibg=NONE guifg=#9e9e9e") -- d7875f")
vim.cmd("hi LspDiagnosticsSignHint guibg=NONE guifg=#9e9e9e")
vim.cmd("hi LspDiagnosticsSignInformation guibg=NONE guifg=#9e9e9e")

local modes = {
	["n"] = "n",
	["no"] = "n",
	["v"] = "v",
	["V"] = "V",
	[""] = "B",
	["s"] = "select",
	["S"] = "s-line",
	[""] = "s-block",
	["i"] = "i",
	["ic"] = "i",
	["R"] = "r",
	["Rv"] = "v-replace",
	["c"] = "c",
	["cv"] = "vim ex",
	["ce"] = "ex",
	["r"] = "prompt",
	["rm"] = "moar",
	["r?"] = "confirm",
	["!"] = "shell",
	["t"] = "t",
}
local function mode()
	local current_mode = vim.api.nvim_get_mode().mode
	return string.format("\\ %s", modes[current_mode])
end
local function filename()
	return "%t"
end
local function lsp()
	local count = {}
	local levels = {
		errors = "Error",
		warnings = "Warn",
		info = "Info",
		hints = "Hint",
	}

	for k, level in pairs(levels) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""

	if count["errors"] ~= 0 then
		errors = "\\ %#LspDiagnosticsSignError#\\ " .. count["errors"]
	end
	if count["warnings"] ~= 0 then
		warnings = "\\ %#LspDiagnosticsSignWarning#\\ " .. count["warnings"]
	end
	if count["hints"] ~= 0 then
		hints = "\\ %#LspDiagnosticsSignHint#\\ " .. count["hints"]
	end
	if count["info"] ~= 0 then
		info = "\\ %#LspDiagnosticsSignInformation#\\ " .. count["info"]
	end

	return "\\ " .. errors .. warnings .. hints .. info .. "%#Normal#"
end
local function lineinfo()
	if vim.bo.filetype == "alpha" then
		return ""
	end
	return "\\ \\ %02l:%02c\\ \\ "
end

local function filemodified()
	local changed = vim.api.nvim_exec2("echo &modified", { output = true }).output
	if changed == "1" then
		return "%#StatusBold#\\ \\ "
	end
	return "\\ "
end
Statusline = {}

local zenmode = require("zenmode")

Statusline.term = function()
	return "%#StatusNorm#%=bash%="
	-- return "%#StatusTerm#\\ terminal\\ %#StatusNorm#"
end
Statusline.active = function()
	if zenmode.getZM() then
		local mod = filemodified()
		return table.concat({
			"%#StatusNorm#%=",
			mod,
			filename(),
			mod,
			"%#StatusNorm#%=",
		})
	end
	return table.concat({
		"%#StatusLight#",
		mode(),
		"\\ %#StatusNorm#\\ ",
		filename(),
		filemodified(),
		lsp(),
		"%#StatusNorm#%=%S\\ \\ %#StatusLight#",
		lineinfo(),
	})
end
function Statusline.inactive()
	return "%#StatusNorm#\\ %f%m"
end

local state = "norm"

function Statusline.reload()
	if state == "norm" then
		vim.cmd("set statusline=" .. Statusline.active())
	elseif state == "bash" then
		vim.cmd("set statusline=" .. Statusline.term())
	elseif state == "neo-tree" then
		vim.cmd("setlocal statusline=%#StatusNorm#%=\\ neo-tree%=")
	end
end

-- auto
local group = vim.api.nvim_create_augroup("Statusline", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "BufModifiedSet" }, {
	pattern = { "*" },
	callback = function(_)
		state = "norm"
		vim.cmd("set statusline=" .. Statusline.active())
	end,
	group = group,
})
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "BufModifiedSet" }, {
	pattern = { "neo-tree*" },
	callback = function(_)
		state = "neo-tree"
		vim.cmd("setlocal statusline=%#StatusNorm#%=\\ neo-tree%=")
	end,
	group = group,
})
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "BufModifiedSet" }, {
	pattern = { "*:bash" },
	callback = function(_)
		state = "term"
		vim.cmd("set statusline=" .. Statusline.term())
	end,
	group = group,
})

return Statusline
