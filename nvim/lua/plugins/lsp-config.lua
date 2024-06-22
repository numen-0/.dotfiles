return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"clangd",
					"bashls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			lspconfig.basedpyright.setup({})
			lspconfig.lua_ls.setup({
				capabilities = {
					offsetEncoding = "utf-8",
				},
			})
			lspconfig.bashls.setup({
				root_dir = lspconfig.util.root_pattern(".git", ".todo"),
			})

			-- local root_files = {
			--     ".clangd",
			--     ".clang-tidy",
			--     ".clang-format",
			--     "compile_commands.json",
			--     "compile_flags.txt",
			--     "configure.ac", -- AutoTools
			-- }
			--
			lspconfig.clangd.setup({
				cmd = {
					"clangd",
					"--background-index",
					"--pch-storage=memory",
					"--clang-tidy",
					"--suggest-missing-includes",
					"--cross-file-rename",
					"--completion-style=detailed",
				},
				init_options = {
					clangdFileStatus = true,
					usePlaceholders = true,
					completeUnimported = true,
					semanticHighlighting = true,
				},
				-- filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
				filetypes = { "c" },
				single_file_support = false,
				root_dir = lspconfig.util.root_pattern("bob", ".git"),
				capabilities = {
					textDocument = {
						completion = {
							editsNearCursor = true,
						},
					},
					offsetEncoding = "utf-8", -- "utf-16" },
				},
			})

            local map = require("mappings")
			local opts = {}
			map.map2("n", "gD", vim.lsp.buf.declaration, opts)
			map.map2("n", "gd", vim.lsp.buf.definition, opts)
			map.map2("n", "K", vim.lsp.buf.hover, opts)
			map.map2("n", "gi", vim.lsp.buf.implementation, opts)
			map.map2("n", "<C-k>", vim.lsp.buf.signature_help, opts)
			-- map.map2("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
			-- map.map2("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
			-- map.map2("n", "<space>wl", function()
			--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			-- end, opts)
			map.map2("n", "<space>D", vim.lsp.buf.type_definition, opts)
			map.map2("n", "<space>rn", vim.lsp.buf.rename, opts)
			map.map2({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
			map.map2("n", "gr", vim.lsp.buf.references, opts)
			map.map2("n", "<space>gf", function()
				vim.lsp.buf.format({ async = true })
			end, opts)
		end,
	},
}
