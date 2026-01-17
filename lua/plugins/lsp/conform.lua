return {
    "stevearc/conform.nvim",
    -- event = { "BufReadPre", "BufNewFile" },
    -- lazy = true,
    event = "VeryLazy",
    keys = {
        {
            "<leader>lf",
            function()
                -- timeout_ms = 500,
                require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 3000 })
                -- require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
            end,
            mode = { "n", "v" },
            desc = "Format file or range (in visual mode)",
        },
    },
    config = function()
        local web_formatters = {
            -- "prettierd",
            "prettier",
            "rustywind",
        }
        local paths = {
            stylua_config = vim.fn.expand("$HOME/.config/nvim/.stylua.toml"),
            -- prettierd_config = vim.fn.expand("$HOME/.config/nvim/.prettierrc"),
        }
        require("conform").setup({
            log_level = vim.log.levels.DEBUG,
            format_on_save = {
                -- timeout_ms = 500,
                -- timeout_ms = 1250,
                lsp_fallback = true,
            },
            -- format_after_save = {
            --     -- lsp_fallback = true,
            --     lsp_format = "callback",
            -- },
            -- Set default options
            default_format_opts = {
                timeout_ms = 3000,
                async = false, -- not recommended to change
                quiet = false, -- not recommended to change
                lsp_format = "fallback",
            },
            formatters = {
                -- xmlformat = {
                -- 	cmd = { "xmlformat" },
                -- 	args = { "--selfclose", "-" },
                -- },
                ["google-java-format"] = {
                    prepend_args = {
                        "-aosp",
                    },
                },
                stylua = {
                    prepend_args = { "--config-path", paths.stylua_config },
                },
                shfmt = {
                    prepend_args = { "-i", "2", "-ci", "-bn" },
                },
                -- prettierd = {
                --     env = {
                --         PRETTIERD_DEFAULT_CONFIG = paths.prettierd_config,
                --     },
                -- },
                prettier = {
                    prepend_args = {
                        "--no-semi",
                        -- "--single-quote",
                        -- "--jsx-single-quote",
                        "--html-whitespace-sensitivity",
                        "ignore",
                    },
                },

                ["markdown-toc"] = {
                    condition = function(_, ctx)
                        for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
                            if line:find("<!%-%- toc %-%->") then
                                return true
                            end
                        end
                    end,
                },
                ["markdownlint-cli2"] = {
                    condition = function(_, ctx)
                        local diag = vim.tbl_filter(function(d)
                            return d.source == "markdownlint"
                        end, vim.diagnostic.get(ctx.buf))
                        return #diag > 0
                    end,
                },
            },
            formatters_by_ft = {
                lua = { "stylua" },
                -- python = { "ruff_fix ", "ruff_format" },
                -- Use a sub-list to run only the first available formatter
                javascript = web_formatters,
                typescript = web_formatters,
                typescriptreact = web_formatters,
                javascriptreact = web_formatters,
                svelte = web_formatters,
                css = web_formatters,
                astro = web_formatters,
                html = web_formatters,
                htmlangular = web_formatters,
                json = web_formatters,
                jsonc = web_formatters,
                yaml = web_formatters,
                graphql = web_formatters,
                -- html = { "prettier", stop_after_first = true },
                -- json = { "prettier", stop_after_first = true },
                -- jsonc = { "prettier", stop_after_first = true },
                -- -- json = { { "fixjson",  "prettier" } },
                -- yaml = { "prettier", stop_after_first = true },
                -- graphql = { "prettier", stop_after_first = true },

                -- cs = { "csharpier" },
                -- xml = { "xmlformat" },
                -- yaml = { "yamlfix" },
                -- Conform will run multiple formatters sequentially
                go = { "gofmt", "goimports", "templ" },
                templ = { "templ", "gofmt", "goimports" },
                nix = { "alejandra" },
                -- rust = { "rustfmt" },
                sh = { "shfmt", "shellcheck" },
                bash = { "shfmt", "shellcheck" },
                fish = { "fish_indent" },
                zsh = { "shfmt", "shellcheck" },

                toml = { "taplo" }, -- TOML

                java = { "google-java-format" },
                cpp = { "clang-format" },

                ["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
                ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
            },
            -- Snacks.toggle({
            --     name = "auto formatting buf",
            --     get = function()
            --         return not vim.b.disable_autoformat ~= false
            --     end,
            --     set = function(state)
            --         if state then
            --             vim.cmd("FormatEnable!")
            --         else
            --             vim.cmd("FormatDisable!")
            --         end
            --     end,
            -- }):map("<leader>uf"),
            -- From: https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
            vim.api.nvim_create_user_command("FormatDisable", function(args)
                if args.bang then
                    -- FormatDisable! will disable formatting just for this buffer
                    vim.b.disable_autoformat = true
                else
                    vim.g.disable_autoformat = true
                end
            end, {
                desc = "Disable autoformat-on-save",
                bang = true,
            }),
            vim.api.nvim_create_user_command("FormatEnable", function(args)
                if args.bang then
                    vim.b.disable_autoformat = false
                else
                    vim.g.disable_autoformat = false
                end
            end, {
                desc = "Re-enable autoformat-on-save",
                bang = true,
            }),
        })
    end,
}
-- 		nls.builtins.formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "2" } }),
-- 		nls.builtins.formatting.prettier.with({
-- 			extra_args = { "--single-quote", "false", "--html-whitespace-sensitivity", "css" },
-- 		}),
-- 		nls.builtins.formatting.prettierd.with({
-- 			extra_args = { "--single-quote", "false", "--html-whitespace-sensitivity", "css" },
-- 		}),
-- 		nls.builtins.formatting.terraform_fmt,
-- 		nls.builtins.formatting.latexindent.with({
-- 			extra_args = { "-g", "/dev/null" }, -- https://github.com/cmhughes/latexindent.pl/releases/tag/V3.9.3
-- 		}),
