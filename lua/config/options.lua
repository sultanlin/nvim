-- TODO: check last https://github.com/xaaha/dev-env/blob/main/nvim/.config/nvim/lua/xaaha/core/options.lua
local tablength = 4
local options = {
    formatoptions = "rqnl1j", -- Improve comment editing
    infercase = true, -- Infer letter cases for a richer built-in keyword completion
    virtualedit = "block", -- Allow cursor to move where there is no text in visual block mode
    autoindent = true,
    expandtab = true, -- convert tabs to spaces
    tabstop = tablength, -- number of spaces when you tab
    -- smarttab = true, --- Makes tabbing smarter will realize you have 2 vs 4
    smartindent = true, -- make indenting smarter again -- WARN: Experimenting
    shiftwidth = tablength, -- indent when using >> or <<
    ignorecase = true, -- ignore case when searching
    -- incsearch = true, --- Start searching before pressing enter
    -- inccommand = "split",
    smartcase = true, -- smart case
    hlsearch = true, -- highlight all matches on previous search pattern
    spelloptions = "camel", -- Treat parts of camelCase words as seprate words
    -- breakindent = true, -- Indent wrapped lines to match line start
    colorcolumn = "80", -- Draw colored column one step to the right of desired maximum width
    cursorline = true, -- Enable highlighting of the current line    -- WARN: Potentially laggy
    laststatus = 3, --- Have a global statusline at the bottom instead of one for each window
    pumblend = 10, -- Make builtin completion menus slightly transparent
    pumheight = 10, -- pop up menu height
    ruler = false, -- Don't show cursor position
    shortmess = "aoOWFcC", -- Disable certain messages from |ins-completion-menu|
    showmode = false, -- Don't show vim mode in command line
    -- showtabline = 2, -- Always show tabline
    -- opt.showtabline = 1 -- always show tabs
    signcolumn = "yes", -- Always show signcolumn or it would frequently shift
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right
    termguicolors = true, -- Enables 24-bit RGB color in the TUI
    wrap = false, -- Display long lines as just one line

    fillchars = table.concat({ eob = " ", diff = "╱", lastline = " ", stl = " " }), -- make EndOfBuffer invisible
    number = true, -- show numbers on the left
    relativenumber = true, -- set relative numbered lines
    numberwidth = 2, -- set number column width {default 4}
    cmdheight = 1, -- 0, --- Give more space for displaying messages
    -- scrolloff = 0, -- minimal number of columns to scroll horizontally.
    scrolloff = 8, -- minimal number of screen columns
    sidescrolloff = 8, -- minimal number of screen columns
    completeopt = { "menuone", "noselect" }, -- mostly just for cmp
    hidden = true, -- required to keep multiple buffers and open multiple buffers
    mouse = "a", -- allow mouse to be used
    timeout = true,
    timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds),
    updatetime = 100, -- faster completion (4000ms default)
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    clipboard = "unnamedplus", --- Copy-paste between vim and everything else
    viminfo = "'1000", --- Increase the size of file history
    backspace = "indent,eol,start", --- Making sure backspace works
    conceallevel = 0, -- so that `` is visible in markdown files			-- 2,
    showcmd = false,
    title = true,
    titlelen = 0, -- do not shorten title
    -- titlestring = "%{expand('%:t')}",
    -- Command-line completion mode
    wildmode = "list:longest,list:full",
    wildmenu = true,

    -- Session management
    undofile = true, -- enable persistent undo
    undodir = os.getenv("HOME") .. "/.vim/undodir",
    swapfile = false, -- creates a swapfile
    backup = false, -- creates a backup file

    shell = "zsh",
}

local global = {
    mkdp_auto_close = false, -- Don't Exit Preview When Switching Buffers
    autoformat = true, -- Automatically format
    -- Leader key =================================================================
    mapleader = " ", -- Set mapleader to space
    maplocalleader = " ",
    startup_message = false,
    speeddating_no_mappings = 1, --- Disable default mappings for speeddating
}

-- vim.opt.shortmess:append("Ac") -- Disable asking when editing file with swapfile.
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")

for name, value in pairs(options) do
    vim.opt[name] = value
end

for name, value in pairs(global) do
    vim.g[name] = value
end

vim.g.netrw_banner = 0
vim.g.netrw_mouse = 2
-- opt.formatoptions = "jcroqlnt" -- tcqj
-- opt.grepformat = "%f:%l:%c:%m"
-- opt.grepprg = "rg --vimgrep"

--stylua: ignore start
--stylua: ignore end
