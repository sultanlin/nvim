local util = require("lspconfig/util")
return {
    -- cmd = { "rustup", "run", "stable", "rust-analyzer" },
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_dir = util.root_pattern("Cargo.toml"),
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
            },
            formatting = {
                dynamicRegistration = true,
            },
        },
    },
}
