return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function()
        local mappings = {
            { "<leader>-", "<cmd>nohlsearch<CR>", desc = "NOHL" },
            { "<leader>;", "<cmd>tabnew | terminal<CR>", desc = "[T]erminal" },
            -- { "<leader>a", group = "Tab" },
            { "<leader><tab>", group = "Tab" },
            -- { "<leader>aN", "<cmd>$tabnew<cr>", desc = "New Empty Tab" },
            -- { "<leader>aa", "<cmd>tabnext<cr>", desc = "Goto next tab" },
            -- { "<leader>ah", "<cmd>-tabmove<cr>", desc = "Move Left" },
            -- { "<leader>al", "<cmd>+tabmove<cr>", desc = "Move Right" },
            -- { "<leader>an", "<cmd>tabnew %<cr>", desc = "New Tab" },
            -- { "<leader>ao", "<cmd>tabonly<cr>", desc = "Only" },
            { "<leader>b", desc = "Buffers" },
            { "<leader>d", desc = "Debug" },
            { "<leader>f", desc = "Find" },
            { "<leader>g", desc = "Git" },
            { "<leader>h", "<cmd>split<CR>", desc = "Horizontal Split" },
            { "<leader>l", desc = "LSP" },
            { "<leader>q", "<cmd>confirm q<CR>", desc = "Quit" },
            { "<leader>s", desc = "Spectre search" },
            { "<leader>t", desc = "Test" },
            { "<leader>v", "<cmd>vsplit<CR>", desc = "Split" },
            { "<leader>x", "<cmd>x<CR>", desc = "Write and Quit" },
            { "z", group = "Fold" },
        }

        local wk = require("which-key")

        local opts = {
            mode = "n", -- NORMAL mode
            prefix = "<leader>",
        }

        -- vim.keymap.set(
        --     "n",
        --     "<leader>s",
        --     ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
        --     { desc = "Search and replace" }
        -- )
        -- vim.keymap.set(
        --     "n",
        --     "<leader>s",
        --     ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
        --     { desc = "Search and replace" }
        -- )

        wk.add(mappings, opts)

        wk.add({
            -- ["<leader>p"] = { '"_dp', "Replace and keep current yank", mode = "v" },
            -- ["<leader>P"] = { '"_dP', "Replace and keep current yank", mode = "v" },
            { "<leader>p", '"0p', desc = "Replace and keep current yank", mode = "v" },
            { "<leader>P", '"0P', desc = "Replace and keep current yank", mode = "v" },
            { "<leader>y", '"+y', desc = "Yank ??" },
            -- ["<leader>s"] = { ":%s/\\\\<<C-r><C-w>\\\\>/<C-r><C-w>/gI<Left><Left><Left>", "Search and replace", mode = "n" },
            -- ["<leader>ee"] = { "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", "Go error snippet", mode = "n" },
            -- ["<leader>x"] = { "<cmd>!chmod +x %<CR>", "Make file executable", mode = "n" },
        })

        wk.setup({
            preset = "helix",
            plugins = {
                marks = true,
                registers = true,
                spelling = {
                    enabled = true,
                    suggestions = 20,
                },
                presets = {
                    operators = false,
                    motions = false,
                    text_objects = false,
                    windows = false,
                    nav = false,
                    z = false,
                    g = false,
                },
            },
            win = {
                border = "rounded",
                no_overlap = false,
                padding = { 0, 2 }, -- extra window padding [top/bottom, right/left]
                title = false,
                title_pos = "center",
                zindex = 1000,
            },
            show_help = false,
            show_keys = false,
            disable = {
                buftypes = {},
            },

            --            plugins = {
            --                marks = true,
            --                registers = true,
            --                spelling = {
            --                    enabled = true,
            --                    suggestions = 20,
            --                },
            --                presets = {
            --                    operators = false,
            --                    motions = false,
            --                    text_objects = false,
            --                    windows = false,
            --                    nav = false,
            --                    z = false,
            --                    g = false,
            --                },
            --            },
            --            win = {
            --                border = "rounded",
            --                -- position = "bottom",
            --                padding = { 2, 2, 2, 2 },
            --            },
            --            -- ignore_missing = true,
            --            -- show_help = false,
            --            -- show_keys = false,
            --            disable = {
            --                buftypes = {},
            --                filetypes = { "TelescopePrompt" },
            --            },
        })
    end,
}

