local M = {
    "nacro90/numb.nvim",
    event = "VeryLazy",
}

function M.config()
    require("numb").setup()
end

return M
