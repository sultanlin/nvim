return {
    {
        "echasnovski/mini.move",
        event = "VeryLazy",
        opts = {},
    },
    {
        "echasnovski/mini.cursorword",
        event = "VeryLazy",
        opts = {},
    },
    {
        "echasnovski/mini.surround",
        -- event = "VeryLazy",
        -- lazy = true,
        --stylua: ignore
        keys = {
            { "gs", function() vim.notify("surround starting") end, desc = "Surround", },
            { "gsa", "sa", desc = "Add Surround", mode = { "n", "x" } },
            { "gsd", "sd", desc = "Delete Surround" },
            { "gsf", "sf", desc = "Find Surround" },
            { "gsF", "sF", desc = "Find Surround (left)" },
            { "gsh", "sh", desc = "Highlight Surround" },
            { "gsr", "sr", desc = "Replace Surround" },
            { "gsn", "sn", desc = "Update 'n_lines' Surround" },
        },
        opts = {
            mappings = {
                add = "gsa", -- Add surrounding in Normal and Visual modes
                delete = "gsd", -- Delete surrounding
                find = "gsf", -- Find surrounding (to the right)
                find_left = "gsF", -- Find surrounding (to the left)
                highlight = "gsh", -- Highlight surrounding
                replace = "gsr", -- Replace surrounding
                update_n_lines = "gsn", -- Update `n_lines`
                -- add = "sa", -- Add surrounding in Normal and Visual modes
                -- delete = "sd", -- Delete surrounding
                -- find = "sf", -- Find surrounding (to the right)
                -- find_left = "sF", -- Find surrounding (to the left)
                -- highlight = "sh", -- Highlight surrounding
                -- replace = "sr", -- Replace surrounding
                -- update_n_lines = "sn", -- Update `n_lines`
            },
        },
    },
    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        dependencies = {
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                event = "VeryLazy",
            },
            "echasnovski/mini.extra",
        },
        opts = function()
            local ai = require("mini.ai")
            return {
                -- similar to treesitter-text-objs
                -- NOTE: "b = "Balanced ), ], }"," and "q = "Quote `, \", '","
                -- For example, diq will delete inside nearest quotes
                -- ? is user prompt. For example, vi?
                n_lines = 500,
                custom_textobjects = {
                    -- o = ai.gen_spec.treesitter({
                    --     a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                    --     i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    -- }, {}),
                    s = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    f = require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                    c = require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                    F = require("mini.ai").gen_spec.function_call(),
                    i = require("mini.extra").gen_ai_spec.indent(),
                    B = require("mini.extra").gen_ai_spec.buffer(), -- t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
                    --         -- t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
                },
            }
        end,
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = "VeryLazy",
        opts = {
            enable_autocmd = false,
        },
    },
    -- {
    --     "echasnovski/mini.nvim",
    --     event = "VeryLazy",
    --     dependencies = {
    --         {
    --             "JoosepAlviste/nvim-ts-context-commentstring",
    --             event = "VeryLazy",
    --         },
    --     },
    --
    --     config = function()
    --         -- TODO: Consider mini.visits instead of harpoon or grapple
    --
    --         -- require("mini.notify").setup()
    --         -- require("mini.jump").setup()
    --         -- require("mini.surround").setup()
    --         -- require("mini.splitjoin").setup({})
    --         -- require("mini.pairs").setup({
    --         --     modes = { insert = true, command = true, terminal = false },
    --         --     -- skip autopair when next character is one of these
    --         --     skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
    --         --     -- skip autopair when the cursor is inside these treesitter nodes
    --         --     skip_ts = { "string" },
    --         --     -- skip autopair when next character is closing pair
    --         --     -- and there are more closing pairs than opening pairs
    --         --     skip_unbalanced = true,
    --         --     -- better deal with markdown code blocks
    --         --     markdown = true,
    --         -- })
    --     end,
    -- },
}
