return {
    "nyoom-engineering/oxocarbon.nvim",
    cond = vim.g.colorscheme == "oxocarbon",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd.colorscheme("oxocarbon")
    end,
} -- {
--     "nyoom-engineering/oxocarbon.nvim",
--     lazy = false, -- make sure we load this during startup if it is your main colorscheme
--     priority = 1000, -- make sure to load this before all the other start plugins
-- }
