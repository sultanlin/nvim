return {
    "rmehri01/onenord.nvim",
    cond = vim.g.colorscheme == "onenord",
    lazy = false,
    priority = 1000,
    config = function(_, opts)
        require("onenord").setup(opts)
        vim.cmd.colorscheme("onenord")
    end,
    opts = {
        disable = {
            background = true, -- Disable setting the background color
            float_background = true, -- Disable setting the background color for floating windows
        },
    },
}
-- {
--     "rmehri01/onenord.nvim",
--     lazy = true, -- make sure we load this during startup if it is your main colorscheme
--     config = function()
--         require("onenord").setup({
--             disable = {
--                 background = true, -- Disable setting the background color
--                 float_background = true, -- Disable setting the background color for floating windows
--             },
--         })
--     end,
-- }
