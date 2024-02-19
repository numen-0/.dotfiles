return {
	{
		"xiyaowong/virtcolumn.nvim",
		config = function()
			vim.g.virtcolumn_char = "▕" -- char to display the line
			vim.g.virtcolumn_priority = 10 -- priority of extmark
		end,
	},
	-- {
	-- 	"sudormrfbin/cheatsheet.nvim",
	-- 	requires = {
	-- 		{ "nvim-telescope/telescope.nvim" },
	-- 		{ "nvim-lua/popup.nvim" },
	-- 		{ "nvim-lua/plenary.nvim" },
	-- 	},
	-- },
}
