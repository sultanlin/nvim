return {
    "ribru17/bamboo.nvim",
    cond = vim.g.colorscheme == "bamboo",
    lazy = false,
    priority = 1000,
    config = function()
        require("bamboo").setup({
            -- optional configuration here
        })
        require("bamboo").load()
        vim.cmd.colorscheme("bamboo")
    end,
}
