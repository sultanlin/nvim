return {
    "catppuccin/nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins

    config = function()
        require("catppuccin").setup({
            -- flavour = "mocha", -- latte, frappe, macchiato, mocha
            -- background = { -- :h background
            --     light = "latte",
            --     dark = "mocha",
            -- },
            transparent_background = true, -- disables setting the background color.
            term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
            no_italic = true, -- Force no italic
        })
    end,
}
