--      "rcasia/neotest-java" -- comes with jdtls
--      "nvim-neotest/neotest-python"
--      neotest-deno
--      neotest-dotnet # C#
--      "lawrence-laz/neotest-zig"
--      "nvim-neotest/neotest-plenary"
--      neotest-dart
--      neotest-elixir
--      neotest-haskell
--      neotest-pest    # PhP
--      neotest-phpunit
--      neotest-scala
--      neotest-rspec   # ruby
--      neotest-testthat    # R

return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",

            { "vim-test/vim-test" },
            { "nvim-neotest/neotest-vim-test" },
            { "marilari88/neotest-vitest" }, -- JS/TS
            { "nvim-neotest/neotest-go", ft = "go" },
            { "nvim-neotest/neotest-jest" },
            -- { "rouge8/neotest-rust" },
            { "rcasia/neotest-bash" },
            { "rcasia/neotest-java", ft = "java" },
            { "mrcjkb/rustaceanvim", ft = "rs" },
        },
        --stylua: ignore
        keys = {
            { "<leader>t", "", desc = "+test" },
            { "<leader>tt", function() require('neotest').run.run(vim.fn.expand('%')) end, desc = "Test File" },
            { "<leader>tT", function() require('neotest').run.run(vim.uv.cwd()) end, desc = "Test All Files" },
            { "<leader>tr", function() require'neotest'.run.run() end, desc = "Test Method" },
            { "<leader>tS", function() require'neotest'.run.stop() end, desc = "Stop" },
            { "<leader>ta", function() require'neotest'.run.attach() end, desc = "Attach to Test" },
            { "<leader>to", function() require'neotest'.output.open() end, desc = "Show Output" },
            { "<leader>tO", function() require'neotest'.output_panel.toggle() end, desc = "Toggle Output Panel" },
            { "<leader>ts", function() require'neotest'.summary.toggle() end, desc = "Show Summary" },
            { "<leader>tw", function() require'neotest'.watch.toggle(vim.fn.expand('%')) end, desc = "Toggle Watch" },
            { "<leader>td", function() require'neotest'.run.run({strategy = 'dap'}) end, desc = "Debug Nearest Test" },
            -- { "<leader>tD", function() require('neotest').run.run({vim.fn.expand("%"), strategy = "dap"}) end, desc = "Test File DAP" },
        },
        opts = {
            adapters = {
                -- require("neotest-python")({
                --     -- Extra arguments for nvim-dap configuration
                --     -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
                --     dap = {
                --         justMyCode = false,
                --         console = "integratedTerminal",
                --     },
                --     args = { "--log-level", "DEBUG", "--quiet" },
                --     runner = "pytest",
                -- }),
                -- require("neotest-vitest"),
                ["neotest-vitest"] = {},
                -- require "neotest-zig",
                -- require("neotest-rust"),
                -- ["neotest-rust"] = {},
                -- require("neotest-go"),
                ["neotest-go"] = {},
                -- require("neotest-java")({
                --     ignore_wrapper = false, -- whether to ignore maven/gradle wrapper
                -- }),
                ["neotest-java"] = { ignore_wrapper = false }, -- whether to ignore maven/gradle wrapper
                -- DAP rustacean broken
                -- require("rustaceanvim.neotest"),
                ["rustaceanvim.neotest"] = {},
                -- require("neotest-vim-test")({
                --     ignore_file_types = { "python", "vim", "lua", "javascript", "typescript" },
                -- }),
                -- require("neotest-jest")({
                ["neotest-jest"] = {
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
                },
            },
            status = { virtual_text = true },
            output = { open_on_run = true },
            -- quickfix = {
            --     open = function()
            --         local exists, trouble = pcall(require, "trouble.nvim")
            --         if exists then
            --             trouble.open({ mode = "quickfix", focus = false })
            --         else
            --             vim.cmd("copen")
            --         end
            --     end,
            -- },
        },
        config = function(_, opts)
            -- local neotest_ns = vim.api.nvim_create_namespace("neotest")
            -- vim.diagnostic.config({
            --     virtual_text = {
            --         format = function(diagnostic)
            --             -- Replace newline and tab characters with space for more compact diagnostics
            --             local message =
            --                 diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            --             return message
            --         end,
            --     },
            -- }, neotest_ns)
            --
            -- local exists, trouble = pcall(require, "trouble.nvim")
            -- if exists then
            --     opts.consumers = opts.consumers or {}
            --     -- Refresh and auto close trouble after running tests
            --     ---@type neotest.Consumer
            --     opts.consumers.trouble = function(client)
            --         client.listeners.results = function(adapter_id, results, partial)
            --             if partial then
            --                 return
            --             end
            --             local tree = assert(client:get_position(nil, { adapter = adapter_id }))
            --
            --             local failed = 0
            --             for pos_id, result in pairs(results) do
            --                 if result.status == "failed" and tree:get_key(pos_id) then
            --                     failed = failed + 1
            --                 end
            --             end
            --             vim.schedule(function()
            --                 if trouble.is_open() then
            --                     trouble.refresh()
            --                     if failed == 0 then
            --                         trouble.close()
            --                     end
            --                 end
            --             end)
            --             return {}
            --         end
            --     end
            -- end
            --
            if opts.adapters then
                local adapters = {}
                for name, config in pairs(opts.adapters or {}) do
                    if type(name) == "number" then
                        if type(config) == "string" then
                            config = require(config)
                        end
                        adapters[#adapters + 1] = config
                    elseif config ~= false then
                        local adapter = require(name)
                        if type(config) == "table" and not vim.tbl_isempty(config) then
                            local meta = getmetatable(adapter)
                            if adapter.setup then
                                adapter.setup(config)
                            elseif adapter.adapter then
                                adapter.adapter(config)
                                adapter = adapter.adapter
                            elseif meta and meta.__call then
                                adapter = adapter(config)
                            else
                                error("Adapter " .. name .. " does not support setup")
                            end
                        end
                        adapters[#adapters + 1] = adapter
                    end
                end
                opts.adapters = adapters
            end

            require("neotest").setup(opts)

            -- local neotest = require("neotest")
            --
            -- ---@diagnostic disable: missing-fields
            -- require("neotest").setup({})
        end,
    },
}
