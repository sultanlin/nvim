return {
    settings = {
        typescript = {
            inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,

                -- includeInlayFunctionParameterTypeHints = false,
                -- includeInlayParameterNameHints = "none",
                -- includeCompletionsWithClassMemberSnippets = false,
                -- includeCompletionsWithObjectLiteralMethodSnippets = false,
                -- includeCompletionsWithSnippetText = false,
                -- includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                -- importModuleSpecifierPreference = "non-relative",
                importModuleSpecifierPreference = "shortest",
            },
            preferences = {
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
                -- importModuleSpecifierPreference = "non-relative",
                importModuleSpecifierPreference = "non-relative",
                -- importModuleSpecifierPreference = "relative",
                -- importModuleSpecifierEnding = "minimal",
                importModuleSpecifier = "non-relative",
            },
        },
        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
            preferences = {
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
                -- importModuleSpecifierPreference = "non-relative",
                importModuleSpecifierPreference = "non-relative",
                -- importModuleSpecifierPreference = "relative",
                -- importModuleSpecifierEnding = "minimal",
            },
        },
    },
}
