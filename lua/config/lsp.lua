vim.filetype.add({ extension = { templ = "templ" } })
vim.filetype.add({ extension = { jproperties = "jdtls" } })
vim.lsp.enable({
    "tailwindcss",
    "eslint",
    "svelte",
    "graphql",
    "prismals",
    "emmet_ls",
    "taplo",
    -- "nil_ls",
    "nixd",
    "clangd",
    "bashls",
    "dockerls",
    "gopls",
    "templ",
    "ruff",
    -- "ts_ls",
    "tsgo",
    "html",
    "lua_ls",
    "omnisharp",
    "cssls",
    "jsonls",
    "yamlls",
    "marksman",
    "kotlin_language_server",
    "jdtls",

    -- "css_variables",
    -- "cssmodules_ls",
    -- "grammarly",
    -- "lemminx",
    -- "nginx_language_server",
    -- "taplo",
})

-- Testing
vim.diagnostic.config({
    float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
    virtual_text = false,
    virtual_lines = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "󰌶",
        },
    },
    underline = true,
    severity_sort = true,
    update_in_insert = false,
    -- Old config
    -- virtual_text = {
    --     spacing = 4,
    --     source = "if_many",
    --     prefix = "●",
    --     -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
    --     -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
    --     -- prefix = "icons",
    -- },
})

-- Enable inlay hints
vim.lsp.inlay_hint.enable(false)

-- Create default capabilities without cmp
local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()

local renameOpts = {
    -- Additional capabilities can be added here
    workspace = {
        fileOperations = {
            didRename = true,
            willRename = true,
        },
    },
}

vim.lsp.config("*", {
    capabilities = lsp_capabilities,
})

-- Add additional capabilities supported by blink-cmp
local blink_status_ok, blink = pcall(require, "blink.cmp")
if blink_status_ok then
    local ext_capabilities =
        vim.tbl_deep_extend("force", {}, lsp_capabilities, renameOpts, blink.get_lsp_capabilities())
    -- Configure LSP servers using the new vim.lsp.config syntax
    -- Default configuration for all servers
    vim.lsp.config("*", {
        capabilities = ext_capabilities,
    })
end

local keymap = vim.keymap
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
        -- -- Enable colors (TODO: starting v0.12.0)
        -- local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        -- if client:supports_method("textDocument/documentColor") then
        --     vim.lsp.document_color.enable(true, args.buf)
        -- end

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = args.buf, silent = true }
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
            return
        end

        -- set keybinds
        opts.desc = "References"
        keymap.set("n", "gr", function()
            require("snacks.picker").lsp_references()
        end, opts)

        opts.desc = "Goto declaration"
        keymap.set("n", "gD", function()
            require("snacks.picker").lsp_declarations()
        end, opts)

        opts.desc = "Goto definitions"
        keymap.set("n", "gd", function()
            require("snacks.picker").lsp_definitions()
        end, opts)

        opts.desc = "Goto implementations"
        keymap.set("n", "gi", function()
            require("snacks.picker").lsp_implementations()
        end, opts)

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", function()
            require("snacks.picker").lsp_type_definitions()
        end, opts)

        opts.desc = "Code actions"
        keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>ld", function()
            require("snacks.picker").diagnostics_buffer()
        end, opts)

        opts.desc = "Show diagnostics"
        keymap.set("n", "<leader>lD", function()
            require("snacks.picker").diagnostics()
        end, opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "gl", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "<leader>lk", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, opts)

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "<leader>lj", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, opts)

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        -- "Signature Documentation"
        opts.desc = "Show documentation for what is under cursor"
        keymap.set({ "n", "i" }, "gK", vim.lsp.buf.signature_help, opts)

        opts.desc = "Show LSP Symbols"
        keymap.set("n", "<leader>ls", function()
            require("snacks.picker").lsp_symbols()
        end, opts)

        opts.desc = "Show LSP Workspace Symbols"
        keymap.set("n", "<leader>lS", function()
            require("snacks.picker").lsp_workspace_symbols()
        end, opts)

        opts.desc = "Show calls incoming"
        keymap.set("n", "gai", function()
            require("snacks.picker").lsp_incoming_calls()
        end, opts)

        opts.desc = "Show calls outgoing"
        keymap.set("n", "gao", function()
            require("snacks.picker").lsp_outgoing_calls()
        end, opts)

        -- opts.desc = "LSP Info"
        -- keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", opts)

        opts.desc = "Inspect TS Node"
        keymap.set("n", "<leader>ci", "<cmd>Inspect<cr>")

        opts.desc = "Inspect TS Tree"
        keymap.set("n", "<leader>cI", "<cmd>InspectTree<cr>")

        opts.desc = "Refresh code lenses"
        keymap.set("n", "<leader>ly", vim.lsp.codelens.refresh, opts)

        if client.server_capabilities.inlayHintProvider then
            opts.desc = "Toggle inlay hints"
            keymap.set("n", "<leader>lh", function()
                -- Enable inlay hints if supported (Neovim 0.10+)
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
            end, opts)
        end

        opts.desc = "Toggle diagnostics virtual lines"
        keymap.set("n", "<Leader>lv", function()
            vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
        end, opts)

        -- Document highlight on cursor hold
        if client.server_capabilities.documentHighlightProvider then
            local highlight_group = vim.api.nvim_create_augroup("LspDocumentHighlight_" .. args.buf, { clear = true })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = args.buf,
                group = highlight_group,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = args.buf,
                group = highlight_group,
                callback = vim.lsp.buf.clear_references,
            })
        end
        -- Disable defaults
        pcall(vim.keymap.del, "n", "gra")
        pcall(vim.keymap.del, "n", "gri")
        pcall(vim.keymap.del, "n", "grn")
        pcall(vim.keymap.del, "n", "grr")
        pcall(vim.keymap.del, "n", "grt")
    end,
})

-- M.on_attach = function(client, bufnr)
--     bufmap("<leader>le", "<cmd>Telescope quickfix<cr>", "Telescope Quickfix")
--
--     bufmap("<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", "Code[L]ens Action")
--     bufmap("<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", "[Q]uickfix / Open diagnostics list")
--     -- bufmap("[x", vim.lsp.codelens.goto_prev, "lsp: previous code[l]ens")
--     -- bufmap("]x", vim.lsp.codelens.goto_next, "lsp: next code[l]ens")
-- end
