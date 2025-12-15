local M = {}

M.config = function()
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")
    require("ts_context_commentstring").setup({
        -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
        context_commentstring = {
            -- enable = true,
            enable_autocmd = false,
        },
    })

    -- configure treesitter
    treesitter.setup({
        -- enable syntax highlighting
        highlight = { enable = true },
        -- enable indentation
        indent = { enable = true },
        -- enable autotagging (w/ nvim-ts-autotag plugin)
        -- autotag = { enable = true },
        -- -- ensure these language parsers are installed
        -- managed with nixos
        -- ensure_installed = "all",
        incremental_selection = {
            enable = true,
            keymaps = {
                -- init_selection = "<C-space>",
                -- node_incremental = "<C-space>",
                -- scope_incremental = false,
                -- node_decremental = "<bs>",
                init_selection = "gnn",
                node_incremental = "g]",
                scope_incremental = false,
                node_decremental = "g[",
            },
        },
    })
end

return M
