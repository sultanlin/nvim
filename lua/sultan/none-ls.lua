local M = {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
}

function M.config()
    local null_ls = require("null-ls")

    -- Switched to conform and nvim lint
    -- local formatting = null_ls.builtins.formatting
    -- local diagnostics = null_ls.builtins.diagnostics

    -- Only using none-ls for code actions
    local codeaction = null_ls.builtins.code_actions

    null_ls.setup({
        debug = false,
        sources = {
            codeaction.statix,
            codeaction.gomodifytags,
            -- codeaction.shellcheck,
        },
    })
end

return M
