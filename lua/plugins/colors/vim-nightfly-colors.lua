return {
    "bluz71/vim-nightfly-colors",
    cond = vim.g.colorscheme == "vim-nightfly-colors",
    lazy = false,
    priority = 1000,
    config = function()
        -- nightfly
        vim.g.nightflyItalics = false
        vim.g.nightflyTransparent = false
        vim.cmd.colorscheme("vim-nightfly-colors")
    end,
}
-- {
--     "bluz71/vim-nightfly-colors",
--     lazy = false, -- make sure we load this during startup if it is your main colorscheme
--     priority = 1000, -- make sure to load this before all the other start plugins
-- }
