return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            linters_by_ft = {
                markdown = { "markdownlint-cli2" },

                -- javascript = { "eslint_d" },
                -- typescript = { "eslint_d" },
                -- javascriptreact = { "eslint_d" },
                -- typescriptreact = { "eslint_d" },
                -- svelte = { "eslint_d" },

                -- css = { "eslint_d" },
                -- html = { "eslint_d" },
                -- json = { "eslint_d" },
                -- yaml = { "eslint_d" },
                -- graphql = { "eslint_d" },
                lua = { "selene" },
                nix = { "nix", "statix" },
                sql = { "sqlfluff" },
                dockerfile = { "hadolint" },
                sh = { "shellcheck" },
                bash = { "shellcheck" },
                zsh = { "shellcheck" },
                python = { "ruff" },
                cpp = { "cppcheck" },
            },
        }

        lint.linters = {
            ---@diagnostic disable-next-line: missing-fields
            sqlfluff = {
                args = { "--dialect", "postgres" }, -- change to your dialect
                -- args = { "--dialect postgres", }, -- change to your dialect
            },
        }

        -- Create autocommand to trigger linting
        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })

        vim.keymap.set("n", "<leader>lF", function()
            lint.try_lint()
        end, { desc = "Trigger linting for current file" })
    end,
}

-- diagnostics.vale.with({
--     extra_filetypes = { "txt", "text" },
--     extra_args = { "--config=/home/aaron/.config/vale/.vale.ini" },
-- }),
