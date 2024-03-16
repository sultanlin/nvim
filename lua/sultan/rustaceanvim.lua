local M = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        {
            "folke/neodev.nvim",
        },
    },
}

M.config = function()
    local rust_setup = function()
        -- Update this path
        -- local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/"
        local extension_path = os.getenv("LSP_CODELLDB") .. "/share/vscode/extensions/vadimcn.vscode-lldb/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = extension_path .. "lldb/lib/liblldb"
        local this_os = vim.uv.os_uname().sysname
        -- The path is different on Windows
        if this_os:find("Windows") then
            codelldb_path = extension_path .. "adapter\\codelldb.exe"
            liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
        else
            -- The liblldb extension is .so for Linux and .dylib for MacOS
            liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
        end
        local cfg = require("rustaceanvim.config")
        local my_lsp = require("sultan.lspconfig")

        vim.g.rustaceanvim = {
            -- Plugin configuration
            tools = {
                -- executor = "toggleterm",
                autoSetHints = true,
                inlay_hints = {
                    show_parameter_hints = true,
                    parameter_hints_prefix = "in: ", -- "<- "
                    other_hints_prefix = "out: ", -- "=> "
                },
            },
            -- LSP configuration
            --
            -- REFERENCE:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            -- https://rust-analyzer.github.io/manual.html#configuration
            -- https://rust-analyzer.github.io/manual.html#features
            --
            -- NOTE: The configuration format is `rust-analyzer.<section>.<property>`.
            --       <section> should be an object.
            --       <property> should be a primitive.
            server = {
                on_attach = function(client, bufnr)
                    my_lsp.on_attach(client, bufnr)
                    -- require("lsp-inlayhints").setup({
                    --     inlay_hints = { type_hints = { prefix = "=> " } },
                    -- })
                    -- require("lsp-inlayhints").on_attach(client, bufnr)
                    require("illuminate").on_attach(client)

                    local bufopts = {
                        noremap = true,
                        silent = true,
                        buffer = bufnr,
                    }
                    vim.keymap.set("n", "<leader>rr", "<Cmd>RustLsp runnables<CR>", bufopts)
                    vim.keymap.set("n", "K", "<Cmd>RustLsp hover actions<CR>", bufopts)
                end,
                capabilities = my_lsp.capabilities,
                settings = {
                    -- rust-analyzer language server configuration
                    ["rust-analyzer"] = {
                        assist = {
                            importEnforceGranularity = true,
                            importPrefix = "create",
                        },
                        cargo = {
                            allFeatures = true,
                            loadOutDirsFromCheck = true,
                            runBuildScripts = true,
                        },
                        checkOnSave = {
                            -- default: `cargo check`
                            command = "clippy",
                            allFeatures = true,
                        },
                        inlayHints = {
                            lifetimeElisionHints = {
                                enable = true,
                                useParameterNames = true,
                            },
                        },
                        procMacro = {
                            enable = true,
                            ignored = {
                                ["async-trait"] = { "async_trait" },
                                ["napi-derive"] = { "napi" },
                                ["async-recursion"] = { "async_recursion" },
                            },
                        },
                    },
                },
            },
            dap = {
                adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
            },
        }
    end
    rust_setup()
end

return M
