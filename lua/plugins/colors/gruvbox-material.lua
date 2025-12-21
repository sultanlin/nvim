return {
    "sainnhe/gruvbox-material",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins

    config = function()
        -- gruvbox-material
        -- vim.g.gruvbox_material_disable_italic_comment = 1

        -- -- Choose 0, 1 or 2. 2 is more transparent (ex statusline). 0 to turn off transparent
        -- vim.g.gruvbox_material_transparent_background = 1
    end,
}
