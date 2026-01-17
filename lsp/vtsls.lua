return {
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    {
                        name = "@vue/typescript-plugin",
                        location = os.getenv("LSP_VUE")
                            -- .. "/lib/language-tools/packages/language-server/node_modules/@vue/typescript-plugin",
                            -- .. "/lib/language-tools/node_modules/.pnpm/node_modules/@vue/language-server",
                            .. "/lib/language-tools/packages/language-server",
                        languages = { "vue" },
                        configNamespace = "typescript",
                    },
                },
            },
        },
    },
    filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
    },
}
