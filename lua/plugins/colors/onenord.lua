return {
    "rmehri01/onenord.nvim",
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
    config = function()
        require("onenord").setup({
            disable = {
                background = true, -- Disable setting the background color
                float_background = true, -- Disable setting the background color for floating windows
            },
        })
    end,
}
