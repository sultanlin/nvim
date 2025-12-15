local M = {
    -- name = "ibl"
    -- "lukas-reineke/indent-blankline.nvim",
    -- event = "VeryLazy",
}

function M.config()
    local icons = require("sultan.core.icons")

    require("ibl").setup({
        indent = { char = icons.ui.LineMiddle },
        whitespace = {
            remove_blankline_trail = true,
        },
        exclude = {
            buftypes = { "terminal", "nofile" },
            filetypes = {
                "help",
                "startify",
                "dashboard",
                "lazy",
                "neogitstatus",
                "NvimTree",
                "Trouble",
                "text",
            },
        },

        -- scope = { enabled = false },

        -- char = icons.ui.LineLeft,
        -- char = icons.ui.LineMiddle,
        -- context_char = icons.ui.LineLeft,
        -- context_char = icons.ui.LineMiddle,
    })
end
return M
