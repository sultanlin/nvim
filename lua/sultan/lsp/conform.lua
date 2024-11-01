local M = {}

M.config = function()
    local conform = require("conform")
    local web_formatters = {
        "prettierd",
        "rustywind",
        "prettier",
    }
    local paths = {
        -- stylua_config = "/home/sultan/.config/nvim/.stylua.toml",
        stylua_config = vim.fn.expand("$HOME/.config/nvim/.stylua.toml"),
        prettierd_config = vim.fn.expand("$HOME/.config/nvim/.prettierrc"),
        -- prettier_config = "/home/sultan/.config/nvim/.prettierrc",
        -- prettier_config = "linters/prettier.json",
    }
    conform.setup({
        format_on_save = {
            -- BUG:timing out?!?
            -- timeout_ms = 500,
            timeout_ms = 700,
            lsp_fallback = true,
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
            prettierd = {
                env = {
                    PRETTIERD_DEFAULT_CONFIG = paths.prettierd_config,
                },
            },
            prettier = {
                prepend_args = {
                    "--no-semi",
                    -- "--single-quote",
                    -- "--jsx-single-quote",
                    "--html-whitespace-sensitivity",
                    "ignore",
                },
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
            html = { { "prettierd", "prettier" } },
            json = { { "prettierd", "prettier" } },
            jsonc = { { "prettierd", "prettier" } },
            -- json = { { "fixjson", "prettierd", "prettier" } },
            yaml = { { "prettierd", "prettier" } },
            -- markdown = { { "prettierd", "prettier" } },
            graphql = { { "prettierd", "prettier" } },

            -- cs = { "csharpier" },
            -- markdown = { "mdformat" },
            -- xml = { "xmlformat" },
            -- yaml = { "yamlfix" },
            -- Conform will run multiple formatters sequentially
            go = { "gofmt", "goimports", "templ" },
            templ = { "templ", "gofmt", "goimports" },
            nix = { "alejandra" },
            -- rust = { "rustfmt" },
            bash = { "shfmt", "shellcheck" },
            zsh = { "shfmt", "shellcheck" },
            java = { "google-java-format" },
            cpp = { "clang-format" },
        },

        -- Set format keybind
        vim.keymap.set({ "n", "v" }, "<leader>lf", function()
            conform.format({
                lsp_fallback = true,
                -- timeout_ms = 500,
                timeout_ms = 700,
            })
        end, { desc = "Format file or range (in visual mode)" }),
    })
end

return M
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
