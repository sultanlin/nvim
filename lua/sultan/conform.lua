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
            prettierd = {
                -- prepend_args = { "html-whitespace-sensitivity", "ignore" },
                -- env = {
                --     htmlWhitespaceSensitivity = "ignore",
                -- },
                prepend_args = {
                    "--no-semi",
                    "--single-quote",
                    "--jsx-single-quote",
                    "--html-whitespace-sensitivity ignore",
                    -- "ignore",
                },
            },
        },
        formatters_by_ft = {
            lua = { "stylua" },
            -- python = { "ruff_fix ", "ruff_format" },
            javascript = { { "prettierd", "prettier" } },
            typescript = { { "prettierd", "prettier" } },
            typescriptreact = { { "prettierd", "prettier" } },
            javascriptreact = { { "prettierd", "prettier" } },
            svelte = { { "prettierd", "prettier" } },
            css = { { "prettierd", "prettier" } },
            html = { { "prettierd", "prettier" } },
            json = { { "prettierd", "prettier" } },
            yaml = { { "prettierd", "prettier" } },
            markdown = { { "prettierd", "prettier" } },
            graphql = { { "prettierd", "prettier" } },

            -- cs = { "csharpier" },
            -- markdown = { "mdformat" },
            -- xml = { "xmlformat" },
            -- yaml = { "yamlfix" },
            go = { "goimports", "gofmt", "templ" },
            templ = { "templ", "goimports", "gofmt" },
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
