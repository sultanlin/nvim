local M = {
    "lewis6991/gitsigns.nvim",
    event = "BufEnter",
    cmd = "Gitsigns",
}

M.config = function()
    local icons = require("sultan.core.icons")
    local keymap = function(keys, func, descr)
        vim.keymap.set("n", keys, func, { desc = descr, noremap = true, silent = true })
    end
    keymap("<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk")
    keymap("<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk")
    keymap("<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "[p]review Hunk")
    keymap("<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "[r]eset Hunk")
    keymap("<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", "B[l]bame")
    keymap("<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "[R]eset Buffer")
    keymap("<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "[s]tage Hunk")
    keymap("<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "[u]ndo Stage Hunk")
    keymap("<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", "Git [d]iff")

    require("gitsigns").setup({
        signs = {
            add = {
                text = icons.ui.BoldLineMiddle,
            },
            change = {
                text = icons.ui.BoldLineDashedMiddle,
                -- hl = "GitSignsChange",
                -- numhl = "GitSignsChangeNr",
                -- linehl = "GitSignsChangeLn",
            },
            delete = {
                text = icons.ui.TriangleShortArrowRight,
                -- hl = "GitSignsDelete",
                -- numhl = "GitSignsDeleteNr",
                -- linehl = "GitSignsDeleteLn",
            },
            topdelete = {
                text = icons.ui.TriangleShortArrowRight,
                -- hl = "GitSignsDelete",
                -- numhl = "GitSignsDeleteNr",
                -- linehl = "GitSignsDeleteLn",
            },
            changedelete = {
                text = icons.ui.BoldLineMiddle,
                -- hl = "GitSignsChange",
                -- numhl = "GitSignsChangeNr",
                -- linehl = "GitSignsChangeLn",
            },
        },
        watch_gitdir = {
            interval = 1000,
            follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        update_debounce = 200,
        max_file_length = 40000,
        preview_config = {
            border = "rounded",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
        },
        -- on_attach = function(bufnr)
        --     vim.keymap.set(
        --         "n",
        --         "<leader>hp",
        --         require("gitsigns").preview_hunk,
        --         { buffer = bufnr, desc = "Preview git hunk" }
        --     )
        --
        --     don't override the built-in and fugitive keymaps
        --     local gs = package.loaded.gitsigns
        --     vim.keymap.set({ "n", "v" }, "]c", function()
        --         if vim.wo.diff then
        --             return "]c"
        --         end
        --         vim.schedule(function()
        --             gs.next_hunk()
        --         end)
        --         return "<Ignore>"
        --     end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
        --     vim.keymap.set({ "n", "v" }, "[c", function()
        --         if vim.wo.diff then
        --             return "[c"
        --         end
        --         vim.schedule(function()
        --             gs.prev_hunk()
        --         end)
        --         return "<Ignore>"
        --     end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
        -- end,
    })
end

return M
