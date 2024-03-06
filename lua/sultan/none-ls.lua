local M = {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
}

function M.config()
    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local codeaction = null_ls.builtins.code_actions

    null_ls.setup({
        debug = false,
        sources = {
            formatting.stylua,
            formatting.prettierd.with({
                extra_filetypes = { "svelte" },
                extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
            }),
            -- lua formatting.prettierd.with({ extra_filetypes = { "toml" }, env = { PRETTIERD_DEFAULT_CONFIG = vim.fn.expand( "~/.config/nvim/utils/prettier-config/.prettierrc.json" ), }, }),
            -- formatting.ruff,
            -- formatting.ruff_format,
            formatting.goimports,
            formatting.gofmt,
            formatting.templ,
            -- formatting.gofumpt,
            formatting.alejandra,
            formatting.rustfmt,
            formatting.shfmt,
            formatting.taplo,
            formatting.buf,
            formatting.shellharden,
            -- formatting.google_java_format,

            -- diagnostics.ruff,
            diagnostics.statix,
            -- diagnostics.vale, -- Missing config
            -- diagnostics.vale.with({
            --     extra_filetypes = { "txt", "text" },
            --     extra_args = { "--config=/home/aaron/.config/vale/.vale.ini" },
            -- }),
            diagnostics.hadolint,
            diagnostics.sqlfluff.with({
                extra_args = { "--dialect", "postgres" }, -- change to your dialect
            }),

            codeaction.statix,
            codeaction.shellcheck,
        },
        on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = bufnr,
                    callback = function()
                        -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                        -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                        -- vim.lsp.buf.format { async = false }
                        -- vim.lsp.buf.format({ bufnr = bufnr, description = "Format on save" })
                        vim.lsp.buf.format({ async = false, bufnr = bufnr, description = "Format on save" })
                    end,
                })
            end
        end,
    })
end

return M

-- formatters
-- cs = { "csharpier" },
-- markdown = { "mdformat" },
-- xml = { "xmlformat" },
-- yaml = { "yamlfix" },

-- use .prettier in project directory
-- conform.formatters.prettierd = {
-- 	prepend_args = { "html-whitespace-sensitivity", "ignore" },
-- 	-- env = {
-- 	-- 	htmlWhitespaceSensitivity = "ignore",
-- 	-- },
-- }
