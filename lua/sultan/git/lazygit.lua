local M = {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufReadPre",
}

function M.config()
    local bufmap = function(keys, func, descr)
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = descr, noremap = true, silent = true })
    end

    -- bufmap("gg", "<Cmd>lua Config.open_lazygit()<CR>", "Git tab")
    bufmap("<leader>gg", "<Cmd>LazyGit<CR>", "Git tab")
    -- require("lazygit").setup({
    -- })
end

return M
