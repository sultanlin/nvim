local M = {
    "catppuccin/nvim",
    dependencies = {
        "folke/tokyonight.nvim",
        "rebelot/kanagawa.nvim",
        "ellisonleao/gruvbox.nvim",
        "catppuccin/nvim",
        "EdenEast/nightfox.nvim",
        "rose-pine/neovim",
        "navarasu/onedark.nvim",
        "rmehri01/onenord.nvim",
        "Shatur/neovim-ayu",
        "loctvl842/monokai-pro.nvim",
        "nyoom-engineering/oxocarbon.nvim",

        -- Not neovim, can't configure with lua
        "sainnhe/gruvbox-material",
        "sainnhe/sonokai",
        "sainnhe/everforest",
        "mhartington/oceanic-next",
        "sonph/onehalf",
        "shaunsingh/nord.nvim",
        "NLKNguyen/papercolor-theme",
        "bluz71/vim-nightfly-colors",
        "cocopon/iceberg.vim",
    },
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
}

M.config = function()
    -- Pick colorscheme here
    ColorMyPencils("catppuccin")
end

function ColorMyPencils(color)
    color = color or "rose-pine"

    require("sultan.colorscheme").colors()

    vim.cmd.colorscheme(color)

    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    -- -- vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
end

M.colors = function()
    require("tokyonight").setup({
        -- style = "storm", -- The theme comes in three styles, 'storm', 'moon', a darker variant 'night' and 'day'
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
        -- lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
    })

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

    require("gruvbox").setup({
        transparent_mode = true,
        italic = {
            strings = false,
            emphasis = false,
            comments = false,
            folds = false,
        },
        -- inverse = true, -- invert background for search, diffs, statuslines and errors
        -- contrast = "", -- can be "hard", "soft" or empty string
    })

    require("kanagawa").setup({
        -- theme = "wave", -- Load "wave" theme when 'background' option is not set
        -- background = { -- map the value of 'background' option to a theme
        --     dark = "wave", -- try "dragon" !
        --     light = "lotus",
        -- },
        commentStyle = { italic = false },
        keywordStyle = { italic = false },
        transparent = true, -- do not set background color
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
    })

    require("rose-pine").setup({
        -- variant = "auto", -- auto, main, moon, or dawn
        styles = {
            transparency = true,
            italic = false,
        },
    })

    require("nightfox").setup({
        options = {
            transparent = true, -- Disable setting background
        },
    })

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

    require("onenord").setup({
        disable = {
            background = true, -- Disable setting the background color
            float_background = true, -- Disable setting the background color for floating windows
        },
    })

    require("monokai-pro").setup({
        transparent_background = true,
        styles = {
            comment = { italic = false },
            keyword = { italic = false }, -- any other keyword
            type = { italic = false }, -- (preferred) int, long, char, etc
            tag_attribute = { italic = false }, -- attribute of tag in reactjs
        },
        filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
    })

    -- VIM COLORSCHEMES

    -- gruvbox-material
    vim.g.gruvbox_material_disable_italic_comment = 1
    -- Choose 0, 1 or 2. 2 is more transparent (ex statusline). 0 to turn off transparent
    vim.g.gruvbox_material_transparent_background = 1

    -- Nord setup
    vim.g.nord_disable_background = true
    vim.g.nord_italic = false

    -- nightfly
    vim.g.nightflyTransparent = true
    vim.g.nightflyItalics = false
end

return M

-- # bamboo-nvim not yet available
-- oxocarbon-nvim
