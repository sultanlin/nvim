return {
    "ellisonleao/gruvbox.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins

    config = function()
        require("gruvbox").setup({
            transparent_mode = false,
            italic = {
                strings = false,
                emphasis = false,
                comments = false,
                folds = false,
                operators = false,
            },
            -- inverse = true, -- invert background for search, diffs, statuslines and errors
            -- contrast = "", -- can be "hard", "soft" or empty string
        })
    end,
}
