return {
    "loctvl842/monokai-pro.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
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
    end,
}
