local M = {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
}

function M.config()
    require("mini.indentscope").setup({
        -- symbol = "▏",
        symbol = "│",
        options = { try_as_border = true },
    })
    require("mini.notify").setup()
    require("mini.jump").setup()
    require("mini.move").setup()
    require("mini.surround").setup()
    require("mini.splitjoin").setup({})

    local mappings = {
        m = {
            name = "Mini",
            f = { "<cmd>:lua MiniFiles.open()<cr>", "Mini Files", { noremap = true, silent = true } },
            j = { "<cmd>:lua MiniSplitjoin.toggle()<cr>", "Mini SplitJoin", { noremap = true, silent = true } },
            -- p = { function() vim.g.minipairs_disable = not vim.g.minipairs_disable end, "Mini pairs", { noremap = true, silent = true } },
        },
    }

    local opts = {
        mode = "n", -- NORMAL mode
        prefix = "<leader>",
    }

    local wk = require("which-key")
    wk.register(mappings, opts)

    M.minifiles()
    M.ai()
end

function M.ai()
    -- TODO: Check it out later
    require("mini.ai").setup({
        n_lines = 500,
        custom_textobjects = {
            o = require("mini.ai").gen_spec.treesitter({
                a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                i = { "@block.inner", "@conditional.inner", "@loop.inner" },
            }, {}),
            f = require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
            c = require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
            -- t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        },
    }) -- similar to treesitter-text-objs
    -- NOTE: "b = "Balanced ), ], }"," and "q = "Quote `, \", '","
    -- For example, diq will delete inside nearest quotes
    -- ? is user prompt. For example, vi?
end

function M.minifiles()
    require("mini.files").setup({
        mappings = { synchronize = "w" },
        -- General options
        -- options = {
        --     -- Whether to delete permanently or move into module-specific trash
        --     permanent_delete = true,
        --     -- Whether to use for editing directories
        --     use_as_default_explorer = false,
        -- },
        -- Customization of explorer windows
        -- windows = {
        --     -- Maximum number of windows to show side by side
        --     max_number = math.huge,
        --     -- Whether to show preview of file/directory under cursor
        --     preview = true,
        --     -- Width of focused window
        --     width_focus = 50,
        --     -- Width of non-focused window
        --     width_nofocus = 15,
        --     -- Width of preview window
        --     width_preview = 50,
        -- },
    })

    local show_dotfiles = true

    local filter_show = function(fs_entry)
        return true
    end

    local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, ".")
    end

    local gio_open = function()
        local fs_entry = require("mini.files").get_fs_entry()
        vim.notify(vim.inspect(fs_entry))
        vim.fn.system(string.format("gio open '%s'", fs_entry.path))
    end

    local go_in_plus = function()
        require("mini.files").go_in({ close_on_file = true })
    end

    local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        require("mini.files").refresh({ content = { filter = new_filter } })
    end

    vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
            local buf_id = args.data.buf_id
            -- Tweak left-hand side of mapping to your liking
            vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
            vim.keymap.set("n", "-", require("mini.files").close, { buffer = buf_id })
            vim.keymap.set("n", "o", gio_open, { buffer = buf_id })
            vim.keymap.set("n", "<CR>", go_in_plus, { buffer = buf_id })
        end,
    })

    vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesWindowOpen",
        callback = function(args)
            local win_id = args.data.win_id
            vim.api.nvim_win_set_config(win_id, { border = "rounded" })
        end,
    })
end

return M
