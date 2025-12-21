---@diagnostic disable: missing-fields
return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        version = false, -- last release is way too old and doesn't work on Windows
        build = ":TSUpdate",
        lazy = false,
        -- event = { "BufReadPre", "BufWritePre", "BufNewFile", "VeryLazy" },
        init = function()
            local ensure_installed = {
                -- NOTE: Bundled parsers (natively installed)
                "c",
                "vim",
                "vimdoc",
                "query",
                "markdown",
                "markdown_inline",
                "lua",

                -- NOTE: Extra parsers
                "angular",
                "bash",
                "cpp",
                "css",
                "dockerfile",
                "git_rebase",
                "gitcommit",
                "go",
                "html",
                "hyprlang",
                "java",
                "javascript",
                "json",
                "kotlin",
                "llvm",
                "luadoc",
                "nix",
                "python",
                "rust",
                "ron",
                "sql",
                "svelte",
                "templ",
                "terraform",
                "tmux",
                "tsx",
                "jsx",
                "typescript",
                "vue",
                "yaml",
                "diff",
                "jsdoc",
                "jsonc",
                "luap",
                "printf",
                "regex",
                "toml",
                "xml",
                "prisma",
                "graphql",
                "gitignore",

                "comment",
                "git_config",
                "latex",
                "make",
                "norg",
                "scss",
                "typst",
            }

            local ts = require("nvim-treesitter")
            local already_installed = ts.get_installed()

            local to_install = vim.iter(ensure_installed)
                :filter(function(parser)
                    return not vim.tbl_contains(already_installed, parser)
                end)
                :totable()

            if #to_install > 0 then
                require("nvim-treesitter").install(to_install)
            end

            -- Ensure tree-sitter enabled after opening a file for target language
            local filetypes = {}
            for _, lang in ipairs(ensure_installed) do
                for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
                    table.insert(filetypes, ft)
                end
            end

            -- WARN: Do not use "*" here - snacks.nvim is buggy and vim.notify triggers FileType events internally causing infinite callback loops
            vim.api.nvim_create_autocmd("FileType", {
                desc = "User: enable treesitter highlighting",
                group = vim.api.nvim_create_augroup("start_treesitter", { clear = true }),
                pattern = filetypes,
                callback = function(event)
                    local bufnr = event.buf

                    -- disable highlighting for large files
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end

                    if not pcall(vim.treesitter.start, bufnr) then -- try to start treesitter which enables syntax highlighting
                        return -- Exit if treesitter was unable to start
                    end

                    -- TS Highlight
                    vim.bo[bufnr].syntax = "on" -- Use regex based syntax-highlighting as fallback as some plugins might need it

                    -- TS Fold
                    vim.wo.foldlevel = 99
                    vim.wo.foldmethod = "expr"
                    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter for folds

                    -- TS Indent
                    -- vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- Use treesitter for indentation
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        -- event = { "BufReadPre", "BufWritePre", "BufNewFile", "VeryLazy" },
        event = { "VeryLazy" },
        config = function()
            -- https://www.reddit.com/r/neovim/comments/1ow2m75/when_would_nvimtreesitter_main_branch_become/
            require("nvim-treesitter-textobjects").setup({
                select = {
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    selection_modes = {
                        ["@parameter.outer"] = "v",
                        ["@function.outer"] = "v",
                        ["@conditional.outer"] = "v",
                        ["@loop.outer"] = "v",
                        ["@class.outer"] = "v",
                    },
                    include_surrounding_whitespace = false,
                },
                move = {
                    set_jumps = true, -- whether to set jumps in the jumplist
                },
            })

            -- TODO: Check if keymap is empty for commented keymaps
            -- select
            local ts_select = require("nvim-treesitter-textobjects.select")

            local keymap = function(keys, func, descr)
                vim.keymap.set({ "x", "o" }, keys, func, { desc = descr, noremap = true, silent = true })
            end
            local selectmap = function(key, obj, descr)
                -- vim.keymap.set({ "x", "o" }, keys, func, { desc = descr })

                keymap("a" .. key, function()
                    ts_select.select_textobject("@" .. obj .. ".outer", "textobjects")
                end, "Outer " .. descr)
                keymap("i" .. key, function()
                    ts_select.select_textobject("@" .. obj .. ".inner", "textobjects")
                end, "Inner " .. descr)
            end
            selectmap("f", "function", "function")
            selectmap("c", "class", "class")
            selectmap("l", "loop", "loop")
            selectmap("m", "call", "call")
            selectmap("e", "assignment", "assignment")
            -- selectmap("r", "parameter", "parameter")
            -- selectmap("k", "block", "block")

            -- selectmap("=", "assignment", "assignment")
            -- selectmap(":", "property", "object property")
            -- selectmap("i", "conditional", "conditional")

            keymap("l=", function()
                ts_select.select_textobject("@assignment.lhs", "textobjects")
            end, "Left Assignment")
            keymap("r=", function()
                ts_select.select_textobject("@assignment.rhs", "textobjects")
            end, "Right Assignment")

            -- NOTE Not done yet
            -- works for javascript/typescript files (custom capture I created in after/queries/ecma/textobjects.scm)
            -- ["l:"] = { query = "@property.lhs", desc = "Select left part of an object property" },
            -- ["r:"] = { query = "@property.rhs", desc = "Select right part of an object property" },
            -- ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
            -- ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

            local movemap = function(key, obj, descr)
                local ts_move = require("nvim-treesitter-textobjects.move")
                vim.keymap.set({ "n", "x", "o" }, "]" .. key, function()
                    ts_move.goto_next_start(obj, "textobjects")
                end, { desc = "Next " .. descr .. " start" })
                vim.keymap.set({ "n", "x", "o" }, "[" .. key, function()
                    ts_move.goto_previous_start(obj, "textobjects")
                end, { desc = "Prev " .. descr .. " start" })
                vim.keymap.set({ "n", "x", "o" }, "]" .. key:upper(), function()
                    ts_move.goto_next_end(obj, "textobjects")
                end, { desc = "Next " .. descr .. " end" })
                vim.keymap.set({ "n", "x", "o" }, "[" .. key:upper(), function()
                    ts_move.goto_previous_end(obj, "textobjects")
                end, { desc = "Prev " .. descr .. " end" })
            end
            -- move
            movemap("f", "@function.outer", "function")
            movemap("m", "@call.outer", "call")
            -- movemap("a", "@parameter.outer", "parameter/argument")
            movemap("c", "@class.outer", "class")

            local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

            -- Repeat movement with ; and ,
            -- ensure ; goes forward and , goes backward regardless of the last direction
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
        end,
    },
}
