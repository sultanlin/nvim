local M = {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
    },
}

M.config = function()
    local keymap = function(keys, func, descr)
        vim.keymap.set("n", keys, func, { desc = descr, noremap = true, silent = true })
    end
    keymap("<leader>bm", "<cmd>lua require('sultan.harpoon').mark_file()<cr>", "[M]ark file with harpoon")
    keymap("<leader>bh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Open harpoon menu")
    keymap("<leader>bk", "<cmd>lua require('harpoon.ui').nav_next()<cr>", "Go to next harpoon mark")
    keymap("<leader>bj", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", "Go to previous harpoon mark")
    vim.api.nvim_create_autocmd({ "filetype" }, {
        pattern = "harpoon",
        callback = function()
            vim.cmd([[highlight link HarpoonBorder TelescopeBorder]])
            -- vim.cmd [[setlocal nonumber]]
            -- vim.cmd [[highlight HarpoonWindow guibg=#313132]]
        end,
    })
end

function M.mark_file()
    require("harpoon.mark").add_file()
    vim.notify("󱡅  marked file")
end

return M
