return {
    {
        "williamboman/mason.nvim",
        opts = {}
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "lua_ls",
                "clangd",
                "bashls",
                "jdtls",
                "pyright",
                "biome",
                "cssls",
                "html",
            },
        }
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")

            lspconfig.pyright.setup({})
            lspconfig.biome.setup({})
            lspconfig.jdtls.setup({})
            lspconfig.cssls.setup({})
            lspconfig.html.setup({})
            lspconfig.lua_ls.setup({
                capabilities = {
                    offsetEncoding = "utf-8",
                },
                root_dir = lspconfig.util.root_pattern(".git", ".todo", "bob"),
            })
            lspconfig.bashls.setup({
                root_dir = lspconfig.util.root_pattern(".git", ".todo", "bob"),
            })

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
                -- root_dir = lspconfig.util.root_pattern("bob", ".git"),
                root_dir = lspconfig.util.root_pattern(
                    '.clangd',
                    '.clang-tidy',
                    '.clang-format',
                    'compile_commands.json',
                    'compile_flags.txt',
                    'configure.ac',
                    '.git',
                    'bob'
                ),

                capabilities = {
                    textDocument = {
                        completion = {
                            editsNearCursor = true,
                        },
                    },
                    offsetEncoding = "utf-8", -- "utf-16" },
                },
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- -- Enable completion triggered by <c-x><c-o>
                    -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- local kset = vim.keymap.set
                    local kset = require("mappings").map2
                    local opts = { buffer = ev.buf }
                    kset('n', 'gD', vim.lsp.buf.declaration, opts)
                    kset('n', 'gd', vim.lsp.buf.definition, opts)
                    kset('n', 'K', vim.lsp.buf.hover, opts)
                    kset('n', 'gi', vim.lsp.buf.implementation, opts)
                    kset('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    -- kset('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                    -- kset('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    -- kset('n', '<space>wl', function()
                    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    -- end, opts)
                    kset('n', '<space>D', vim.lsp.buf.type_definition, opts)
                    -- kset('n', '<space>rn', vim.lsp.buf.rename, opts)
                    kset({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                    kset('n', 'gr', vim.lsp.buf.references, opts)
                    kset('n', '<space>gf', function()
                        vim.lsp.buf.format({ async = true })
                    end, opts)
                end,
            })
        end,
    },
}
