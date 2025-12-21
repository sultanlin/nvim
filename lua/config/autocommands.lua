local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General autocommands
local general = augroup("General", { clear = true })

-- Auto-resize splits when window is resized
autocmd("VimResized", {
    group = general,
    pattern = "*",
    command = "wincmd =",
    desc = "Auto-resize splits",
})

-- Create directories when saving a file if they don't exist
autocmd("BufWritePre", {
    group = general,
    pattern = "*",
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
    desc = "Auto-create directories",
})

-- New line after comment is not comment
autocmd({ "BufWinEnter" }, {
    callback = function()
        vim.cmd("set formatoptions-=cro")
    end,
    desc = "New line after comment is not comment",
})

autocmd({ "CmdWinEnter" }, {
    callback = function()
        vim.cmd("quit")
    end,
    desc = "Quit buggy window",
})

-- close some filetypes with <q>
autocmd({ "FileType" }, {
    pattern = {
        "netrw",
        "Jaq",
        "qf",
        "git",
        "help",
        "man",
        "lspinfo",
        "oil",
        "spectre_panel",
        "lir",
        "DressingSelect",
        "tsplayground",
        "query",
        "PlenaryTestPopup",
        "checkhealth",
        "dbout",
        "gitsigns-blame",
        "grug-far",
        "neotest-output",
        "neotest-output-panel",
        "neotest-summary",
        "notify",
        "startuptime",
        "fugitive",
        "dbui",
        "httpResult",
        "dap-repl",
        "",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set("n", "q", function()
                vim.cmd("close")
                pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, {
                buffer = event.buf,
                silent = true,
                desc = "Quit buffer",
            })
        end)
    end,
})

autocmd("FileType", {
    pattern = { "man" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
    end,
    desc = "Make it easier to close man-files when opened inline",
})

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave", "BufWinEnter" }, {
    pattern = { "*" },
    command = "checktime",
    desc = "Reload if file changed",
})

autocmd({ "TextYankPost" }, {
    pattern = "*",
    callback = function()
        -- vim.highlight.on_yank({ higroup = "Visual", timeout = 40 })
        vim.highlight.on_yank()
    end,
    desc = "Highlight on yank",
})

autocmd({ "CursorHold" }, {
    callback = function()
        local status_ok, luasnip = pcall(require, "luasnip")
        if not status_ok then
            return
        end
        if luasnip.expand_or_jumpable() then
            -- ask maintainer for option to make this silent
            -- luasnip.unlink_current()
            vim.cmd([[silent! lua require("luasnip").unlink_current()]])
        end
    end,
    desc = "luasnip snippet help",
})

autocmd("BufWritePre", {
    group = general,
    pattern = "*",
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
    desc = "Remove trailing whitespace on save",
})

autocmd({ "FileType" }, {
    pattern = { "text", "plaintex", "typst", "gitcommit", "markdown", "NeogitCommitMessage" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
    desc = "Wrap and check for spell in text filetypes",
})

autocmd({ "BufWinEnter" }, {
    pattern = { "*" },
    callback = function()
        local dirname = vim.fn.getcwd():match("([^/]+)$")
        vim.opt.titlestring = dirname
    end,
    desc = "set terminal window's title bar",
})

autocmd({ "FileType" }, {
    pattern = { "json", "jsonc", "json5" },
    callback = function()
        vim.opt_local.conceallevel = 0
    end,
    desc = "Fix conceallevel for json files",
})

-- vim.api.nvim_create_autocmd("BufReadPost", {
--     desc = "Open file at the last position it was edited earlier",
--     group = misc_augroup,
--     pattern = "*",
--     command = 'silent! normal! g`"zv',
-- })

-- -- Return to last edit position when opening files
-- autocmd("BufReadPost", {
-- 	group = general,
-- 	pattern = "*",
-- 	callback = function()
-- 		local mark = vim.api.nvim_buf_get_mark(0, '"')
-- 		if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
-- 			vim.api.nvim_win_set_cursor(0, mark)
-- 		end
-- 	end,
-- 	desc = "Return to last edit position",
-- })

-- -- Window navigation in sidekick_terminal buffers
-- autocmd({ "FileType" }, {
-- 	pattern = "sidekick_terminal",
-- 	callback = function()
-- 		local opts = { buffer = true, noremap = true, silent = true }
-- 		vim.keymap.set("t", "<m-h>", "<C-\\><C-n><C-w>h", opts)
-- 		vim.keymap.set("t", "<m-j>", "<C-\\><C-n><C-w>j", opts)
-- 		vim.keymap.set("t", "<m-k>", "<C-\\><C-n><C-w>k", opts)
-- 		vim.keymap.set("t", "<m-l>", "<C-\\><C-n><C-w>l", opts)
-- 		-- vim.keymap.set("t", "<Esc>", "<Nop>", opts)
-- 	end,
-- 	desc = "Window navigation in sidekick terminal",
-- })
