local filetypes = {
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact",
    "css",
    "html",
    "astro",
    "lua",
    "templ",
    "cmp_docs",
}
return {
    "catgoose/nvim-colorizer.lua",
    ft = filetypes,
    -- event = "BufReadPre",
    -- event = "VeryLazy",
    opts = {
        -- lazy_load = true,
        filetypes = filetypes,
        user_default_options = {
            -- mode = "virtualtext",
            -- names_custom = true, -- Custom names to be highlighted: table|function|false
            css = true, -- Enable all CSS *features*:
            -- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True sets to 'normal'
            tailwind = true, -- Enable tailwind colors
        },
    },
    -- config = function()
    --     require("colorizer").setup({
    --         filetypes = {
    --             "typescript",
    --             "typescriptreact",
    --             "javascript",
    --             "javascriptreact",
    --             "css",
    --             "html",
    --             "astro",
    --             "lua",
    --             "templ",
    --         },
    --         user_default_options = {
    --             RGB = true, -- #RGB hex codes
    --             RRGGBB = true, -- #RRGGBB hex codes
    --             names = true, -- "Name" codes like Blue
    --             RRGGBBAA = true, -- #RRGGBBAA hex codes
    --             rgb_fn = true, -- CSS rgb() and rgba() functions
    --             hsl_fn = true, -- CSS hsl() and hsla() functions
    --             css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    --             css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
    --             -- Available modes: foreground, background
    --             mode = "background", -- Set the display mode.
    --
    --             -- Old
    --             -- names = false,
    --             -- rgb_fn = true,
    --             -- hsl_fn = true,
    --             tailwind = "both",
    --         },
    --         buftypes = {},
    --     })
    -- end,
}
