local M = {}

M.config = function()
	local runtime_path = vim.split(package.path, ";")
	local omnipath = os.getenv("OMNISHARP_ROSLYN_PATH") .. "/lib/omnisharp-roslyn/OmniSharp.dll"
	local servers = {
		-- clangd = {},
		gopls = { cmd = { "gopls" }, { "go", "gomod", "gowork", "gotmpl", "tmpl", "templ" } },
		ruff_lsp = {},
		-- -- rust_analyser = {},
		html = {
			filetypes = { "html", "twig", "hbs" },
		},
		lua_ls = {
			Lua = {
				format = { enable = false },
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
					-- Setup your lua path
					path = runtime_path,
					special = {
						spec = "require",
					},
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim", "spec" },
				},
				workspace = {
					checkThirdParty = false,
					-- library = vim.api.nvim_get_runtime_file("", true),
					library = {
						-- [vim.fn.expand("${runtime_path}VIMRUNTIME/lua")] = true,
						[vim.fn.expand("${runtime_path}/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
				hint = {
					enable = false,
					arrayIndex = "Disable", -- "Enable" | "Auto" | "Disable"
					await = true,
					paramName = "Disable", -- "All" | "Literal" | "Disable"
					paramType = true,
					semicolon = "All", -- "All" | "SameLine" | "Disable"
					setType = false,
				},
				telemetry = { enable = false },
			},
			-- Lua = {
			-- 	workspace = { checkThirdParty = false },
			-- 	telemetry = { enable = false },
			-- },
		},
		omnisharp = {
			cmd = { "dotnet", omnipath },
			enable_roslyn_analyzers = true,
			-- enable_import_completion = true,   -- Can have negative impact on completion responsiveness
			organize_imports_on_format = false,
		},
		tsserver = {},
		-- html = {},
		cssls = {},
		tailwindcss = {},
		eslint = {},
		-- svelte = {},
		-- graphql = {},
		-- prismals = {},
		emmet_ls = {},
		nil_ls = {},
		-- nixd = {},
		-- htmx = { "html", "templ", "tmpl" },
	}

	-- Lua LSP
	require("neodev").setup()

	local on_attach = function(_, bufnr)
		local bufmap = function(keys, func, descr)
			vim.keymap.set("n", keys, func, { buffer = bufnr, desc = descr, noremap = true, silent = true })
		end
		bufmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		bufmap("<leader>ca", vim.lsp.buf.code_action, "See available [C]ode [A]ction")

		bufmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eference")
		-- bufmap('gd', vim.lsp.buf.definition)
		bufmap("gd", "<cmd>Telescope lsp_definitions<CR>", "[G]oto [D]efinition")
		bufmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		bufmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementations")
		bufmap("gt", vim.lsp.buf.type_definition, "[G]oto [T]ype definitions")

		-- bufmap('<leader>D', vim.lsp.buf.type_definition)
		bufmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
		bufmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

		bufmap("K", vim.lsp.buf.hover, "Hover Documentation")
		bufmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

		bufmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd folder")
		bufmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove folder")
		bufmap("<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folder()))
		end, "[W]orkspace [L]ist folder")

		-- bufmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove folder")
		-- -- Diagnostic keymaps
		-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
		-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
		-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
		-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

		vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
			vim.lsp.buf.format()
		end, { desc = "Format current buffer with LSP" })
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

	-- Testing
	vim.diagnostic.config({
		underline = true,
		update_in_insert = false,
		virtual_text = {
			spacing = 4,
			source = "if_many",
			prefix = "●",
			-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
			-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
			-- prefix = "icons",
		},
		severity_sort = true,
	})

	local lspconfig = require("lspconfig")
	-- Set up each server using the common configuration options
	for server, config in pairs(servers) do
		local server_config = vim.tbl_extend("force", {
			on_attach = on_attach,
			capabilities = capabilities,
		}, config)
		lspconfig[server].setup(server_config)
	end

	-- local on_attach = require("sultan.lsputils").on_attach
	-- local capabilities = require("sultan.lsputils").capabilities
	-- local omnipath = os.getenv("OMNISHARP_ROSLYN_PATH") .. "/lib/omnisharp-roslyn/OmniSharp.dll"
	-- lspconfig.omnisharp.setup({
	-- 	on_attach = on_attach,
	-- 	capabilities = capabilities,
	-- 	cmd = { "dotnet", omnipath },
	-- 	enable_roslyn_analyzers = true,
	-- 	analyze_open_documents_only = false,
	-- 	enable_import_completion = true,
	-- })
end

return M
