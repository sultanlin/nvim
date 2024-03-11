local M = {}

M.config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
        linters_by_ft = {
            -- markdown = { "vale" }, -- WARN: Vale requires config, not set up
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            svelte = { "eslint_d" },
            -- css = { "eslint_d" },
            -- html = { "eslint_d" },
            -- json = { "eslint_d" },
            -- yaml = { "eslint_d" },
            -- graphql = { "eslint_d" },
            nix = { "statix" },
            sql = { "sqlfluff" },
            dockerfile = { "hadolint" },
            -- bash = { "shellcheck" },
            -- zsh = { "shellcheck" },
        },
    }

    lint.linters = {
        sqlfluff = {
            -- args = {}
            args = { "--dialect", "postgres" }, -- change to your dialect
            -- args = { "--dialect postgres", }, -- change to your dialect
        },
    }

    -- https://www.youtube.com/watch?v=ybUE4D80XSk
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
            lint.try_lint()
        end,
    })

    vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
    end, { desc = "Trigger linting for current file" })
end

return M
-- diagnostics.vale.with({
--     extra_filetypes = { "txt", "text" },
--     extra_args = { "--config=/home/aaron/.config/vale/.vale.ini" },
-- }),
