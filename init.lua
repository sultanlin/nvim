-- REVIEW LATER: :h [
-- FIX: Lag/flicker/blink when scrolling down using <C-d>
-- Especially when scrolling down from top of the screen

-- TODO: Add codium ai
vim.loader.enable()
require("sultan.core.options")
require("sultan.core.keymaps")
require("sultan.core.autocmds")
require("sultan.core.launch")
spec("sultan.core.icons")

-- Load plugins after loading lazy
local init = function()
    -- Load colorschemes first
    spec("sultan.colorscheme")

    spec("sultan.which-key")

    spec("sultan.devicons")
    -- spec("sultan.indentline")
    spec("sultan.telescope")
    spec("sultan.treesitter")
    spec("sultan.treesitter-text-objects")
    spec("sultan.lsp.debug")
    spec("sultan.lsp.completion")
    spec("sultan.barbecue")
    spec("sultan.comment")
    spec("sultan.mini")
    spec("sultan.git.gitsigns")
    spec("sultan.lsp.lspconfig")
    spec("sultan.navic")
    -- spec("sultan.git.neogit")
    spec("sultan.lsp.none-ls")
    spec("sultan.lsp.conform")
    spec("sultan.lsp.linter")
    spec("sultan.lsp.neotest")
    spec("sultan.lualine")
    -- spec("sultan.project")
    spec("sultan.toggleterm")
    spec("sultan.nvimtree")

    spec("sultan.lsp.rustaceanvim")
    spec("sultan.lsp.jdtls")

    -- Put them in extras
    -- https://github.com/ChristianChiarulli/nvim/blob/master/lua/user/extras/test.lua
    -- https://www.youtube.com/watch?v=KGJV0n70Mxs
    -- 4:54:00
    -- https://github.com/mrjones2014/legendary.nvim
    -- https://github.com/SmiteshP/nvim-navic
    -- https://github.com/utilyre/barbecue.nvim
    -- https://www.google.co.uk/search?q=total+typescript&sca_esv=600840769&source=hp&ei=zi-wZbXrI46gnesP__2B6A8&iflsig=ANes7DEAAAAAZbA93rukaY4B1cmKIs1kycl6B88CaMG5&ved=0ahUKEwi1iuiruvSDAxUOUGcHHf9-AP0Q4dUDCA8&uact=5&oq=total+typescript&gs_lp=Egdnd3Mtd2l6IhB0b3RhbCB0eXBlc2NyaXB0MgUQLhiABDIFEAAYgAQyBRAAGIAEMgUQABiABDIFEAAYgAQyBRAAGIAEMgUQABiABDIFEAAYgAQyBRAAGIAEMgUQABiABEjjFlAAWMQVcAF4AJABAJgBywGgAdUTqgEGMC4xNi4xuAEDyAEA-AEBwgILEAAYgAQYigUYkQLCAgoQABiABBiKBRhDwgILEAAYgAQYsQMYgwHCAhEQLhiABBixAxiDARjHARjRA8ICDhAAGIAEGIoFGLEDGIMBwgILEC4YgAQYsQMYgwHCAggQABiABBixA8ICDhAuGIAEGLEDGMcBGNEDwgIOEC4YgAQYigUYsQMYgwHCAhEQLhiDARiRAhixAxiABBiKBcICFBAuGIAEGIoFGLEDGIMBGMcBGNEDwgIIEC4YgAQYsQPCAhEQLhiDARjHARixAxjRAxiABMICCxAuGIAEGMcBGNEDwgIHEC4YgAQYCg&sclient=gws-wiz
    spec("sultan.extras.bqf")
    spec("sultan.extras.colorizer")
    spec("sultan.extras.dressing")
    spec("sultan.extras.eyeliner")
    spec("sultan.git.gitlinker")
    spec("sultan.extras.harpoon")
    spec("sultan.extras.matchup")
    -- spec("sultan.extras.modicator") -- BUG: Breaks jdtls code actions preview (command line preview)
    -- spec("sultan.extras.numb")
    spec("sultan.extras.noice")
    spec("sultan.extras.oil")
    -- spec("sultan.extras.spider")
    -- spec("sultan.extras.surround")
    spec("sultan.extras.tabby")
    -- spec("sultan.extras.tabout")
    spec("sultan.extras.todo-comments")
    spec("sultan.git.lazygit")
    spec("sultan.extras.trouble")
    spec("sultan.extras.ufo") -- warn: do not use z, it will lag <c-d>zz
    spec("sultan.extras.undotree")
    spec("sultan.extras.spectre") -- potential conflict with surround keymaps
    spec("sultan.extras.zen-mode")

    spec("sultan.extras.illuminate")
    -- spec("sultan.alpha")
end

local checkNixos = os.getenv("NEOVIM_NIXOS") or "false"
if checkNixos == "true" then
    init()
elseif checkNixos == "false" then
    -- First neovim install command: nvim --headless "+Lazy! sync" +qa
    require("sultan.lazy.lazy")
    init()
    spec("sultan.lazy.mason")
    spec("sultan.lazy.fugitive")
    spec("sultan.lazy.mason")
    spec("sultan.lazy.rainbow")
    spec("sultan.lazy.schemastore")
    spec("sultan.lazy.sleuth")
    spec("sultan.lazy.tmux-navigator")
end
