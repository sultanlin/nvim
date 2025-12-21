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
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undotree" })
        end,
    },

    -- {
    --     "MaxMEllon/vim-jsx-pretty",
    --     event = "VeryLazy",
    -- },
}
