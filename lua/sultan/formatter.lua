local M = {}

M.config = function()
	local conform = require("conform")
	conform.setup({
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
		-- formatters = {
		-- 	xmlformat = {
		-- 		cmd = { "xmlformat" },
		-- 		args = { "--selfclose", "-" },
		-- 	},
		-- },
		formatters_by_ft = {
			lua = { "stylua" },
			--   -- Conform will run multiple formatters sequentially
			-- python = { "isort", "black" },
			python = { "ruff_fix ", "ruff_format" },
			-- Use a sub-list to run only the first available formatter
			javascript = { { "prettierd", "prettier" } },
			typescript = { { "prettierd", "prettier" } },
			typescriptreact = { { "prettierd", "prettier" } },
			javascriptreact = { { "prettierd", "prettier" } },
			svelte = { { "prettierd", "prettier" } },
			css = { { "prettierd", "prettier" } },
			html = { { "prettierd", "prettier" } },
			json = { { "prettierd", "prettier" } },
			yaml = { { "prettierd", "prettier" } },
			markdown = { { "prettierd", "prettier" } },
			graphql = { { "prettierd", "prettier" } },

			-- cs = { "csharpier" },
			-- markdown = { "mdformat" },
			-- xml = { "xmlformat" },
			-- yaml = { "yamlfix" },
			go = { "goimports", "gofmt" },
			nix = { "alejandra" },
			-- rust = { "rustfmt" },
		},

		-- Set format keybind
		vim.keymap.set({ "n", "v" }, "<leader>fm", function()
			conform.format({
				lsp_fallback = true,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range (in visual mode)" }),
	})

	-- conform.formatters.prettierd = {
	-- 	prepend_args = { "html-whitespace-sensitivity", "ignore" },
	-- 	-- env = {
	-- 	-- 	htmlWhitespaceSensitivity = "ignore",
	-- 	-- },
	-- }
end

return M
