return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            explorer = { enabled = false },
            image = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            notifier = {
                enabled = true,
                timeout = 3000,
            },
            picker = { enabled = true },
            -- profiler
            quickfile = { enabled = true },
            scope = { enabled = true },
            -- scroll = { enabled = false },
            statuscolumn = { enabled = false }, -- we set this in options.lua
            -- words = { enabled = false },
            words = { enabled = true },
            styles = {
                notification = {
                    wo = { wrap = true }, -- Wrap notifications
                },
            },
        },
        --stylua: ignore
            -- -- set keybinds
            -- opts.desc = "Show LSP references"
            -- keymap.set("n", "gr", "<cmd>FzfLua lsp_references<CR>", opts)
            --
            -- opts.desc = "Go to declaration"
            -- keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            --
            -- opts.desc = "Show LSP definitions"
            -- keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", opts)
            --
            -- opts.desc = "Show LSP implementations"
            -- keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", opts)
            --
            -- opts.desc = "Show LSP type definitions"
            -- keymap.set("n", "gt", "<cmd>FzfLua lsp_typedefs<CR>", opts)
            --
            -- opts.desc = "See available code actions"
            -- keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)
            --
            -- opts.desc = "Smart rename"
            -- keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
            --
            -- opts.desc = "Show buffer diagnostics"
            -- keymap.set("n", "<leader>ld", "<cmd>FzfLua diagnostics_document<CR>", opts)
        keys = {
            -- Top Pickers & Explorer
            { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
            { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers", },
            { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep", },
            { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
            { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
            { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
            -- find
            { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
            { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
            { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
            { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
            { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
            -- -- LSP
            -- { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
            -- { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
            -- { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
            -- { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
            -- { "<leader>lD", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
            -- { "<leader>ld", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
            -- -- { "<leader>ss", function() Snacks.picker.lsp_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Symbols", has = "documentSymbol" },
            -- -- { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Workspace Symbols", has = "workspace/symbols" },
            -- { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
            -- { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
            -- { "gai", function() Snacks.picker.lsp_incoming_calls() end, desc = "C[a]lls Incoming" },
            -- { "gao", function() Snacks.picker.lsp_outgoing_calls() end, desc = "C[a]lls Outgoing" },
            -- git
            { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
            -- TODO: Sort keymaps (conflicting)
            -- { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
            -- { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
            -- { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
            -- { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
            -- { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
            -- { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
            -- Grep
            { "<leader>fl", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
            { "<leader>fL", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
            { "<leader>ft", function() Snacks.picker.grep() end, desc = "Grep" },
            { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
            -- search
            { '<leader>f"', function() Snacks.picker.registers() end, desc = "Registers" },
            { "<leader>f/", function() Snacks.picker.search_history() end, desc = "Search History" },
            { "<leader>fa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },

            -- { "<leader>fb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
            -- { "<leader>fc", function() Snacks.picker.command_history() end, desc = "Command History" },
            -- { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },

            { "<leader>fh", function() Snacks.picker.help() end, desc = "Help Pages" },
            { "<leader>fH", function() Snacks.picker.highlights() end, desc = "Highlights" },
            { "<leader>fi", function() Snacks.picker.icons() end, desc = "Icons" },
            { "<leader>fj", function() Snacks.picker.jumps() end, desc = "Jumps" },
            { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    -- { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
            -- { "<leader>fm", function() Snacks.picker.marks() end, desc = "Marks" },

            { "<leader>fM", function() Snacks.picker.man() end, desc = "Man Pages" },
            { "<leader>fp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
            { "<leader>fq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
            { "<leader>fR", function() Snacks.picker.resume() end, desc = "Resume" },
            { "<leader>fu", function() Snacks.picker.undo() end, desc = "Undo History" },
            { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
            -- LSP
            { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
            { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
            { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
            { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
            { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
            { "<leader>ls", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
            { "<leader>lS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
            -- Other
            { "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode" },
            { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
            { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
            { "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
            { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History" },
            { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
            { "<leader>lR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
            { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
            { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
            { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
            { "<c-/>", function() Snacks.terminal() end, desc = "Toggle Terminal" },
            { "<c-_>", function() Snacks.terminal() end, desc = "which_key_ignore" },
            { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
            { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
            {
                "<leader>N",
                desc = "Neovim News",
                function()
                    Snacks.win({
                        file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                        width = 0.6,
                        height = 0.6,
                        wo = {
                            spell = false,
                            wrap = false,
                            signcolumn = "yes",
                            statuscolumn = " ",
                            conceallevel = 3,
                        },
                    })
                end,
            },
        },
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    -- Setup some globals for debugging (lazy-loaded)
                    _G.dd = function(...)
                        Snacks.debug.inspect(...)
                    end
                    _G.bt = function()
                        Snacks.debug.backtrace()
                    end
                    vim.print = _G.dd -- Override print to use snacks for `:=` command

                    -- Create some toggle mappings
                    Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                    Snacks.toggle.diagnostics():map("<leader>ud")
                    Snacks.toggle.line_number():map("<leader>ul")
                    Snacks.toggle
                        .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                        :map("<leader>uc")
                    Snacks.toggle.treesitter():map("<leader>uT")
                    Snacks.toggle
                        .option("background", { off = "light", on = "dark", name = "Dark Background" })
                        :map("<leader>ub")
                    Snacks.toggle.inlay_hints():map("<leader>uh")
                    Snacks.toggle.indent():map("<leader>ug")
                    Snacks.toggle.dim():map("<leader>uD")
                end,
            })

            -- TODO: check if this or ":lua Snacks.picker.lsp_references" later
            -- local keymap = vim.keymap
            -- vim.api.nvim_create_autocmd("LspAttach", {
            --     group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            --     callback = function(ev)
            --         -- Buffer local mappings.
            --         -- See `:help vim.lsp.*` for documentation on any of the below functions
            --         local opts = { buffer = ev.buf, silent = true }
            --
            --         -- set keybinds
            --         opts.desc = "Show LSP references"
            --         keymap.set("n", "gr", Snacks.picker.lsp_references, opts)
            --
            --         opts.desc = "Go to declaration"
            --         keymap.set("n", "gD", Snacks.picker.lsp_declarations, opts)
            --
            --         opts.desc = "Show LSP definitions"
            --         keymap.set("n", "gd", Snacks.picker.lsp_definitions, opts)
            --
            --         opts.desc = "Show LSP implementations"
            --         keymap.set("n", "gi", Snacks.picker.lsp_implementations, opts)
            --
            --         opts.desc = "Show LSP type definitions"
            --         keymap.set("n", "gt", Snacks.picker.lsp_type_definitions, opts)
            --
            --         opts.desc = "See available code actions"
            --         keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)
            --
            --         opts.desc = "Smart rename"
            --         keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
            --
            --         opts.desc = "Show diagnostics"
            --         keymap.set("n", "<leader>ld", Snacks.picker.diagnostics, opts)
            --
            --         opts.desc = "Show buffer diagnostics"
            --         keymap.set("n", "<leader>lD", Snacks.picker.diagnostics_buffer, opts)
            --
            --         opts.desc = "Show line diagnostics"
            --         keymap.set("n", "gl", vim.diagnostic.open_float, opts)
            --
            --         opts.desc = "Go to previous diagnostic"
            --         keymap.set("n", "<leader>lk", function()
            --             vim.diagnostic.jump({ count = -1, float = true })
            --         end, opts)
            --
            --         opts.desc = "Go to next diagnostic"
            --         keymap.set("n", "<leader>lj", function()
            --             vim.diagnostic.jump({ count = 1, float = true })
            --         end, opts)
            --
            --         opts.desc = "Show documentation for what is under cursor"
            --         keymap.set("n", "K", vim.lsp.buf.hover, opts)
            --
            --         -- "Signature Documentation"
            --         opts.desc = "Show documentation for what is under cursor"
            --         keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
            --
            --         opts.desc = "LSP Symbols"
            --         keymap.set("n", "<leader>ss", Snacks.picker.lsp_symbols, opts)
            --
            --         opts.desc = "LSP Workspace Symbols"
            --         keymap.set("n", "<leader>sS", Snacks.picker.lsp_workspace_symbols, opts)
            --
            --         opts.desc = "LSP Workspace Symbols"
            --         keymap.set("n", "<leader>sS", Snacks.picker.lsp_workspace_symbols, opts)
            --
            --         opts.desc = "C[a]lls Incoming"
            --         keymap.set("n", "gai", Snacks.picker.lsp_incoming_calls, opts)
            --
            --         opts.desc = "C[a]lls Outgoing"
            --         keymap.set("n", "gao", Snacks.picker.lsp_outgoing_calls, opts)
            --     end,
            -- })
        end,
    },
    -- {
    --     "neovim/nvim-lspconfig",
    --     opts = {
    --         servers = {
    --             ["*"] = {
    --                 -- stylua: ignore
    --                 keys = {
    --                     { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition", has = "definition" },
    --                     { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    --                     { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    --                     { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    --                     { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols", has = "documentSymbol" },
    --                     { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols", has = "workspace/symbols" },
    --                     { "gai", function() Snacks.picker.lsp_incoming_calls() end, desc = "C[a]lls Incoming", has = "callHierarchy/incomingCalls" },
    --                     { "gao", function() Snacks.picker.lsp_outgoing_calls() end, desc = "C[a]lls Outgoing", has = "callHierarchy/outgoingCalls" },
    --                 },
    --             },
    --         },
    --     },
    -- },
}
