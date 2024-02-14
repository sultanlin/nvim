-- ########################
-- #   Neovim Options    #
-- #######################

local tablength = 4
local options = {

    -- Tab/Indentation
    tabstop = tablength, -- number of spaces when you tab
    smartindent = true, -- make indenting smarter again
    smarttab = true, --- Makes tabbing smarter will realize you have 2 vs 4
    softtabstop = tablength, --- Insert 2 spaces for a tab
    wrap = false, -- new line when characters go out of screen
    -- spell = true,
    expandtab = true, -- convert tabs to spaces
    shiftround = true, -- Round indent
    shiftwidth = tablength, -- indent when using >> or <<

    -- Search
    ignorecase = true, -- ignore case when searching
    incsearch = true, --- Start searching before pressing enter
    inccommand = "split",
    smartcase = true, -- smart case idk
    hlsearch = true, -- highlight all matches on previous search pattern

    -- Appearance
    number = true, -- show numbers on the left
    relativenumber = true, -- set relative numbered lines
    numberwidth = 2, -- set number column width {default 4}
    termguicolors = true, -- Enables 24-bit RGB color in the TUI
    colorcolumn = "80",
    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    cmdheight = 1, -- 0, --- Give more space for displaying messages
    scrolloff = 0, -- minimal number of columns to scroll horizontally.  was 8
    sidescrolloff = 8, -- minimal number of screen columns
    completeopt = { "menu,menuone,noselect" }, -- Better autocompletion

    -- Behavior
    hidden = true, -- required to keep multiple buffers and open multiple buffers
    mouse = "a", -- allow mouse to be used
    breakindent = true, -- keep indentation after wrap
    showbreak = "  ", -- characters that appear before wrapped new line
    --let &showbreak = '↳ '
    cpo = "n",
    pumheight = 10, -- pop up menu height
    pumblend = 10, -- transparency of pop-up menu
    splitbelow = true, -- force all horizontal splits to go below current window
    splitkeep = "screen",
    splitright = true, -- force all vertical splits to go to the right of current window
    timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)  was 500,
    updatetime = 200, -- faster completion (4000ms default)
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    cursorline = true, -- highlight the current line
    lazyredraw = false, -- Won't be redrawn while executing macros, register and other commands.
    fillchars = { eob = " ", fold = " ", foldopen = "", foldsep = " ", foldclose = "", lastline = " " }, -- make EndOfBuffer invisible
    ruler = false,
    autowrite = true, -- Automatically write/auto save
    confirm = true, -- Confirm to save changes before exiting modified buffer
    sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" }, -- buffers to save
    virtualedit = "block", -- Allow cursor to move where there is no text in visual block mode
    winminwidth = 5, -- Minimum window width
    clipboard = "unnamedplus", --- Copy-paste between vim and everything else
    foldcolumn = "0",
    foldnestmax = 0,
    foldlevel = 99, --- Using ufo provider need a large value
    foldlevelstart = 99, --- Expand all folds by default
    laststatus = 3, --- Have a global statusline at the bottom instead of one for each window
    showtabline = 2, --- Always show tabs
    viminfo = "'1000", --- Increase the size of file history

    -- Neovim defaults
    autoindent = true, --- Good auto indent
    backspace = "indent,eol,start", --- Making sure backspace works
    --- Concealed text is completely hidden unless it has a custom replacement character defined (needed for dynamically showing tailwind classes)
    conceallevel = 0, -- so that `` is visible in markdown files			-- 2,
    concealcursor = "", --- Set to an empty string to expand tailwind class when on cursorline
    encoding = "utf-8", --- The encoding displayed
    errorbells = false, --- Disables sound effect for errors
    fileencoding = "utf-8", --- The encoding written to file
    showmode = false, --- Don't show things like -- INSERT -- anymore

    --- unknown options
    formatoptions = "jcroqlnt", --- tcqj  for autoformat
    grepformat = "%f:%l:%c:%m",
    grepprg = "rg --vimgrep",
    showcmd = false,
    title = true,
    titlelen = 0, -- do not shorten title
    titlestring = "%{expand('%:t')}",

    -- Command-line completion mode
    -- wildmode = "longest:full,full",
    wildmode = "list:longest,list:full",
    wildmenu = true,

    -- Session management
    undofile = true, -- enable persistent undo
    undodir = os.getenv("HOME") .. "/.vim/undodir",
    swapfile = false, -- creates a swapfile
    backup = false,
}
vim.opt.fillchars:append({
    stl = " ",
})

local global = {
    mkdp_auto_close = false, -- Don't Exit Preview When Switching Buffers
    autoformat = true, -- Automatically format
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
