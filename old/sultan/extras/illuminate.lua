local M = {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
}

function M.config()
    local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
            require("illuminate")["goto_" .. dir .. "_reference"](true)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
    end

    map("]]", "next")
    map("[[", "prev")

    -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
    vim.api.nvim_create_autocmd("FileType", {
        callback = function()
            local buffer = vim.api.nvim_get_current_buf()
            map("]]", "next", buffer)
            map("[[", "prev", buffer)
        end,
    })

    require("illuminate").configure({
        -- delay = 250,
        providers = {
            "lsp",
            "treesitter",
            "regex",
        },
        -- min_count_to_highlight = 2,
        filetypes_denylist = {
            "mason",
            "lspinfo",
            "harpoon",
            "DressingInput",
            "NeogitCommitMessage",
            "qf",
            "dirvish",
            "dirbuf",
            "oil",
            "minifiles",
            "fugitive",
            "git",
            "alpha",
            "NvimTree",
            "neo-tree",
            "lazy",
            "NeogitStatus",
            "Trouble",
            "netrw",
            "lir",
            "DiffviewFiles",
            "DiffviewFileHistory",
            "Outline",
            "Jaq",
            "spectre_panel",
            "toggleterm",
            "DressingSelect",
            "TelescopePrompt",
            "notify",
            "dbui",
        },
    })
end

return M
