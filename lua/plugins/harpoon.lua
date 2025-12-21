return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    event = "VeryLazy",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
        local harpoon = require("harpoon")
        local function mark_file()
            require("harpoon"):list():add()
            -- harpoon
            vim.notify("󱡅  marked file")
        end
        local keymap = function(keys, func, descr)
            vim.keymap.set("n", keys, func, { desc = descr, noremap = true, silent = true })
        end
        harpoon:setup()
        keymap("<leader>bm", mark_file, "[M]ark file with harpoon")
        -- keymap("<leader>bh", harpoon.toggle_quick_menu, "Open harpoon menu")
        vim.keymap.set("n", "<leader>bh", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)
        keymap("<leader>bk", function()
            harpoon:list():next()
        end, "Go to next harpoon mark")
        keymap("<leader>bj", function()
            harpoon:list():prev()
        end, "Go to previous harpoon mark")
        vim.api.nvim_create_autocmd({ "filetype" }, {
            pattern = "harpoon",
            callback = function()
                vim.cmd([[highlight link HarpoonBorder TelescopeBorder]])
                vim.cmd([[setlocal nonumber]])
                vim.cmd([[highlight HarpoonWindow guibg=#313132]])
            end,
        })
    end,
}

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
