local M = {
    "nvim-pack/nvim-spectre",
}

function M.config()
    require("spectre").setup({
        result_padding = "",
        default = {
            replace = {
                cmd = "sed",
            },
        },
    })

    local wk = require("which-key")
    wk.register({
        ["<leader>st"] = { "<cmd>lua require('spectre').toggle()<CR>", "Toggle Spectre", mode = { "n" } },
        ---@diagnostic disable-next-line: duplicate-index
        ["<leader>sc"] = {
            "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
            "Search current word",
            mode = { "n" },
        },
        ---@diagnostic disable-next-line: duplicate-index
        ["<leader>sc"] = {
            "<esc><cmd>lua require('spectre').open_visual()<CR>",
            "Search current highlight",
            mode = { "v" },
        },
        ["<leader>sf"] = {
            "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>",
            "Search on current file",
            mode = { "n" },
        },
    })
end

return M
