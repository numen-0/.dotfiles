return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = true,
					hide_gitignored = false,
				},
			},
			event_handlers = {
				{
					event = "file_opened",
					handler = function(_)
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
		})
        require("mappings").map("n", "<C-n>", ":Neotree filesystem toggle right<CR>")
	end,
}
