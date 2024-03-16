local M = {
    "nvim-tree/nvim-tree.lua",
    event = "VeryLazy",
}

function M.config()
    local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        -- vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
    end

    local wk = require("which-key")
    wk.register({
        ["<leader>e"] = { "<cmd>NvimTreeToggle<CR>", "File [E]xplorer" },
    })

    local icons = require("sultan.core.icons")

    require("nvim-tree").setup({
        hijack_netrw = false,
        sync_root_with_cwd = true,
        on_attach = my_on_attach,
        view = {
            relativenumber = true,
        },
        actions = {
            open_file = { quit_on_open = true },
        },
        filters = {
            custom = { "^.git$" },
        },
        renderer = {
            add_trailing = false,
            group_empty = false,
            highlight_git = false,
            full_name = false,
            highlight_opened_files = "none",
            root_folder_label = ":t",
            indent_width = 2,
            indent_markers = {
                enable = false,
                inline_arrows = true,
                icons = {
                    corner = "└",
                    edge = "│",
                    item = "│",
                    none = " ",
                },
            },
            icons = {
                git_placement = "before",
                padding = " ",
                symlink_arrow = " ➛ ",
                glyphs = {
                    default = icons.ui.Text,
                    symlink = icons.ui.FileSymlink,
                    bookmark = icons.ui.BookMark,
                    folder = {
                        arrow_closed = icons.ui.ChevronRight,
                        arrow_open = icons.ui.ChevronShortDown,
                        default = icons.ui.Folder,
                        open = icons.ui.FolderOpen,
                        empty = icons.ui.EmptyFolder,
                        empty_open = icons.ui.EmptyFolderOpen,
                        symlink = icons.ui.FolderSymlink,
                        symlink_open = icons.ui.FolderOpen,
                    },
                    git = {
                        unstaged = icons.git.FileUnstaged,
                        staged = icons.git.FileStaged,
                        unmerged = icons.git.FileUnmerged,
                        renamed = icons.git.FileRenamed,
                        untracked = icons.git.FileUntracked,
                        deleted = icons.git.FileDeleted,
                        ignored = icons.git.FileIgnored,
                    },
                },
            },
            special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
            symlink_destination = true,
        },
        update_focused_file = {
            enable = true,
            debounce_delay = 15,
            update_root = true,
            ignore_list = {},
        },

        diagnostics = {
            enable = true,
            show_on_dirs = false,
            show_on_open_dirs = true,
            debounce_delay = 50,
            severity = {
                min = vim.diagnostic.severity.HINT,
                max = vim.diagnostic.severity.ERROR,
            },
            icons = {
                hint = icons.diagnostics.BoldHint,
                info = icons.diagnostics.BoldInformation,
                warning = icons.diagnostics.BoldWarning,
                error = icons.diagnostics.BoldError,
            },
        },
    })
end

return M
