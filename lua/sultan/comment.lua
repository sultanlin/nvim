local M = {
    "numToStr/Comment.nvim",
    lazy = false,
    dependencies = {
        {
            "JoosepAlviste/nvim-ts-context-commentstring",
            event = "VeryLazy",
        },
    },
}

M.config = function()
    local wk = require "which-key"
    wk.register {
        ["<leader>/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment" },
    }
    wk.register {
        ["<leader>/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment", mode = "v" },
    }

    vim.g.skip_ts_context_commentstring_module = true
    ---@diagnostic disable: missing-fields
    require("ts_context_commentstring").setup {
        enable_autocmd = false,
    }

    local ts_context_commentstring = require "ts_context_commentstring.integrations.comment_nvim"
    -- enable comment
    require("Comment").setup {
        -- for commenting tsx and jsx files
        pre_hook = ts_context_commentstring.create_pre_hook(),
    }
end

return M
