return {
    "EdenEast/nightfox.nvim",
    cond = vim.g.colorscheme == "nightfox",
    lazy = false,
    priority = 1000,
    config = function(_, opts)
        require("nightfox").setup(opts)
        vim.cmd.colorscheme("nightfox")
        -- vim.cmd.colorscheme("carbonfox")
    end,
    opts = {
        -- options = {
        --     transparent = true, -- Disable setting background
        -- },
    },
}
-- {
--     "EdenEast/nightfox.nvim",
--     lazy = false, -- make sure we load this during startup if it is your main colorscheme
--     priority = 1000, -- make sure to load this before all the other start plugins
--     config = function()
--         require("nightfox").setup({
--             -- options = {
--             --     transparent = true, -- Disable setting background
--             -- },
--         })
--     end,
-- }
