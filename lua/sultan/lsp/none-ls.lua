local M = {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
}

function M.config()
    local null_ls = require("null-ls")

    -- Switched to conform and nvim lint
    -- local formatting = null_ls.builtins.formatting
    -- local diagnostics = null_ls.builtins.diagnostics

    -- Only using none-ls for code actions
    local codeaction = null_ls.builtins.code_actions

    null_ls.setup({
        debug = false,
        sources = {
            codeaction.statix,
            codeaction.gomodifytags,
            codeaction.impl,
            -- codeaction.gitsigns,
            -- codeaction.refactoring,
        },
    })
    -- 	on_attach = function(client, bufnr)
    -- 		vim.keymap.set(
    -- 			"n",
    -- 			"<leader>tF",
    -- 			"<cmd>lua require('core.plugins.lsp.utils').toggle_autoformat()<cr>",
    -- 			{ desc = "Toggle format on save" }
    -- 		)
    -- 		if client.supports_method("textDocument/formatting") then
    -- 			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    -- 			vim.api.nvim_create_autocmd("BufWritePre", {
    -- 				group = augroup,
    -- 				buffer = bufnr,
    -- 				callback = function()
    -- 					if AUTOFORMAT_ACTIVE then -- global var defined in functions.lua
    -- 						vim.lsp.buf.format({ bufnr = bufnr })
    -- 					end
    -- 				end,
    -- 			})
    -- 		end
    -- 	end,
    -- })
end

return M
