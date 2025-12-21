return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            {
                "theHamsta/nvim-dap-virtual-text",
                "nvim-neotest/nvim-nio",
            },
        },
        -- stylua: ignore
        keys = {
            { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
            { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "x" } },
        },
        opts = {
            expand_lines = true,
            floating = {
                border = "single",
                mappings = {
                    close = { "q", "<Esc>" },
                },
            },
            force_buffers = true,
            layouts = {
                {
                    elements = {
                        {
                            id = "scopes",
                            size = 0.50,
                        },
                        {
                            id = "stacks",
                            size = 0.30,
                        },
                        {
                            id = "watches",
                            size = 0.10,
                        },
                        {
                            id = "breakpoints",
                            size = 0.10,
                        },
                    },
                    size = 40,
                    position = "left", -- Can be "left" or "right"
                },
                {
                    elements = {
                        "repl",
                        "console",
                    },
                    size = 10,
                    position = "bottom", -- Can be "bottom" or "top"
                },
            },
            render = {
                indent = 1,
                max_value_lines = 100,
            },
        },
        config = function(_, opts)
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup(opts)
            dap.listeners.before.attach.dapui_config = function()
                dapui.open({})
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open({})
            end
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open({})
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close({})
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close({})
            end
            -- dap.listeners.before.attach.dapui_config = function()
            --     dapui.open()
            -- end
            -- dap.listeners.before.launch.dapui_config = function()
            --     dapui.open()
            -- end
            -- dap.listeners.before.event_terminated.dapui_config = function()
            --     dapui.close()
            -- end
            -- dap.listeners.before.event_exited.dapui_config = function()
            --     dapui.close()
            -- end
        end,
    },
    {
        "mfussenegger/nvim-dap",
        -- event = "VeryLazy",
        dependencies = {
            {
                "rcarriga/nvim-dap-ui",
                "theHamsta/nvim-dap-virtual-text",
                -- "nvim-telescope/telescope-dap.nvim",
                "leoluz/nvim-dap-go",
                -- "mfussenegger/nvim-dap-python",
            },
        },
        --stylua: ignore
        keys = {

            { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
            { "<leader>db", function() require('dap').toggle_breakpoint() end, desc = "Toggle Breakpoint" },
            { "<leader>dc", function() require('dap').continue() end, desc = "Continue" },
            { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
            { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
            { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
            { "<leader>dj", function() require("dap").down() end, desc = "Down" },
            { "<leader>dk", function() require("dap").up() end, desc = "Up" },
            { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
            { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
            { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
            { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
            { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
            { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
            { "<leader>ds", function() require("dap").session() end, desc = "Session" },
            { "<leader>dq", function() require("dap").terminate() end, desc = "Terminate" },
            { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },

            -- { "<F1>", function() require("dap").step_into() end, desc = "Step Into", },
            -- { "<F2>", function() require'dap'.step_over() end, desc = "Step Over" },
            -- { "<F3>", function() require'dap'.step_out() end, desc = "Step Out" },
            -- { "<leader>dC", function() require'dap'.run_to_cursor() end, desc = "Run To Cursor" },
            -- { "<leader>db", function() require'dap'.step_back() end, desc = "Step Back" },
            -- { "<leader>dc", function() require'dap'.continue() end, desc = "Continue" },
            -- { "<leader>dd", function() require'dap'.disconnect() end, desc = "Disconnect" },
            -- { "<leader>dg", function() require'dap'.session() end, desc = "Get Session" },
            -- { "<leader>dp", function() require'dap'.pause() end, desc = "Pause" },
            -- { "<leader>dq", function() require'dap'.close() end, desc = "Quit" },
            -- { "<leader>dr", function() require'dap'.repl.toggle() end, desc = "Toggle Repl" },
            -- { "<leader>ds", function() require'dap'.continue() end, desc = "Start" },
            -- { "<leader>dt", function() require'dap'.toggle_breakpoint() end, desc = "Toggle Breakpoint" },
            -- -- ["<leader>di"] = function() require'dap'.step_into()end, "Step Into" },
            -- -- ["<leader>du"] = function() require'dap'.step_out()end, "Step Out" },
            -- -- ["<leader>do"] = function() require'dap'.step_over()end, "Step Over" },
        },
        config = function()
            vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

            vim.fn.sign_define(
                "Dap" .. "Stopped",
                { text = "󰁕 ", texthl = "DiagnosticWarn", linehl = "DapStoppedLine", numhl = "DapStoppedLine" }
            )
            vim.fn.sign_define("Dap" .. "Breakpoint", { text = " ", texthl = "DiagnosticInfo" })
            vim.fn.sign_define("Dap" .. "BreakpointCondition", { text = " ", texthl = "DiagnosticInfo" })
            vim.fn.sign_define("Dap" .. "BreakpointRejected", { text = " ", texthl = "DiagnosticError" })
            vim.fn.sign_define("Dap" .. "LogPoint", { text = " ", texthl = "DiagnosticInfo" })

            --      -- setup dap config by VsCode launch.json file
            --      local vscode = require("dap.ext.vscode")
            --      local json = require("plenary.json")
            --      vscode.json_decode = function(str)
            --        return vim.json.decode(json.json_strip_comments(str))
            --      end           vim.fn.sign_define("Dap" .. "LogPoint", { text = ".>", texthl = "DiagnosticInfo" })

            require("nvim-dap-virtual-text").setup({})
            require("dap-go").setup({})

            local dap = require("dap")

            -- https://github.com/bcampolo/nvim-starter-kit/blob/java/.config/nvim/lua/plugins/nvim-dap-ui.lua
            -- require("dap").configurations.java = {
            --     {
            --         name = "Debug Launch (2GB)",
            --         type = "java",
            --         request = "launch",
            --         vmArgs = "" .. "-Xmx2g ",
            --     },
            --     {
            --         name = "Debug Attach (8000)",
            --         type = "java",
            --         request = "attach",
            --         hostName = "127.0.0.1",
            --         port = 8000,
            --     },
            --     {
            --         name = "Debug Attach (5005)",
            --         type = "java",
            --         request = "attach",
            --         hostName = "127.0.0.1",
            --         port = 5005,
            --     },
            -- }

            local lsp_codelldb = os.getenv("LSP_CODELLDB")
            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = lsp_codelldb .. "/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb", -- adjust as needed
                    -- command = "codelldb",
                    args = { "--port", "${port}" },

                    -- On windows you may have to uncomment this:
                    -- detached = false,
                },
            }
            dap.configurations.cpp = {
                {
                    name = "Launch file",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    --         terminal = "integrated",
                },
            }

            dap.configurations.c = dap.configurations.cpp
        end,
    },
}
