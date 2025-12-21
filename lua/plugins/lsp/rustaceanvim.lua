return {
    {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {
            completion = {
                crates = {
                    enabled = true,
                },
            },
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
        },
    },
    {
        "mrcjkb/rustaceanvim",
        ft = { "rust" },
        -- version = "^6", -- Recommended
        -- lazy = false, -- This plugin is already lazy
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
                        -- settings = {
                        default_settings = {
                            -- rust-analyzer language server configuration
                            ["rust-analyzer"] = {
                                assist = {
                                    importEnforceGranularity = true,
                                    importPrefix = "self",
                                },
                                cargo = {
                                    allFeatures = true,
                                    loadOutDirsFromCheck = true,
                                    buildScripts = { enable = true },
                                    -- runBuildScripts = true,
                                },
                                checkOnSave = true,
                                check = {
                                    -- default: `cargo check`
                                    command = "clippy",
                                    allTargets = true,
                                    -- allFeatures = true,
                                },
                                procMacro = {
                                    enable = true,
                                    ignored = {
                                        ["async-trait"] = { "async_trait" },
                                        ["napi-derive"] = { "napi" },
                                        ["async-recursion"] = { "async_recursion" },
                                    },
                                },
                                inlayHints = {
                                    chainingHints = {
                                        bindingModeHints = { enable = true },
                                        closureCaptureHints = { enable = true },
                                        closureReturnTypeHints = { enable = "always" }, -- "never"
                                        discriminantHints = { enable = "always" }, -- "never"
                                        implicitDrops = { enable = true },
                                        lifetimeElisionHints = { enable = "always", useParameterNames = true }, -- "never"
                                        rangeExclusiveHints = { enable = true },
                                    },
                                    parameterHints = true,
                                    typeHints = true,
                                },
                                lens = { enable = true },
                                -- LazyVim
                                files = {
                                    exclude = {
                                        ".direnv",
                                        ".git",
                                        ".jj",
                                        ".github",
                                        ".gitlab",
                                        "bin",
                                        "node_modules",
                                        "target",
                                        "venv",
                                        ".venv",
                                    },
                                    -- Avoid Roots Scanned hanging, see https://github.com/rust-lang/rust-analyzer/issues/12613#issuecomment-2096386344
                                    watcher = "client",
                                },
                                diagnostics = { enable = true },
                            },
                        },
                    },
                    dap = {
                        adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path),
                    },
                }
            end
            rust_setup()
        end,
    },
}
