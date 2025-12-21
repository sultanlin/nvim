return {
    -- https://github.com/tiagovla/tokyodark.nvim
    {
        "folke/tokyonight.nvim",
        -- event = "VeryLazy",
        -- lazy = true,
        opts = {
            -- style = "moon", -- The theme comes in three styles, 'storm', 'moon', a darker variant 'night' and 'day'
            style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
            light_style = "day", -- The theme is used when the background is set to light
            transparent = false, -- Enable this to disable setting the background color
            terminal_colors = true, -- Configure the colors used when opening a ':terminal' in neovim
            styles = {
                -- Value is any valid attr-list value for ':help nvim_set_hl'
                -- comments = { italic = false },
                -- keywords = { italic = false },
                -- Background styles. Can be "dark", "transparent" or "normal"
                -- sidebars = "dark", -- style for sidebars, see below
                -- floats = "dark", -- style for floating windows
            },
            sidebars = { "qf", "help", "neo-tree", "terminal", "packer" }, -- Set a darker background on sidebar-like windows
            day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style
            hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines
            dim_inactive = false, -- dims inactive windows
            lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

            --- You can override specific color groups to use other groups or a hex color
            --- function will be called with a ColorScheme table
            on_colors = function(colors)
                colors.bg = "#14161b"
            end,

            --- You can override specific highlights to use other groups or a hex color
            --- function will be called with a Highlights and ColorScheme table
            on_highlights = function(highlights, colors)
                highlights.SnacksIndent = {
                    fg = colors.bg_highlight,
                }
                highlights.SnacksIndentScope = {
                    fg = colors.fg_gutter,
                }

                highlights.WinSeparator = {
                    fg = colors.fg_gutter,
                }
            end,

            -- To make it transparent
            --   transparent = true,
            --   styles = {
            --     sidebars = "transparent",
            --     floats = "transparent",
            --   },
            -- },
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            -- vim.cmd.colorscheme("tokyonight")
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        -- event = "VeryLazy",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        opts = {
            compile = false, -- enable compiling the colorscheme
            undercurl = true, -- enable undercurls
            commentStyle = { italic = true },
            functionStyle = {},
            keywordStyle = { italic = true },
            statementStyle = { bold = true },
            typeStyle = {},
            transparent = false, -- do not set background color
            dimInactive = false, -- dim inactive window `:h hl-NormalNC`
            terminalColors = true, -- define vim.g.terminal_color_{0,17}
            colors = { -- add/modify theme and palette colors
                palette = {},
                theme = {
                    wave = {},
                    lotus = {},
                    dragon = {},
                    all = {
                        ui = {
                            bg_gutter = "none",
                        },
                    },
                },
            },
            overrides = function(colors) -- add/modify highlights
                local theme = colors.theme
                return {
                    NormalFloat = { bg = "none" },
                    FloatBorder = { bg = "none" },
                    FloatTitle = { bg = "none" },

                    -- Save an hlgroup with dark background and dimmed foreground
                    -- so that you can use it where your still want darker windows.
                    -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                    NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                    -- Popular plugins that open floats will link to NormalFloat by default;
                    -- set their background accordingly if you wish to keep them dark and borderless
                    LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                    MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                }
            end,
            theme = "lotus", -- Load "wave" theme
            background = { -- map the value of 'background' option to a theme
                dark = "wave", -- try "dragon" !
                light = "lotus",
            },
        },
        config = function(_, opts)
            require("kanagawa").setup(opts)
            -- vim.cmd.colorscheme("kanagawa")
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            background = { -- :h background
                dark = "mocha",
                light = "latte",
            },
            -- transparent_background = true, -- disables setting the background color.
            term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
            -- no_italic = true, -- Force no italic
            lsp_styles = {
                underlines = {
                    errors = { "undercurl" },
                    hints = { "undercurl" },
                    warnings = { "undercurl" },
                    information = { "undercurl" },
                },
            },
            integrations = {
                diffview = true,
                grug_far = true,
                markview = true,
                lsp_trouble = true,
                mini = true,
                navic = { enabled = true, custom_bg = "lualine" },
                neotest = true,
                noice = true,
                notify = true,
                snacks = true,
                treesitter_context = true,
                which_key = true,
            },
        },
        event = "VeryLazy",
    },
    {
        "ellisonleao/gruvbox.nvim",
        event = "VeryLazy",
        opts = {
            transparent_mode = false,
            italic = {
                strings = false,
                emphasis = false,
                comments = false,
                folds = false,
                operators = false,
            },
            -- inverse = true, -- invert background for search, diffs, statuslines and errors
            -- contrast = "", -- can be "hard", "soft" or empty string
        },
        config = function(_, opts)
            require("gruvbox").setup(opts)
        end,
    },
    {
        "EdenEast/nightfox.nvim",
        event = "VeryLazy",
        opts = {
            -- options = {
            --     transparent = true, -- Disable setting background
            -- },
        },
        config = function(_, opts)
            require("nightfox").setup(opts)
            vim.cmd.colorscheme("nightfox")
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        event = "VeryLazy",
        opts = {
            -- variant = "auto", -- auto, main, moon, or dawn
            styles = {
                -- transparency = true,
                italic = false,
            },
        },
        config = function(_, opts)
            require("rose-pine").setup(opts)
        end,
    },
    {
        "navarasu/onedark.nvim",
        event = "VeryLazy",
        opts = {
            -- Main options --
            style = "dark", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
            transparent = true, -- Show/hide background
            code_style = {
                comments = "none",
            },

            -- Lualine options --
            lualine = {
                transparent = true, -- lualine center bar transparency
            },

            -- Plugins Config --
            -- diagnostics = {
            --     background = true,    -- use background color for virtual text
            -- },
        },
        config = function(_, opts)
            require("onedark").setup(opts)
        end,
    },
    -- {
    --     "rmehri01/onenord.nvim",
    --     event = "VeryLazy",
    --     opts = {
    --         disable = {
    --             background = true, -- Disable setting the background color
    --             float_background = true, -- Disable setting the background color for floating windows
    --         },
    --     },
    --     config = function(_, opts)
    --         require("onenord").setup(opts)
    --     end,
    -- },
    {
        "Shatur/neovim-ayu",
        name = "ayu",
        event = "VeryLazy",
    },
    {
        "loctvl842/monokai-pro.nvim",
        event = "VeryLazy",
        opts = {
            transparent_background = true,
            styles = {
                comment = { italic = false },
                keyword = { italic = false }, -- any other keyword
                type = { italic = false }, -- (preferred) int, long, char, etc
                tag_attribute = { italic = false }, -- attribute of tag in reactjs
            },
            filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
        },
        config = function(_, opts)
            require("monokai-pro").setup(opts)
        end,
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
        event = "VeryLazy",
    },
    {
        "ribru17/bamboo.nvim",
        event = "VeryLazy",
    },
    {
        "projekt0n/github-nvim-theme",
        event = "VeryLazy",
        opts = {
            options = {
                transparent = false,
                terminal_colors = true,
                styles = {
                    comments = "italic",
                    keywords = "bold",
                    types = "italic,bold",
                },
            },
            palettes = {
                github_dark_default = {
                    -- Customize the cursor line background
                    -- You can use any hex color here
                    bg_highlight = "#1f2428", -- Darker background for cursor line
                },
            },
            groups = {
                github_dark_default = {
                    -- Or override specific highlight groups
                    CursorLine = { bg = "#1f2428" },
                    -- You can also customize CursorLineNr if needed
                    CursorLineNr = { fg = "#e1e4e8", bg = "#1f2428", bold = true },
                },
            },
        },
        config = function(_, opts)
            require("github-theme").setup(opts)
        end,
    },
    -- Not neovim, can't configure with lua
    {
        "sainnhe/gruvbox-material",
        event = "VeryLazy",
        config = function()
            -- gruvbox-material
            vim.g.gruvbox_material_disable_italic_comment = 1
            -- Choose 0, 1 or 2. 2 is more transparent (ex statusline). 0 to turn off transparent
            -- vim.g.gruvbox_material_transparent_background = 1
        end,
    },
    {
        "sainnhe/sonokai",
        event = "VeryLazy",
    },
    {
        "sainnhe/everforest",
        event = "VeryLazy",
    },
    {
        "mhartington/oceanic-next",
        event = "VeryLazy",
    },
    {
        "sonph/onehalf",
        event = "VeryLazy",
    },
    {
        "shaunsingh/nord.nvim",
        event = "VeryLazy",
        config = function()
            -- Nord setup
            vim.g.nord_italic = false
            vim.g.nord_disable_background = false
        end,
    },
    {
        "NLKNguyen/papercolor-theme",
        event = "VeryLazy",
    },
    {
        "bluz71/vim-nightfly-colors",
        event = "VeryLazy",
        config = function()
            -- nightfly
            vim.g.nightflyItalics = false
            vim.g.nightflyTransparent = false
        end,
    },
    {
        "cocopon/iceberg.vim",
        event = "VeryLazy",
    },

    -- local colorscheme = vim.env.COLORSCHEME or "tokyonight"
    -- local function SetColorscheme(color, transparent)
    --     vim.cmd.colorscheme(color)
    --
    --     if transparent == true then
    --         vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    --         vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    --         vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
    --         vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    --         vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
    --         vim.api.nvim_set_hl(0, "GitSignsChange", { bg = "none" })
    --         vim.api.nvim_set_hl(0, "GitSignsDelete", { bg = "none" })
    --         vim.api.nvim_set_hl(0, "GitSignsAdd", { bg = "none" })
    --         vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
    --         vim.api.nvim_set_hl(0, "Folded", { bg = "none" })
    --         vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })
    --         vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
    --         vim.api.nvim_set_hl(0, "Text", { bg = "none" })
    --         vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
    --
    --
    --     end
    -- end
    -- SetColorscheme(colorscheme, false)
}
