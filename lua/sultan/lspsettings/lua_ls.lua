local runtime_path = vim.split(package.path, ";")
return {
    settings = {
        Lua = {
            format = { enable = false },
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                special = {
                    spec = "require",
                },
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim", "spec" },
            },
            workspace = {
                checkThirdParty = false,
                library = { vim.api.nvim_get_runtime_file("", true) },
            },
            hint = {
                enable = false,
                arrayIndex = "Disable", -- "Enable" | "Auto" | "Disable"
                await = true,
                paramName = "Disable", -- "All" | "Literal" | "Disable"
                paramType = true,
                semicolon = "All", -- "All" | "SameLine" | "Disable"
                setType = false,
            },
            telemetry = { enable = false },
        },
    },
}
