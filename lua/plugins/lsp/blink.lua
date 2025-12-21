-- Resources:
-- https://www.youtube.com/watch?v=fGzoSvJFbqw
return {
    {
        "saghen/blink.cmp",
        dependencies = {
            "L3MON4D3/LuaSnip",
            -- "giuxtaposition/blink-cmp-copilot",
        },
        -- build instructions for nix: https://cmp.saghen.dev/configuration/fuzzy.html
        -- build = "cargo build --release",
        event = { "InsertEnter", "CmdlineEnter" },
        opts = {
            cmdline = {
                enabled = true,
                keymap = {
                    -- preset = "inherit",
                    preset = "cmdline",
                    ["<C-j>"] = { "select_next", "fallback" },
                    ["<C-k>"] = { "select_prev", "fallback" },
                },
            },

            keymap = {
                preset = "default",
                ["<C-k>"] = { "select_prev", "fallback" },
                ["<C-j>"] = { "select_next", "fallback" },
                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
                ["<CR>"] = { "select_and_accept", "fallback" },
                -- show with a list of providers
                ["<C-space>"] = {
                    function(cmp)
                        cmp.show({ providers = { "snippets" } })
                    end,
                },
            },

            fuzzy = {
                implementation = "prefer_rust_with_warning",
            },
            appearance = {
                kind_icons = require("icons").symbol_kinds,
            },

            completion = {
                list = {
                    -- Insert items while navigating the completion list.
                    selection = { preselect = false, auto_insert = true },
                    -- max_items = 10,
                },
                menu = {
                    auto_show = true,
                    scrollbar = false,
                    draw = {
                        gap = 2,
                        columns = {
                            -- { "kind_icon", "kind", gap = 1 },
                            { "kind_icon", gap = 1 },
                            { "label", "label_description", gap = 1 },
                        },
                    },
                },
                documentation = { auto_show = true },
            },
            -- snippets = {},
            snippets = { preset = "luasnip" },
            sources = {
                -- default = { "codeium", "lazydev", "lsp", "path", "buffer" },
                -- default = { "copilot", "lazydev", "lsp", "path", "buffer" },
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                per_filetype = {
                    lua = { inherit_defaults = true, "lazydev" },
                },
                providers = {
                    -- copilot = {
                    --     name = "copilot",
                    --     module = "blink-cmp-copilot",
                    --     score_offset = 100,
                    --     async = true,
                    --     transform_items = function(_, items)
                    --         local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                    --         local kind_idx = #CompletionItemKind + 1
                    --         CompletionItemKind[kind_idx] = "Copilot"
                    --         for _, item in ipairs(items) do
                    --             item.kind = kind_idx
                    --         end
                    --         return items
                    --     end,
                    -- },
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                        transform_items = function(_, items)
                            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                            local kind_idx = #CompletionItemKind + 1
                            CompletionItemKind[kind_idx] = "LazyDev"
                            for _, item in ipairs(items) do
                                item.kind = kind_idx
                            end
                            return items
                        end,
                    },
                },
            },
        },
        config = function(_, opts)
            require("blink.cmp").setup(opts)
        end,
    },
    -- Snippets.
    {
        {
            "L3MON4D3/LuaSnip",
            dependencies = {
                "L3MON4D3/LuaSnip",
                "rafamadriz/friendly-snippets",
                -- "giuxtaposition/blink-cmp-copilot",
            },
            event = { "InsertEnter", "CmdlineEnter" },
            keys = {
                {
                    "<C-r>s",
                    function()
                        require("luasnip.extras.otf").on_the_fly("s")
                    end,
                    desc = "Insert on-the-fly snippet",
                    mode = "i",
                },
            },
            opts = function()
                local types = require("luasnip.util.types")
                return {
                    enable_autosnippets = true,
                    history = true,
                    -- Check if the current snippet was deleted.
                    delete_check_events = "TextChanged",
                    -- Display a cursor-like placeholder in unvisited nodes
                    -- of the snippet.
                    ext_opts = {
                        [types.insertNode] = {
                            unvisited = {
                                virt_text = { { "|", "Conceal" } },
                                virt_text_pos = "inline",
                            },
                        },
                        [types.exitNode] = {
                            unvisited = {
                                virt_text = { { "|", "Conceal" } },
                                virt_text_pos = "inline",
                            },
                        },
                        [types.choiceNode] = {
                            active = {
                                virt_text = { { "(snippet) choice node", "LspInlayHint" } },
                            },
                        },
                    },
                }
            end,
            config = function(_, opts)
                local luasnip = require("luasnip")

                ---@diagnostic disable: undefined-field
                luasnip.setup(opts)

                -- Load my custom snippets:
                require("luasnip.loaders.from_lua").lazy_load({
                    paths = { vim.fn.stdpath("config") .. "/snippets/lua" },
                })
                require("luasnip.loaders.from_vscode").lazy_load({
                    paths = { vim.fn.stdpath("config") .. "/snippets" },
                })
                require("luasnip.loaders.from_vscode").lazy_load({
                    exclude = { "rust" },
                }) -- load friendly snippets

                -- Use <C-c> to select a choice in a snippet.
                vim.keymap.set({ "i", "s" }, "<C-c>", function()
                    if luasnip.choice_active() then
                        require("luasnip.extras.select_choice")()
                    end
                end, { desc = "Select choice" })
                ---@diagnostic enable: undefined-field
            end,
        },
    },
}
