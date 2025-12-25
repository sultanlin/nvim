return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { { "nvim-tree/nvim-web-devicons", lazy = true }, "bwpge/lualine-pretty-path" },
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status") -- to configure lazy pending updates count
        local icons = require("icons")

        lualine.setup({
            options = {

                -- default = { left = "", right = "" },
                -- round = { left = "", right = "" },
                -- block = { left = "█", right = "█" },
                -- arrow = { left = "", right = "" },
                component_separators = { left = "", right = "" },
                -- section_separators = { left = "", right = "" },
                disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
                globalstatus = true, -- single statusline for all windows
                section_separators = { left = "", right = "" },
                -- component_separators = { left = "", right = "" },
            },

            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    "branch",
                    "diff",
                },
                lualine_c = {
                    "pretty_path",
                }, -- NOTE: consider replacing it with project root folder
                lualine_x = {
                    {
                        "diagnostics",
                        -- sources = { "nvim_workspace_diagnostic", "nvim_lsp" }, -- diagnostics for entire workspace
                        sources = { "nvim_diagnostic", "nvim_lsp" }, -- diagnostics for active buffer
                        symbols = {
                            -- error = "" .. " ",
                            -- warn = "" .. " ",
                            -- info = "" .. " ",
                            -- hint = "󰌶" .. " ",
                            error = "" .. " ",
                            warn = "" .. " ",
                            hint = "" .. " ",
                            info = "" .. " ",
                        },
                    },
                },
                lualine_y = {
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = "#ff9e64" },
                        padding = { left = 1, right = 0 },
                    },
                    { "fileformat", separator = "", padding = { left = 1, right = 2 } }, -- Penguin
                },
                lualine_z = {
                    { "progress", separator = "", padding = { left = 0, right = 0 } },
                    { "location", padding = { left = 0, right = 1 } },
                },
            },
            inactive_sections = {
                lualine_b = { { "filename", path = 3, status = true } },
                lualine_c = { { "filename", file_status = true, path = 1 } },
            },

            extensions = { "lazy", "fzf", "quickfix", "man", "fugitive", "toggleterm" },
        })
    end,
}
