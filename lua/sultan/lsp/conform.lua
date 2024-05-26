local M = {}

M.config = function()
    local conform = require("conform")
    conform.setup({
        format_on_save = {
            timeout_ms = 500,
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
            prettierd = {
                env = {
                    PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("$HOME/.config/nvim/.prettierrc"),
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
            javascript = { { "prettierd", "prettier" } },
            typescript = { { "prettierd", "prettier" } },
            typescriptreact = { { "prettierd", "prettier" } },
            javascriptreact = { { "prettierd", "prettier" } },
            svelte = { { "prettierd", "prettier" } },
            css = { { "prettierd", "prettier" } },
            html = { { "prettierd", "prettier" } },
            json = { { "prettierd", "prettier" } },
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
        },

        -- Set format keybind
        vim.keymap.set({ "n", "v" }, "<leader>lf", function()
            conform.format({
                lsp_fallback = true,
                timeout_ms = 500,
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
