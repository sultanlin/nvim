-- vim.lsp.config("jdtls", {})
-- return {
--     {
--         "JavaHello/spring-boot.nvim",
--         dependencies = {
--             "mfussenegger/nvim-jdtls",
--         },
--         event = "VeryLazy",
--         -- lazy = true,
--         ---@type bootls.Config
--         -- opts = {
--         --     server = {
--         --         on_attach = function(client, bufnr)
--         --             bootls_user_command(bufnr)
--         --         end,
--         --     },
--         --     autocmd = false,
--         -- },
--         config = function()
--             -- WARN: If spring boot tools is not working, install it from vscode extensions
--             -- require("spring_boot").setup({})
--             -- require("spring_boot.launch").start({autocmd = false})
--             require("spring_boot.launch").start({ autocmd = false })
--         end,
--     },
--     {
--         "mfussenegger/nvim-jdtls",
--         -- dependencies = {
--         --     "mfussenegger/nvim-dap",
--         -- },
--         lazy = true,
--         config = function()
--             -- WARN: If spring boot tools is not working, install it from vscode extensions
--             require("spring_boot").setup({})
--             -- require("spring_boot.launch").start({autocmd = false})
--             -- require("spring_boot.launch").start({ autocmd = false })
--         end,
--     },
-- }

-- TODO: Sort out "lazy loading" aka after/ loading from
-- https://github.com/JavaHello/nvim/blob/main/lua/kide/lsp/spring-boot.lua#L58
-- Current issue: It works 100% on .java files but not .properties files
return {
    -- "mfussenegger/nvim-jdtls",
    -- dependencies = {
    --     "JavaHello/spring-boot.nvim",
    --     "mfussenegger/nvim-dap",
    -- },
    -- event = { "BufReadPre", "BufNewFile" },
    -- config = function()
    --     -- WARN: If spring boot tools is not working, install it from vscode extensions
    --     require("spring_boot").setup({})
    -- end,

    {
        "JavaHello/spring-boot.nvim",
        ft = { "java", "jproperties" },
        dependencies = {
            "mfussenegger/nvim-jdtls",
        },
        -- event = { "BufReadPre", "BufNewFile" },
        -- lazy = true,
        ---@type bootls.Config
        -- opts = {},
        -- config = false,
        -- config = function()
        --     -- WARN: If spring boot tools is not working, install it from vscode extensions
        --     -- require("spring_boot").setup({})
        --     -- require("spring_boot.launch").start({autocmd = false})
        --     require("spring_boot.launch").start({ autocmd = false })
        -- end,
    },
    {
        "mfussenegger/nvim-jdtls",
        ft = { "java", "jproperties" },
        dependencies = {
            -- {
            --     "mfussenegger/nvim-dap",
            --     ft = { "java", "jproperties" },
            -- },
        },
        -- event = { "BufReadPre", "BufNewFile" },
        -- config = function()
        --     -- WARN: If spring boot tools is not working, install it from vscode extensions
        --     require("spring_boot").setup({})
        --     -- require("spring_boot.launch").start({autocmd = false})
        --     -- require("spring_boot.launch").start({ autocmd = false })
        -- end,
    },
}
