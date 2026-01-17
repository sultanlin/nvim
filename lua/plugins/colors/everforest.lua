return {
    "sainnhe/everforest",
    cond = vim.g.colorscheme == "everforest",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd.colorscheme("everforest")
    end,
}
-- {
--     "sainnhe/everforest",
--     lazy = false, -- make sure we load this during startup if it is your main colorscheme
--     priority = 1000, -- make sure to load this before all the other start plugins
-- }
