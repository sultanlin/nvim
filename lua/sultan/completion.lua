local M = {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
        { "hrsh7th/cmp-emoji", event = "InsertEnter" },
        { "hrsh7th/cmp-buffer", event = "InsertEnter" },
        { "hrsh7th/cmp-path", event = "InsertEnter" },
        { "hrsh7th/cmp-cmdline", event = "InsertEnter" },
        { "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
        { "L3MON4D3/LuaSnip", event = "InsertEnter", dependencies = { "rafamadriz/friendly-snippets" } },
        { "hrsh7th/cmp-nvim-lua" },
    },
}

M.config = function()
    -- vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
    -- vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
    vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })
    vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })

    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    -- require("luasnip.loaders.from_vscode").load()        --- .lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip").filetype_extend("typescriptreact", { "html" })

    -- https://github.com/LunarVim/Launch.nvim/blob/master/lua/user/cmp.lua
    local check_backspace = function()
        local col = vim.fn.col(".") - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
    end

    local icons = require("sultan.core.icons")
    local types = require("cmp.types")

    cmp.setup({
        completion = {
            completeopt = "menu,menuone,preview,noselect",
        },
        snippet = { -- configure how nvim-cmp interacts with snippet engine
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-k>"] = cmp.mapping(
                cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }),
                { "i", "c" }
            ), -- previous suggestion
            ["<C-j>"] = cmp.mapping(
                cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }),
                { "i", "c" }
            ), -- next suggestion
            ["<C-h>"] = function()
                if cmp.visible_docs() then
                    cmp.close_docs()
                else
                    cmp.open_docs()
                end
            end,
            ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
            ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
            ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), -- show completion suggestions
            ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }), -- close completion window
            -- Accept currently selected item. If none selected, `select` first item.
            -- Set `select` to `false` to only confirm explicitly selected items.
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            -- ["<CR>"] = cmp.mapping.confirm({
            -- 	-- select = false,
            -- 	behavior = cmp.ConfirmBehavior.Replace,
            -- 	select = true,
            -- }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expandable() then
                    luasnip.expand()
                elseif luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                elseif check_backspace() then
                    fallback()
                -- require("neotab").tabout()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
        }),
        window = {
            completion = {
                border = "rounded",
                scrollbar = false,
                winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:FloatBorder,Search:None",
                col_offset = -3,
                side_padding = 1,
                scrolloff = 8,
            },
            documentation = {
                border = "rounded",
                winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,Search:None",
            },
        },
        -- sources for autocompletion
        sources = {
            -- { name = "copilot" },
            -- { name = "nvim_lsp" },
            {
                name = "nvim_lsp",
                entry_filter = function(entry, ctx)
                    local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
                    if kind == "Snippet" and ctx.prev_context.filetype == "java" then
                        return false
                    end

                    if ctx.prev_context.filetype == "markdown" then
                        return true
                    end

                    if kind == "Text" then
                        return false
                    end

                    return true
                end,
            },
            { name = "luasnip" },
            -- { name = "cmp_tabnine" },
            { name = "nvim_lua" },
            { name = "buffer" },
            { name = "path" },
            { name = "calc" },
            { name = "emoji" },
            { name = "treesitter" },
            { name = "crates" },
            { name = "tmux" },
        },
        formatting = {
            -- fields = { "abbr", "menu", "kind" },
            -- fields = { "kind", "abbr", "menu" },
            fields = { "abbr", "kind", "menu" },
            format = function(entry, vim_item)
                vim_item.kind = icons.kind[vim_item.kind]
                -- vim_item.menu = ({
                --     nvim_lsp = "",
                --     nvim_lua = "",
                --     luasnip = "",
                --     buffer = "",
                --     path = "",
                --     cmdline = "",
                --     emoji = "",
                -- })[entry.source.name]
                local source = entry.source.name
                vim_item.menu = "(" .. source .. ")"

                if vim.tbl_contains({ "nvim_lsp" }, entry.source.name) then
                    local duplicates = {
                        buffer = 1,
                        path = 1,
                        nvim_lsp = 0,
                        luasnip = 1,
                    }

                    local duplicates_default = 0

                    vim_item.dup = duplicates[entry.source.name] or duplicates_default
                end

                if vim.tbl_contains({ "nvim_lsp" }, entry.source.name) then
                    local words = {}
                    for word in string.gmatch(vim_item.word, "[^-]+") do
                        table.insert(words, word)
                    end

                    local color_name, color_number
                    if
                        words[2] == "x"
                        or words[2] == "y"
                        or words[2] == "t"
                        or words[2] == "b"
                        or words[2] == "l"
                        or words[2] == "r"
                    then
                        color_name = words[3]
                        color_number = words[4]
                    else
                        color_name = words[2]
                        color_number = words[3]
                    end

                    if color_name == "white" or color_name == "black" then
                        local color
                        if color_name == "white" then
                            color = "ffffff"
                        else
                            color = "000000"
                        end

                        local hl_group = "lsp_documentColor_mf_" .. color
                        -- vim.api.nvim_set_hl(0, hl_group, { fg = "#" .. color, bg = "#" .. color })
                        vim.api.nvim_set_hl(0, hl_group, { fg = "#" .. color, bg = "NONE" })
                        vim_item.kind_hl_group = hl_group

                        -- make the color square 2 chars wide
                        vim_item.kind = string.rep("▣", 1)

                        return vim_item
                    elseif #words < 3 or #words > 4 then
                        -- doesn't look like this is a tailwind css color
                        return vim_item
                    end

                    if not color_name or not color_number then
                        return vim_item
                    end

                    return vim_item
                end

                -- if entry.source.name == "cmp_tabnine" then
                --     vim_item.kind = icons.misc.Robot
                --     vim_item.kind_hl_group = "CmpItemKindTabnine"
                -- end

                if entry.source.name == "crates" then
                    vim_item.kind = icons.misc.Package
                    vim_item.kind_hl_group = "CmpItemKindCrate"
                end

                if entry.source.name == "lab.quick_data" then
                    vim_item.kind = icons.misc.CircuitBoard
                    vim_item.kind_hl_group = "CmpItemKindConstant"
                end

                if entry.source.name == "emoji" then
                    vim_item.kind = icons.misc.Smiley
                    vim_item.kind_hl_group = "CmpItemKindEmoji"
                end

                return vim_item
            end,
        },
        -- configure lspkind for vs-code like pictograms in completion menu
        -- formatting = {
        -- 	format = lspkind.cmp_format({
        -- 		maxwidth = 50,
        -- 		ellipsis_char = "...",
        -- 	}),
        -- },
        confirm_opts = {
            -- for confirm button ["<CR>"]
            -- behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
    })

    -- `/` cmdline setup.
    cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" },
        },
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "path" },
        }, {
            {
                name = "cmdline",
                option = {
                    ignore_cmds = { "Man", "!" },
                },
            },
        }),
    })

    vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
            if
                require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
                and not require("luasnip").session.jump_active
            then
                require("luasnip").unlink_current()
            end
        end,
    })

    -- require("luasnip.loaders.from_lua").load("sultan.snippets")
    -- require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets" })
    -- require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })
    -- require("luasnip.loaders.from_lua").load({ paths = { vim.fn.stdpath("config") .. "/lua/snippets" } })
    require("luasnip.loaders.from_lua").lazy_load({ paths = { vim.fn.stdpath("config") .. "/lua/snippets" } })
    -- https://github.com/echasnovski/nvim/blob/master/src/plugins/luasnip.lua
    require("luasnip/loaders/from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/lua/vscode_snippets" } })
end

return M
