local M = {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
        {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-telescope/telescope-dap.nvim",
            "leoluz/nvim-dap-go/",
            "mfussenegger/nvim-dap-python",
        },
    },
}
function M.config()
    local wk = require("which-key")
    wk.register({
        ["<F1>"] = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
        ["<F2>"] = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
        ["<F3>"] = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
        ["<leader>dt"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
        ["<leader>db"] = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
        ["<leader>dc"] = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
        ["<leader>dC"] = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
        ["<leader>dd"] = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
        ["<leader>dd"] = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
        ["<leader>dg"] = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
        -- ["<leader>di"] = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
        -- ["<leader>do"] = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
        -- ["<leader>du"] = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
        ["<leader>dp"] = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
        ["<leader>dr"] = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
        ["<leader>ds"] = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
        ["<leader>dq"] = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
        ["<leader>dU"] = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
    })
    require("nvim-dap-virtual-text").setup()
    require("dap-go").setup({})
    require("dapui").setup({
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
    })

    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.before.attach.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
    end

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
end

return M
