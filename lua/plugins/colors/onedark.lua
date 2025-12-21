return {
    "navarasu/onedark.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        require("onedark").setup({
            -- Main options --
            style = "dark", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
            transparent = true, -- Show/hide background
            code_style = {
                comments = "none",
            },

            -- Lualine options --
            lualine = {
                transparent = true, -- lualine center bar transparency
            },

            -- Plugins Config --
            -- diagnostics = {
            --     background = true,    -- use background color for virtual text
            -- },
        })
    end,
}
