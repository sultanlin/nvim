return {
    {
        "cbochs/grapple.nvim",
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
        },
        opts = {
            scope = "git_branch",
            icons = true,
            quick_select = "123456789",
            -- opts = {
            --   menu = {
            --     width = vim.api.nvim_win_get_width(0) - 4,
            --   },
            -- },
        },
        keys = {
            {
                "<leader>m",
                function()
                    local grapple = require("grapple")
                    grapple.toggle()
                    if grapple.exists() then
                        vim.notify("Tagged file 󱡅 ")
                    else
                        vim.notify("Untagged file 󱡅 ")
                    end
                end,
                desc = "Tag buffer (Grapple)",
            },
            { "<c-b>", "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple next tag" },
            { "<leader>bb", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple menu" },
            { "<leader>bk", "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple next tag" },
            { "<leader>bj", "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple previous tag" },
            { "<leader>1", "<cmd>Grapple select index=1<cr>", desc = "which_key_ignore" },
            { "<leader>2", "<cmd>Grapple select index=2<cr>", desc = "which_key_ignore" },
            { "<leader>3", "<cmd>Grapple select index=3<cr>", desc = "which_key_ignore" },
            { "<leader>4", "<cmd>Grapple select index=4<cr>", desc = "which_key_ignore" },
            { "<leader>5", "<cmd>Grapple select index=5<cr>", desc = "which_key_ignore" },

            -- { ";", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },
            -- { "<c-s>", "<cmd>Grapple toggle<cr>", desc = "Toggle tag" },
            -- { "H", "<cmd>Grapple cycle_tags next<cr>", desc = "Go to next tag" },
            -- { "L", "<cmd>Grapple cycle_tags prev<cr>", desc = "Go to previous tag" },
            --         vim.api.nvim_create_autocmd({ "filetype" }, {
            --             pattern = "harpoon",
            --             callback = function()
            --                 vim.cmd([[highlight link HarpoonBorder TelescopeBorder]])
            --                 vim.cmd([[setlocal nonumber]])
            --                 vim.cmd([[highlight HarpoonWindow guibg=#313132]])
            --             end,
            --         })
        },
        config = function() end,
    },
}
