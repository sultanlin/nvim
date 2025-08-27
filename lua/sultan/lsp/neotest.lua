local M = {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.vim",
        "nvim-treesitter/nvim-treesitter",
        -- general tests
        "vim-test/vim-test",
        -- "nvim-neotest/neotest-vim-test",
        -- language specific tests
        "marilari88/neotest-vitest",
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-plenary",
        "rouge8/neotest-rust",
        "lawrence-laz/neotest-zig",
        "rcasia/neotest-bash",
        "rcasia/neotest-java",
    },
}

function M.config()
    local neotest = require("neotest")
    local wk = require("which-key")
    wk.register({
        ["<leader>tm"] = { "<cmd>lua require'neotest'.run.run()<cr>", "Test Method" },
        ["<leader>tM"] = { "<cmd>lua require'neotest'.run.run({strategy = 'dap'})<cr>", "Test Method DAP" },
        ["<leader>tf"] = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Test File" },
        ["<leader>tF"] = {
            "<cmd>lua require('neotest').run.run(vim.fn.expand('%'), strategy = 'dap')<cr>",
            "Test File DAP",
        },
        ["<leader>ts"] = { "<cmd>lua require'neotest'.summary.toggle()<cr>", "Toggle summary" },
        ["<leader>to"] = { "<cmd>lua require'neotest'.output.open()<cr>", "Open output" },
        ["<leader>tO"] = { "<cmd>lua require'neotest'.output_panel.toggle()<cr>", "Toggle output panel" },
        -- ["<leader>ts"] = { "<cmd>lua require('neotest').run.stop()<cr>", "Test Stop" },
        -- ["<leader>ta"] = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach Test" },
    })

    ---@diagnostic disable: missing-fields
    require("neotest").setup({
        adapters = {
            require("neotest-python")({
                -- Extra arguments for nvim-dap configuration
                -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
                dap = {
                    justMyCode = false,
                    console = "integratedTerminal",
                },
                args = { "--log-level", "DEBUG", "--quiet" },
                runner = "pytest",
            }),
            require("neotest-vitest"),
            -- require "neotest-zig",
            -- require("neotest-rust"),
            require("neotest-go"),
            require("neotest-java")({
                ignore_wrapper = false, -- whether to ignore maven/gradle wrapper
            }),
            -- DAP rustacean broken
            -- require("rustaceanvim.neotest"),
            -- require("neotest-vim-test")({
            --     ignore_file_types = { "python", "vim", "lua", "javascript", "typescript" },
            -- }),
            require("neotest-jest")({
                -- jestConfigFile = function()
                --     local file = vim.fn.expand("%:p")
                --     if string.find(file, "/packages/") then
                --         return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
                --     end
                --     return vim.fn.getcwd() .. "/jest.config.ts"
                -- end,
                -- cwd = function()
                --     local file = vim.fn.expand("%:p")
                --     if string.find(file, "/packages/") then
                --         return string.match(file, "(.-/[^/]+/)src")
                --     end
                --     return vim.fn.getcwd() .. "/jest.config.ts"
                -- end,
            }),
        },
        status = { virtual_text = true },
        output = { open_on_run = true },
        output = { open_on_run = true },
    })
end

return M
