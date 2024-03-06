local M = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        {
            "folke/neodev.nvim",
        },
    },
}

M.config = function()
    vim.filetype.add({ extension = { templ = "templ" } })

    local servers = {
        "tailwindcss",
        "eslint",
        "svelte",
        "graphql",
        "prismals",
        "emmet_ls",
        "nil_ls",
        "clangd",
        "bashls",
        "dockerls",
        -- "nixd",
        -- htmx = { "html", "templ", "tmpl" },
        "gopls",
        "templ",
        "ruff_lsp",
        "tsserver",
        "html",
        "rust_analyzer",
        "lua_ls",
        "omnisharp",
        "cssls",
        "jsonls",
        "yamlls",
        "marksman",
        -- "jdtls",
    }

    -- Testing
    local icons = require("sultan.core.icons")

    local default_diagnostic_config = {
        signs = {
            active = true,
            values = {
                { name = "DiagnosticSignError", text = icons.diagnostics.Error },
                { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
                { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
                { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
            },
        },
        underline = true,
        update_in_insert = false,
        -- virtual_text = false,
        -- Old config
        virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
            -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
            -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
            -- prefix = "icons",
        },
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(default_diagnostic_config)

    for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
    end

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
    require("lspconfig.ui.windows").default_options.border = "rounded"

    -- Set up each server using the common configuration options
    local lspconfig = require("lspconfig")
    for _, server in pairs(servers) do
        local opts = {
            -- on_attach = M.on_attach(),
            on_attach = M.on_attach,
            capabilities = M.capabilities,
        }

        local require_ok, settings = pcall(require, "sultan.lspsettings." .. server)
        if require_ok then
            opts = vim.tbl_deep_extend("force", settings, opts)
        end

        lspconfig[server].setup(opts)
    end

    -- Lua LSP
    require("neodev").setup({ library = { plugins = { "neotest" }, types = true } })
end

M.on_attach = function(client, bufnr)
    local bufmap = function(keys, func, descr)
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = descr, noremap = true, silent = true })
    end
    local toggle_inlay_hints = function()
        local bufnr = vim.api.nvim_get_current_buf()
        vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr))
    end
    bufmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eference")
    -- bufmap("gr", "<cmd>lua vim.lsp.buf.references()<CR>", "[G]oto [R]eference")
    --
    -- bufmap('gd', vim.lsp.buf.definition)
    bufmap("gd", "<cmd>Telescope lsp_definitions<CR>", "[G]oto [d]efinition")
    bufmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    bufmap("gi", vim.lsp.buf.implementation, "[G]oto [i]mplementations")
    bufmap("gt", vim.lsp.buf.type_definition, "[G]oto [t]ype definitions")
    bufmap("gl", vim.diagnostic.open_float, "Open floating diagnostic message")

    -- bufmap('<leader>D', vim.lsp.buf.type_definition)
    -- Fuzzy find all symbols in your current document
    -- Symbols are things like variables, functions, types, etc.
    bufmap("<leader>ls", require("telescope.builtin").lsp_document_symbols, "Document [s]ymbols")
    -- Fuzzy find all symbols in your current workspace
    -- Symbols are things like variables, functions, types, etc.
    bufmap("<leader>lS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace [S]ymbols")
    bufmap("<leader>le", "<cmd>Telescope quickfix<cr>", "Telescope Quickfix")

    -- Opens a popup that displays documentation about the word under your cursor
    bufmap("K", vim.lsp.buf.hover, "Hover Documentation")
    -- Opens a popup that displays documentation about the word under your cursor
    bufmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    bufmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd folder")
    bufmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove folder")
    bufmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folder()))
    end, "[W]orkspace [L]ist folder")

    -- bufmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove folder")

    bufmap(
        "<leader>lf",
        "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
        "[F]ormat"
    )
    bufmap("<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code [A]ction")
    bufmap("<leader>li", "<cmd>LspInfo<cr>", "[I]nfo")
    bufmap("<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic")
    bufmap("<leader>lh", "<cmd>lua require('sultan.lspconfig').toggle_inlay_hints()<cr>", "Toggle Inlay [H]ints")
    -- bufmap("<leader>lh", "<cmd>lua toggle_inlay_hints()<cr>", "Toggle Inlay [H]ints")
    bufmap("<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic")
    bufmap("<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", "Code[L]ens Action")
    bufmap("<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", "[R]ename")
    bufmap("<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", "[Q]uickfix / Open diagnostics list")

    vim.keymap.set(
        "v",
        "<leader>la",
        "<cmd>lua vim.lsp.buf.code_action()<cr>",
        { buffer = bufnr, desc = "Code [A]ction", noremap = true, silent = true }
    )
    -- require("which-key").register({
    -- 	["<leader>la"] = {
    -- 		name = "LSP",
    -- 		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action", mode = "v" },
    -- 	},
    -- })

    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(client)
                return client.name == "null-ls"
            end,
        })
    end, { desc = "Format current buffer with LSP" })

    -- if client.supports_method("textDocument/inlayHint") then
    --     vim.lsp.inlay_hint.enable(bufnr, true)
    -- end

    -- Turn off formatting from LSP
    -- if client.name == "tsserver" then
    --     client.resolved_capabilities.document_formatting = false
    -- end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- M.capabilities = vim.lsp.protocol.make_client_capabilities()
-- M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

M.toggle_inlay_hints = function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr))
end

return M
