local icons = require("icons")
return {
    {
        --      vim-rhubarb # "If fugitive is the git, rhubarb is the hub"
        "tpope/vim-fugitive", -- Let's you do git commands using :G instead of :!g in vim cmd
        event = "VeryLazy",
    },
    {
        -- Compare with mini.diff
        "lewis6991/gitsigns.nvim", -- Shows changes to git in the left margin
        -- event = { "BufReadPost", "BufWritePost", "BufNewFile" }
        -- event = "BufEnter",
        event = "VeryLazy",
        cmd = "Gitsigns",

        opts = {
            --       add = { text = "▎" },
            --       change = { text = "▎" },
            --       delete = { text = "" },
            --       topdelete = { text = "" },
            --       changedelete = { text = "▎" },
            --       untracked = { text = "▎" },
            signs = {
                add = { text = "┃" },
                change = { text = "┋" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "┃" },
                untracked = { text = "▎" },
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
            numhl = true,
            sign_priority = 15, -- higher than diagnostic,todo signs. lower than dapui breakpoint sign
            --     signs_staged = {
            --       add = { text = "▎" },
            --       change = { text = "▎" },
            --       delete = { text = "" },
            --       topdelete = { text = "" },
            --       changedelete = { text = "▎" },
            --     },
            on_attach = function(buffer)
                local keymap = function(mode, keys, func, descr)
                    vim.keymap.set(mode, keys, func, { desc = descr, noremap = true, silent = true, buffer = buffer })
                end
                local gs = package.loaded.gitsigns

                keymap("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
                keymap("n", "<leader>gP", gs.preview_hunk_inline, "Preview Hunk Inline")
                keymap({ "n", "x" }, "<leader>gs", gs.stage_hunk, "Stage Hunk")
                keymap({ "n", "x" }, "<leader>gr", gs.reset_hunk, "Reset Hunk")
                -- keymap("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
                keymap("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
                keymap("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
                -- keymap("n", "<leader>gd", gs.diffthis, "Git diff")
                -- keymap("n", "<leader>gD", function()
                --     gs.diffthis("~")
                -- end, "Git diff ~")

                -- keymap("n", "<leader>gl", function()
                --     gs.blame_line({ full = true })
                -- end, "Blame Line")
                keymap("n", "<leader>gl", gs.blame, "Blame Buffer")
                keymap({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")

                keymap("n", "<leader>gj", function()
                    gs.next_hunk({ navigation_message = false })
                end, "Next Hunk")
                keymap("n", "<leader>gk", function()
                    gs.prev_hunk({ navigation_message = false })
                end, "Prev Hunk")
                keymap("n", "<leader>gJ", function()
                    gs.nav_hunk("last")
                end, "Last Hunk")
                keymap("n", "<leader>gK", function()
                    gs.nav_hunk("first")
                end, "First Hunk")
            end,
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

            -- LazyVim
            --       map({"n", "v"}, "]h", function()
            --         if vim.wo.diff then
            --           vim.cmd.normal({ "]c", bang = true })
            --         else
            --           gs.nav_hunk("next")
            --         end
            --       end, "Next Hunk")
            --       map({"n", "v"}, "[h", function()
            --         if vim.wo.diff then
            --           vim.cmd.normal({ "[c", bang = true })
            --         else
            --           gs.nav_hunk("prev")
            --         end
            --       end, "Prev Hunk")
            --       map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
            --       map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
        },
    },
    {
        -- Diffs for git revisions.
        "sindrets/diffview.nvim",
        keys = {
            { "<leader>gf", "<cmd>DiffviewFileHistory<cr>", desc = "File history" },
            { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff view" },
        },
        opts = function()
            local actions = require("diffview.actions")

            require("diffview.ui.panel").Panel.default_config_float.border = "rounded"

            return {
                default_args = { DiffviewFileHistory = { "%" } },
                icons = {
                    folder_closed = icons.symbol_kinds.Folder,
                    folder_open = "󰝰",
                },
                signs = {
                    fold_closed = icons.arrows.right,
                    fold_open = icons.arrows.down,
                    done = "",
                },
                -- stylua: ignore start
                keymaps = {
                    { mode = "n", keys = "<leader>G", desc = "+diffview" },
                    -- Easier to just configure what I need.
                    disable_defaults = true,
                    view = {
                        { 'n', '<tab>',      actions.select_next_entry,             { desc = 'Open the diff for the next file' } },
                        { 'n', '<s-tab>',    actions.select_prev_entry,             { desc = 'Open the diff for the previous file' } },
                        { 'n', '[x',         actions.prev_conflict,                 { desc = 'Merge-tool: jump to the previous conflict' } },
                        { 'n', ']x',         actions.next_conflict,                 { desc = 'Merge-tool: jump to the next conflict' } },
                        { 'n', 'gf',         actions.goto_file_tab,                 { desc = 'Open the file in a new tabpage' } },
                        { 'n', '<leader>Go', actions.conflict_choose('ours'),       { desc = 'Choose the OURS version of a conflict' } },
                        { 'n', '<leader>Gt', actions.conflict_choose('theirs'),     { desc = 'Choose the THEIRS version of a conflict' } },
                        { 'n', '<leader>Gb', actions.conflict_choose('base'),       { desc = 'Choose the BASE version of a conflict' } },
                        { 'n', '<leader>Ga', actions.conflict_choose('all'),        { desc = 'Choose all the versions of a conflict' } },
                        { 'n', '<leader>Gd', actions.conflict_choose('none'),       { desc = 'Delete the conflict region' } },
                        { 'n', '<leader>GO', actions.conflict_choose_all('ours'),   { desc = 'Choose the OURS version of a conflict for the whole file' } },
                        { 'n', '<leader>GT', actions.conflict_choose_all('theirs'), { desc = 'Choose the THEIRS version of a conflict for the whole file' } },
                        { 'n', '<leader>GB', actions.conflict_choose_all('base'),   { desc = 'Choose the BASE version of a conflict for the whole file' } },
                        unpack(actions.compat.fold_cmds),
                    },
                    diff2 = {
                        { 'n', '?', actions.help { 'view', 'diff2' }, { desc = 'Open the help panel' } },
                    },
                    diff3 = {
                        { 'n', '?', actions.help { 'view', 'diff3' }, { desc = 'Open the help panel' } },
                    },
                    file_panel = {
                        { 'n', 'j',          actions.next_entry,                    { desc = 'Bring the cursor to the next file entry' } },
                        { 'n', 'k',          actions.prev_entry,                    { desc = 'Bring the cursor to the previous file entry' } },
                        { 'n', '<cr>',       actions.select_entry,                  { desc = 'Open the diff for the selected entry' } },
                        { 'n', 's',          actions.toggle_stage_entry,            { desc = 'Stage / unstage the selected entry' } },
                        { 'n', 'S',          actions.stage_all,                     { desc = 'Stage all entries' } },
                        { 'n', 'U',          actions.unstage_all,                   { desc = 'Unstage all entries' } },
                        { 'n', 'X',          actions.restore_entry,                 { desc = 'Restore entry to the state on the left side' } },
                        { 'n', 'L',          actions.open_commit_log,               { desc = 'Open the commit log panel' } },
                        { 'n', 'gf',         actions.goto_file_tab,                 { desc = 'Open the file in a new tabpage' } },
                        { 'n', 'za',         actions.toggle_fold,                   { desc = 'Toggle fold' } },
                        { 'n', 'zR',         actions.open_all_folds,                { desc = 'Expand all folds' } },
                        { 'n', 'zM',         actions.close_all_folds,               { desc = 'Collapse all folds' } },
                        { 'n', '<c-b>',      actions.scroll_view(-0.25),            { desc = 'Scroll the view up' } },
                        { 'n', '<c-f>',      actions.scroll_view(0.25),             { desc = 'Scroll the view down' } },
                        { 'n', '<tab>',      actions.select_next_entry,             { desc = 'Open the diff for the next file' } },
                        { 'n', '<s-tab>',    actions.select_prev_entry,             { desc = 'Open the diff for the previous file' } },
                        { 'n', 'i',          actions.listing_style,                 { desc = 'Toggle between "list" and "tree" views' } },
                        { 'n', '[x',         actions.prev_conflict,                 { desc = 'Go to the previous conflict' } },
                        { 'n', ']x',         actions.next_conflict,                 { desc = 'Go to the next conflict' } },
                        { 'n', '?',          actions.help('file_panel'),            { desc = 'Open the help panel' } },
                        { 'n', '<leader>GO', actions.conflict_choose_all('ours'),   { desc = 'Choose the OURS version of a conflict for the whole file' } },
                        { 'n', '<leader>GT', actions.conflict_choose_all('theirs'), { desc = 'Choose the THEIRS version of a conflict for the whole file' } },
                        { 'n', '<leader>GB', actions.conflict_choose_all('base'),   { desc = 'Choose the BASE version of a conflict for the whole file' } },
                        { 'n', '<leader>GA', actions.conflict_choose_all('all'),    { desc = 'Choose all the versions of a conflict for the whole file' } },
                        { 'n', '<leader>GD', actions.conflict_choose_all('none'),   { desc = 'Delete the conflict region for the whole file' } },
                    },
                    file_history_panel = {
                        { 'n', '!',         actions.options,                    { desc = 'Open the option panel' } },
                        { 'n', '<leader>d', actions.open_in_diffview,           { desc = 'Open the entry under the cursor in a diffview' } },
                        { 'n', 'y',         actions.copy_hash,                  { desc = 'Copy the commit hash of the entry under the cursor' } },
                        { 'n', 'L',         actions.open_commit_log,            { desc = 'Show commit details' } },
                        { 'n', 'X',         actions.restore_entry,              { desc = 'Restore file to the state from the selected entry' } },
                        { 'n', 'za',        actions.toggle_fold,                { desc = 'Toggle fold' } },
                        { 'n', 'zR',        actions.open_all_folds,             { desc = 'Expand all folds' } },
                        { 'n', 'zM',        actions.close_all_folds,            { desc = 'Collapse all folds' } },
                        { 'n', 'j',         actions.next_entry,                 { desc = 'Bring the cursor to the next file entry' } },
                        { 'n', 'k',         actions.prev_entry,                 { desc = 'Bring the cursor to the previous file entry' } },
                        { 'n', '<cr>',      actions.select_entry,               { desc = 'Open the diff for the selected entry' } },
                        { 'n', '<c-b>',     actions.scroll_view(-0.25),         { desc = 'Scroll the view up' } },
                        { 'n', '<c-f>',     actions.scroll_view(0.25),          { desc = 'Scroll the view down' } },
                        { 'n', '<tab>',     actions.select_next_entry,          { desc = 'Open the diff for the next file' } },
                        { 'n', '<s-tab>',   actions.select_prev_entry,          { desc = 'Open the diff for the previous file' } },
                        { 'n', 'gf',        actions.goto_file_tab,              { desc = 'Open the file in a new tabpage' } },
                        { 'n', '?',         actions.help('file_history_panel'), { desc = 'Open the help panel' } },
                    },
                    option_panel = {
                        { 'n', '<tab>', actions.select_entry,         { desc = 'Change the current option' } },
                        { 'n', 'q',     actions.close,                { desc = 'Close the panel' } },
                        { 'n', '?',     actions.help('option_panel'), { desc = 'Open the help panel' } },
                    },
                    help_panel = {
                        { 'n', 'q', actions.close, { desc = 'Close help menu' } },
                    },
                },
                -- stylua: ignore end
            }
        end,
    },
    -- {
    --     "kdheepak/lazygit.nvim",
    --     dependencies = { "nvim-lua/plenary.nvim" },
    --     event = "BufReadPre",
    --
    --     config = function()
    --         local bufmap = function(keys, func, descr)
    --             vim.keymap.set("n", keys, func, { buffer = bufnr, desc = descr, noremap = true, silent = true })
    --         end
    --
    --         -- bufmap("gg", "<Cmd>lua Config.open_lazygit()<CR>", "Git tab")
    --         bufmap("<leader>gg", "<Cmd>LazyGit<CR>", "Git tab")
    --         -- require("lazygit").setup({
    --         -- })
    --     end,
    -- },
    -- {
    --     "linrongbin16/gitlinker.nvim",
    --     dependencies = { { "nvim-lua/plenary.nvim" } },
    --     event = "VeryLazy",
    --     -- GitLink: generate git link and copy to clipboard.
    --     -- GitLink!: generate git link and open in browser.
    --     -- GitLink blame: generate the /blame url and copy to clipboard.
    --     -- GitLink! blame: generate the /blame url and open in browser.
    --     keys = {
    --         { "<leader>gY", "<cmd>GitLink blame<cr>", desc = "Git link blame" },
    --         { "<leader>gy", "<cmd>GitLink!<cr>", desc = "Git link" },
    --     },
    --     config = function()
    --         require("gitlinker").setup({
    --             -- print message in command line
    --             message = true,
    --
    --             -- key mapping
    --             -- mapping = {
    --             --   ["<leader>gY"] = {
    --             --     -- copy git link to clipboard
    --             --     action = require("gitlinker.actions").clipboard,
    --             --     desc = "Copy git link to clipboard",
    --             --   },
    --             --   ["<leader>gy"] = {
    --             --     -- open git link in browser
    --             --     action = require("gitlinker.actions").system,
    --             --     desc = "Open git link in browser",
    --             --   },
    --             -- },
    --
    --             -- write logs to console(command line)
    --             console_log = true,
    --         })
    --     end,
    -- },
    -- neogit: Off for now
    -- {
    --
    --     "neogitorg/neogit",
    --     event = "VeryLazy",
    --
    --     config = function()
    --         local icons = require("sultan.core.icons")
    --         local wk = require("which-key")
    --         wk.register({
    --             ["<leader>gg"] = { "<cmd>Neogit<CR>", "Neogit" },
    --         })
    --
    --         require("neogit").setup({
    --             disable_signs = false,
    --             -- disable_hint = true,
    --             disable_context_highlighting = false,
    --             disable_commit_confirmation = true,
    --             disable_insert_on_commit = "auto",
    --             -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
    --             -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
    --             auto_refresh = true,
    --             disable_builtin_notifications = false,
    --             use_magit_keybindings = false,
    --             -- Change the default way of opening neogit
    --             kind = "tab",
    --             -- Change the default way of opening the commit popup
    --             commit_popup = {
    --                 kind = "split",
    --             },
    --             -- Change the default way of opening popups
    --             popup = {
    --                 kind = "split",
    --             },
    --             -- customize displayed signs
    --             signs = {
    --                 -- { CLOSED, OPENED }
    --                 section = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
    --                 item = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
    --                 hunk = { "", "" },
    --             },
    --             integrations = {
    --                 diffview = true,
    --             },
    --         })
    --     end,
    -- },
}
