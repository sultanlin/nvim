local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = { { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true } },
}

M.config = function()
    -- set keymaps
    local keymap = function(keys, func, descr)
        vim.keymap.set("n", keys, func, { desc = descr, noremap = true, silent = true })
    end
    keymap("<leader>bb", "<cmd>Telescope buffers previewer=false<cr>", "Find [b]uffer")
    keymap("<leader>fb", "<cmd>Telescope git_branches<cr>", "Checkout branch")
    keymap("<leader>fs", "<cmd>Telescope grep_string<cr>", "Find String under cursor in cwd")
    keymap("<leader>fc", "<cmd>Telescope colorscheme<cr>", "Colorscheme")
    keymap("<leader>ff", "<cmd>Telescope find_files<cr>", "Find files")
    keymap("<leader>fp", "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects")
    keymap("<leader>fg", "<cmd>Telescope live_grep<cr>", "Find Text (Grep)")
    keymap("<leader>fh", "<cmd>Telescope help_tags<cr>", "Help")
    -- keymap("<leader>fl", "<cmd>Telescope resume<cr>","Last Search"  )
    keymap("<leader>fr", "<cmd>Telescope oldfiles<cr>", "Recent File")
    keymap("<leader>fN", "<cmd>Telescope find_files cwd=~/.config/nvim<cr>", "Neovim config files")

    local wk = require("which-key")
    wk.register({
        ["<leader>fH"] = { "<cmd>Telescope highlights<cr>", "Highlights" },
        -- ["<leader>fi"] = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
        ["<leader>fl"] = { "<cmd>Telescope resume<cr>", "Last Search" },
        ["<leader>fM"] = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        ["<leader>fR"] = { "<cmd>Telescope registers<cr>", "Registers" },
        ["<leader>fk"] = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        ["<leader>fC"] = { "<cmd>Telescope commands<cr>", "Commands" },

        ["<leader>go"] = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        ["<leader>gb"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        ["<leader>gc"] = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        ["<leader>gf"] = { "<cmd>Telescope git_files<cr>", "All files in git repo" },
        ["<leader>gC"] = {
            "<cmd>Telescope git_bcommits<cr>",
            "Checkout commit(for current file)",
        },

        -- 	["<leader>bb"] = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
        -- 	["<leader>fb"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        -- 	["<leader>fc"] = { "<cmd>Telescope grep_string<cr>", "Find string under cursor in cwd" },
        -- 	["<leader>ft"] = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        -- 	["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find files" },
        -- 	-- ["<leader>fp"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
        -- 	["<leader>fg"] = { "<cmd>Telescope live_grep<cr>", "Find Text" },
        -- 	-- ["<leader>fh"] = { "<cmd>Telescope help_tags<cr>", "Help" },
        -- 	-- ["<leader>fl"] = { "<cmd>Telescope resume<cr>", "Last Search" },
        -- 	["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
    })
    --
    -- keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    -- keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    -- keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    -- keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    -- keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
    -- keymap.set("n", "<leader>fb", "<cmd>Telescope buffers previewer=false<cr>", { desc = "Find Buffer" })

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "TelescopeResults",
        callback = function(ctx)
            vim.api.nvim_buf_call(ctx.buf, function()
                vim.fn.matchadd("TelescopeParent", "\t\t.*$")
                vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
            end)
        end,
    })

    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local icons = require("sultan.core.icons")

    telescope.setup({
        defaults = {
            -- path_display = { "truncate " },
            prompt_prefix = icons.ui.Telescope .. " ",
            selection_caret = icons.ui.Forward .. " ",
            entry_prefix = "   ",
            initial_mode = "insert",
            selection_strategy = "reset",
            path_display = { "smart" },
            color_devicons = true,
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--hidden",
                "--glob=!.git/",
            },
            mappings = {
                i = {
                    ["<C-n>"] = actions.cycle_history_next,
                    ["<C-p>"] = actions.cycle_history_prev,

                    ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                    ["<C-j>"] = actions.move_selection_next, -- move to next result
                    ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                },
                n = {
                    ["<esc>"] = actions.close,
                    ["j"] = actions.move_selection_next,
                    ["k"] = actions.move_selection_previous,
                    ["q"] = actions.close,
                },
            },
            pickers = {
                live_grep = {
                    theme = "dropdown",
                },

                grep_string = {
                    theme = "dropdown",
                },

                find_files = {
                    theme = "dropdown",
                    previewer = false,
                },

                buffers = {
                    theme = "dropdown",
                    previewer = false,
                    initial_mode = "normal",
                    mappings = {
                        i = {
                            ["<C-d>"] = actions.delete_buffer,
                        },
                        n = {
                            ["dd"] = actions.delete_buffer,
                        },
                    },
                },

                planets = {
                    show_pluto = true,
                    show_moon = true,
                },
                colorscheme = {
                    enable_preview = true,
                },

                lsp_references = {
                    theme = "dropdown",
                    initial_mode = "normal",
                },

                lsp_definitions = {
                    theme = "dropdown",
                    initial_mode = "normal",
                },

                lsp_declarations = {
                    theme = "dropdown",
                    initial_mode = "normal",
                },

                lsp_implementations = {
                    theme = "dropdown",
                    initial_mode = "normal",
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                },
            },
        },
    })

    telescope.load_extension("fzf")
end

return M
