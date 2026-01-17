---@module 'lazy'
---@type LazySpec
return {
    {
        "b0o/schemastore.nvim",
        lazy = true,
    },
    {
        "tpope/vim-sleuth",
        event = "VeryLazy",
    },
    {
        "christoomey/vim-tmux-navigator",
        event = "VeryLazy",
    },

    {
        "mbbill/undotree",
        event = "VeryLazy",
        config = function()
            vim.keymap.set("n", "<leader>U", vim.cmd.UndotreeToggle, { desc = "Undotree" })
        end,
    },
    {
        "NMAC427/guess-indent.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
    },
    "neovim/nvim-lspconfig",
    -- {
    --     "MaxMEllon/vim-jsx-pretty",
    --     event = "VeryLazy",
    -- },
}
