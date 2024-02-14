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
        ["<f3>"] = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
        ["<leader>dt"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
        ["<leader>db"] = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
        ["<leader>dc"] = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
        ["<leader>dC"] = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
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
    require("dapui").setup({})

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
end

return M
