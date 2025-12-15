return {
    "mrcjkb/rustaceanvim",
    event = { "BufReadPre", "BufNewFile" },
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function()
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
            local my_lsp = require("sultan.lsp.lspconfig")

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
                        -- require("illuminate").on_attach(client)

                        local bufopts = {
                            noremap = true,
                            silent = true,
                            buffer = bufnr,
                        }
                        vim.keymap.set("n", "<leader>rr", "<Cmd>RustLsp runnables<CR>", bufopts)
                        vim.keymap.set("n", "K", "<Cmd>RustLsp hover actions<CR>", bufopts)
                    end,
                    capabilities = my_lsp.capabilities,
                    -- settings = {
                    default_settings = {
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
                            procMacro = {
                                enable = true,
                                ignored = {
                                    ["async-trait"] = { "async_trait" },
                                    ["napi-derive"] = { "napi" },
                                    ["async-recursion"] = { "async_recursion" },
                                },
                            },
                            -- inlayHints = {
                            --     lifetimeElisionHints = {
                            --         enable = true,
                            --         useParameterNames = true,
                            --     },
                            -- },
                            inlayHints = {
                                chainingHints = {
                                    bindingModeHints = {
                                        enable = true,
                                    },
                                    chainingHints = {
                                        enable = true,
                                    },
                                    closingBraceHints = {
                                        enable = true,
                                        minLines = 25,
                                    },
                                    closureCaptureHints = {
                                        enable = true,
                                    },
                                    closureReturnTypeHints = {
                                        enable = "always", -- "never"
                                    },
                                    closureStyle = "impl_fn",
                                    discriminantHints = {
                                        enable = "always", -- "never"
                                    },
                                    expressionAdjustmentHints = {
                                        hideOutsideUnsafe = false,
                                        mode = "prefix",
                                    },
                                    implicitDrops = {
                                        enable = true,
                                    },
                                    lifetimeElisionHints = {
                                        enable = "always", -- "never"
                                        useParameterNames = true,
                                    },
                                    maxLength = 25,
                                    parameterHints = {
                                        enable = true,
                                    },
                                    rangeExclusiveHints = {
                                        enable = true,
                                    },
                                    renderColons = {
                                        enable = true,
                                    },
                                    typeHints = {
                                        enable = true,
                                        hideClosureInitialization = false,
                                        hideNamedConstructor = false,
                                    },
                                },
                            },
                            lens = {
                                enable = true,
                            },
                        },
                    },
                },
                -- Currently broken, try again later
                -- https://github.com/mrcjkb/rustaceanvim/issues/446
                -- dap = {
                --     adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
                -- },
            }
        end
        rust_setup()
    end,
}
