local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- local colorscheme = vim.env.COLORSCHEME or "kanagawa"
-- print(colorscheme)
require("lazy").setup({
    spec = {
        { import = "plugins.colorscheme" },
        { import = "plugins" },
        -- { "colors", import = "plugins.colors" },
        { import = "plugins.lsp" },
        -- { import = "plugins.extras" },
        -- { import = "plugins.colors" },
    },
    install = {
        missing = true,
        colorscheme = { "kanagawa", "habamax" },
    },
    change_detection = {
        enabled = true,
        notify = false,
    },
    checker = {
        enabled = true,
        notify = false, -- notify on update
    },

    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
