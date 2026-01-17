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
        },
    },
}
