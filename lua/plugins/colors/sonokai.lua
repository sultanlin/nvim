return {
    "sainnhe/sonokai",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        require("rose-pine").setup({
            -- variant = "auto", -- auto, main, moon, or dawn
            styles = {
                -- transparency = true,
                italic = false,
            },
        })
    end,
}
