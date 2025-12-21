return {
    "shaunsingh/nord.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        -- Nord setup
        vim.g.nord_disable_background = true
        vim.g.nord_italic = false
    end,
}
