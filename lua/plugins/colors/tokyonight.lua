return {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        require("tokyonight").setup({
            -- style = "storm", -- The theme comes in three styles, 'storm', 'moon', a darker variant 'night' and 'day'
            -- style = "moon", -- The theme comes in three styles, 'storm', 'moon', a darker variant 'night' and 'day'
            style = "night", -- The theme comes in three styles, 'storm', 'moon', a darker variant 'night' and 'day'
            -- transparent = true, -- Enable this to disable setting the background color
            transparent = false, -- Enable this to disable setting the background color
            terminal_colors = true, -- Configure the colors used when opening a ':terminal' in neovim
            styles = {
                -- Value is any valid attr-list value for ':help nvim_set_hl'
                comments = { italic = false },
                keywords = { italic = false },
                -- Background styles. Can be "dark", "transparent" or "normal"
                sidebars = "dark", -- style for sidebars, see below
                floats = "dark", -- style for floating windows
            },
            sidebars = { "qf", "help", "neo-tree", "terminal", "packer" }, -- Set a darker background on sidebar-like windows
            day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style
            hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines
            dim_inactive = false, -- dims inactive windows
            lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

            -- --- You can override specific color groups to use other groups or a hex color
            -- --- function will be called with a ColorScheme table
            -- on_colors = function(colors)
            -- 	colors.bg = "#14161b"
            -- end,
            -- lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
        })
    end,
}
