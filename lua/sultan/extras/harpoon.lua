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

-- "ThePrimeagen/harpoon",
-- branch = "harpoon2",
-- opts = {
--   menu = {
--     width = vim.api.nvim_win_get_width(0) - 4,
--   },
-- },
-- keys = {
--   {
--     "<leader>H",
--     function()
--       require("harpoon"):list():append()
--     end,
--     desc = "Harpoon file",
--   },
--   {
--     "<leader>h",
--     function()
--       local harpoon = require("harpoon")
--       harpoon.ui:toggle_quick_menu(harpoon:list())
--     end,
--     desc = "Harpoon quick menu",
--   },
--   {
--     "<leader>1",
--     function()
--       require("harpoon"):list():select(1)
--     end,
--     desc = "Harpoon to file 1",
--   },
--   {
--     "<leader>2",
--     function()
--       require("harpoon"):list():select(2)
--     end,
--     desc = "Harpoon to file 2",
--   },
--   {
--     "<leader>3",
--     function()
--       require("harpoon"):list():select(3)
--     end,
--     desc = "Harpoon to file 3",
--   },
--   {
--     "<leader>4",
--     function()
--       require("harpoon"):list():select(4)
--     end,
--     desc = "Harpoon to file 4",
--   },
--   {
--     "<leader>5",
--     function()
--       require("harpoon"):list():select(5)
--     end,
--     desc = "Harpoon to file 5",
--   },
-- },
