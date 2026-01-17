return {
    "NLKNguyen/papercolor-theme",
    cond = vim.g.colorscheme == "papercolor-theme",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd.colorscheme("papercolor-theme")
    end,
}
-- {
--     "NLKNguyen/papercolor-theme",
--     lazy = false, -- make sure we load this during startup if it is your main colorscheme
--     priority = 1000, -- make sure to load this before all the other start plugins
-- }
