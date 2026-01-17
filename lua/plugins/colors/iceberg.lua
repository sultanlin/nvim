return {
    "cocopon/iceberg.vim",
    cond = vim.g.colorscheme == "iceberg.vim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd.colorscheme("iceberg.vim")
    end,
}
-- {
--     "cocopon/iceberg.vim",
--     lazy = false, -- make sure we load this during startup if it is your main colorscheme
--     priority = 1000, -- make sure to load this before all the other start plugins
-- }
