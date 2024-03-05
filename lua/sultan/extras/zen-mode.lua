local M = {
    "folke/zen-mode.nvim",
    dependencies = {
        {
            "folke/twilight.nvim",
            event = { "BufReadPost", "BufNewFile" },
            cmd = { "Twilight", "TwilightEnable" },
        },
        event = { "BufReadPost", "BufNewFile" },
        cmd = "ZenMode",
    },
}

M.config = function()
    local wk = require("which-key")
    wk.register({
        ["<leader>zt"] = {
            function()
                require("twilight").toggle()
            end,
            "Toggle Twilight",
        },
        ["<leader>zw"] = {
            function()
                if require("zen-mode.view").is_open() then
                    require("zen-mode").toggle()
                    return
                end

                local width = vim.fn.input({ prompt = "Zen mode width: ", default = "100", cancelreturn = "100" })

                require("zen-mode").toggle({
                    window = {
                        width = tonumber(width),
                    },
                })

                vim.g.zen_mode_width = width
            end,
            "Toggle Zen Mode With Custom Width",
        },
        ["<leader>zz"] = {
            function()
                if require("zen-mode.view").is_open() then
                    require("zen-mode").toggle()
                    return
                end

                if vim.g.zen_mode_width then
                    require("zen-mode").toggle({
                        window = {
                            width = tonumber(vim.g.zen_mode_width),
                        },
                    })
                    return
                end

                require("zen-mode").toggle()
            end,
            "Toggle Zen Mode",
        },
    })
    require("twilight").setup({
        dimming = {
            inactive = true,
        },
    })
    require("zen-mode").setup({
        window = {
            width = 80,
            options = {
                -- signcolumn = "no", -- disable signcolumn
                number = false, -- disable number column
                relativenumber = false, -- disable relative numbers
                cursorline = false, -- disable cursorline
                cursorcolumn = false, -- disable cursor column
                foldcolumn = "0", -- disable fold column
                list = false, -- disable whitespace characters
            },
        },
        plugins = {
            options = {
                enabled = true,
                ruler = true,
                showcmd = true,
            },
            twilight = {
                enabled = false,
            },
            gitsigns = {
                enabled = true,
            },
            kitty = {
                enabled = false, -- messes up with other windows
                font = "+1",
            },
            alacritty = {
                enabled = false, -- I suspect the same as kitty
                font = "+1",
            },
        },
        on_open = function(_)
            vim.opt.laststatus = 0
            vim.o.winbar = ""
        end,
        on_close = function()
            vim.opt.laststatus = 3
        end,
    })
end

return M