-- -- stylua: ignore start
-- -- f is for 'fuzzy find'
-- nmap_leader('f/', '<Cmd>Pick history scope="/"<CR>',                 '"/" history')
-- nmap_leader('f:', '<Cmd>Pick history scope=":"<CR>',                 '":" history')
-- nmap_leader('fa', '<Cmd>Pick git_hunks scope="staged"<CR>',          'Added hunks (all)')
-- nmap_leader('fA', '<Cmd>Pick git_hunks path="%" scope="staged"<CR>', 'Added hunks (current)')
-- nmap_leader('fb', '<Cmd>Pick buffers<CR>',                           'Buffers')
-- nmap_leader('fc', '<Cmd>Pick git_commits<CR>',                       'Commits (all)')
-- nmap_leader('fC', '<Cmd>Pick git_commits path="%"<CR>',              'Commits (current)')
-- nmap_leader('fd', '<Cmd>Pick diagnostic scope="all"<CR>',            'Diagnostic workspace')
-- nmap_leader('fD', '<Cmd>Pick diagnostic scope="current"<CR>',        'Diagnostic buffer')
-- nmap_leader('ff', '<Cmd>Pick files<CR>',                             'Files')
-- nmap_leader('fg', '<Cmd>Pick grep_live<CR>',                         'Grep live')
-- nmap_leader('fG', '<Cmd>Pick grep pattern="<cword>"<CR>',            'Grep current word')
-- nmap_leader('fh', '<Cmd>Pick help<CR>',                              'Help tags')
-- nmap_leader('fH', '<Cmd>Pick hl_groups<CR>',                         'Highlight groups')
-- nmap_leader('fl', '<Cmd>Pick buf_lines scope="all"<CR>',             'Lines (all)')
-- nmap_leader('fL', '<Cmd>Pick buf_lines scope="current"<CR>',         'Lines (current)')
-- nmap_leader('fm', '<Cmd>Pick git_hunks<CR>',                         'Modified hunks (all)')
-- nmap_leader('fM', '<Cmd>Pick git_hunks path="%"<CR>',                'Modified hunks (current)')
-- nmap_leader('fr', '<Cmd>Pick resume<CR>',                            'Resume')
-- nmap_leader('fR', '<Cmd>Pick lsp scope="references"<CR>',            'References (LSP)')
-- nmap_leader('fs', '<Cmd>Pick lsp scope="workspace_symbol"<CR>',      'Symbols workspace (LSP)')
-- nmap_leader('fS', '<Cmd>Pick lsp scope="document_symbol"<CR>',       'Symbols buffer (LSP)')
-- nmap_leader('fv', '<Cmd>Pick visit_paths cwd=""<CR>',                'Visit paths (all)')
-- nmap_leader('fV', '<Cmd>Pick visit_paths<CR>',                       'Visit paths (cwd)')
--
-- -- o is for 'other'
-- local trailspace_toggle_command = '<Cmd>lua vim.b.minitrailspace_disable = not vim.b.minitrailspace_disable<CR>'
-- nmap_leader('oC', '<Cmd>lua MiniCursorword.toggle()<CR>',  'Cursor word hl toggle')
-- nmap_leader('od', '<Cmd>Neogen<CR>',                       'Document')
-- nmap_leader('oh', '<Cmd>normal gxiagxila<CR>',             'Move arg left')
-- nmap_leader('oH', '<Cmd>TSBufToggle highlight<CR>',        'Highlight toggle')
-- nmap_leader('og', '<Cmd>lua MiniDoc.generate()<CR>',       'Generate plugin doc')
-- nmap_leader('ol', '<Cmd>normal gxiagxina<CR>',             'Move arg right')
-- nmap_leader('or', '<Cmd>lua MiniMisc.resize_window()<CR>', 'Resize to default width')
-- nmap_leader('os', '<Cmd>lua MiniSessions.select()<CR>',    'Session select')
-- nmap_leader('oS', '<Cmd>lua Config.insert_section()<CR>',  'Section insert')
-- nmap_leader('ot', '<Cmd>lua MiniTrailspace.trim()<CR>',    'Trim trailspace')
-- nmap_leader('oT', trailspace_toggle_command,                 'Trailspace hl toggle')
-- nmap_leader('oz', '<Cmd>lua MiniMisc.zoom()<CR>',          'Zoom toggle')
--
-- -- - Copy to clipboard and make reprex (which itself is loaded to clipboard)
-- xmap_leader('rx', '"+y :T reprex::reprex()<CR>',                    'Reprex selection')
-- -- stylua: ignore end
