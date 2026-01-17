return {
    "catppuccin/nvim",
    cond = vim.g.colorscheme == "catppuccin",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    opts = {
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { -- :h background
            dark = "mocha",
            light = "latte",
        },
        -- transparent_background = true, -- disables setting the background color.
        term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
        -- no_italic = true, -- Force no italic
        lsp_styles = {
            underlines = {
                errors = { "undercurl" },
                hints = { "undercurl" },
                warnings = { "undercurl" },
                information = { "undercurl" },
            },
        },
        integrations = {
            diffview = true,
            grug_far = true,
            markview = true,
            lsp_trouble = true,
            mini = true,
            navic = { enabled = true, custom_bg = "lualine" },
            neotest = true,
            noice = true,
            notify = true,
            snacks = true,
            treesitter_context = true,
            which_key = true,
        },
    },
    config = function()
        vim.cmd.colorscheme("catppuccin")
    end,
}
-- {
--     "catppuccin/nvim",
--     lazy = false, -- make sure we load this during startup if it is your main colorscheme
--     priority = 1000, -- make sure to load this before all the other start plugins
--
--     config = function()
--         require("catppuccin").setup({
--             -- flavour = "mocha", -- latte, frappe, macchiato, mocha
--             -- background = { -- :h background
--             --     light = "latte",
--             --     dark = "mocha",
--             -- },
--             transparent_background = true, -- disables setting the background color.
--             term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
--             no_italic = true, -- Force no italic
--         })
--     end,
-- }
