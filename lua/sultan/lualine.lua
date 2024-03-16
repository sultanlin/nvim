local M = {}

M.config = function()
    -- config = function()
    local lualine = require("lualine")
    local icons = require("sultan.core.icons")
    -- local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    -- Transparent lualine
    -- local auto_theme_custom = require("lualine.themes.auto")
    -- auto_theme_custom.normal.c.bg = "none"

    -- configure lualine with modified theme
    lualine.setup({
        options = {
            -- theme = auto_theme_custom,
            -- theme = "gruvbox",
            icons_enabled = true,
            -- component_separators = "|",
            -- section_separators = "",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            ignore_focus = { "NvimTree" },
        },

        sections = {
            lualine_a = {
                {
                    "mode",
                    fmt = function(str)
                        return str:lower():sub(1, 1)
                    end,
                },
            },
            lualine_b = {
                "branch",
                {
                    "diff",
                    symbols = {
                        added = icons.git.LineAdded,
                        modified = icons.git.LineModified,
                        removed = icons.git.LineRemoved,
                    },
                },
                {
                    "diagnostics",
                    symbols = {
                        error = icons.diagnostics.Error .. " ",
                        warn = icons.diagnostics.Warning .. " ",
                        info = icons.diagnostics.Information .. " ",
                        hint = icons.diagnostics.Hint .. " ",
                    },
                },
            },
            lualine_c = {
                -- "%=",
                -- require("sultan.lualine").clients_lsp,
            },
            lualine_x = {
                -- {
                --     "filename",
                --     path = 0,
                --     -- symbols = { modified = "", readonly = "", new = "", unnamed = "" },
                --     symbols = {
                --         modified = icons.ui.Pencil,
                --         readonly = icons.ui.Lock,
                --         new = icons.ui.Plus,
                --         unnamed = "",
                --     },
                -- },
                {
                    "filetype",
                    -- icon_only = true,
                },
            },
            lualine_y = { "progress" },
            -- lualine_y = { "location" },
            -- lualine_z = { "progress" },
        },

        -- sections = {
        --     -- lualine_a = { "mode", "branch" },
        --     lualine_a = { "branch" },
        --     lualine_b = { "diagnostics" },
        --     lualine_c = { "%=", require("sultan.lualine").clients_lsp },
        --     -- lualine_x = { "copilot", "filetype" },
        --     lualine_x = { "fileformat", "filetype" },
        --     lualine_y = { "progress" },
        --     lualine_z = {},
        -- },
        extensions = { "quickfix", "man", "fugitive", "toggleterm" },

        -- options = {
        --   theme = "gruvbox",
        -- },
        -- sections = {
        --   lualine_x = {
        --     {
        --       lazy_status.updates,
        --       cond = lazy_status.has_updates,
        --       color = { fg = "#ff9e64" },
        --     },
        --     { "encoding" },
        --     { "fileformat" },
        --     { "filetype" },
        --   },
        -- },
    })
    -- end
end

M.clients_lsp = function()
    local bufnr = vim.api.nvim_get_current_buf()

    local clients = vim.lsp.buf_get_clients(bufnr)
    if next(clients) == nil then
        return ""
    end

    local c = {}
    for _, client in pairs(clients) do
        if client.name ~= "null-ls" then
            table.insert(c, client.name)
        end
    end
    return "          " .. table.concat(c, "|")
end

return M
