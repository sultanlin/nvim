-- return {
--     "nvim-mini/mini.comment",
--     dependencies = {
--         {
--             "JoosepAlviste/nvim-ts-context-commentstring",
--             event = "VeryLazy",
--         },
--     },
--     opts = {
--         options = {
--             custom_commentstring = function()
--                 return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
--             end,
--         },
--         config = {
--             require("ts_context_commentstring").setup({
--                 enable_autocmd = false,
--             }),
--         },
--     },
-- }
return {
    "numToStr/Comment.nvim",
    -- lazy = false,
    event = "VeryLazy",
    dependencies = {
        {
            "JoosepAlviste/nvim-ts-context-commentstring",
            event = "VeryLazy",
        },
    },
    config = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Comment", mode = { "v", "n" } },
        })

        vim.g.skip_ts_context_commentstring_module = true
        ---@diagnostic disable: missing-fields
        require("ts_context_commentstring").setup({
            enable_autocmd = false,
        })

        local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")
        -- enable comment
        require("Comment").setup({
            -- for commenting tsx and jsx files
            pre_hook = ts_context_commentstring.create_pre_hook(),
        })
    end,
}
