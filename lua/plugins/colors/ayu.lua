return {
    "Shatur/neovim-ayu",
    name = "ayu",
    cond = vim.g.colorscheme == "ayu",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd.colorscheme("ayu")
    end,
}
