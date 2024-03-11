local tablength = 4
local options = {

    -- Editing ====================================================================
    -- formatoptions = "jcroqlnt", --- tcqj  for autoformat
    formatoptions = "rqnl1j", -- Improve comment editing
    infercase = true, -- Infer letter cases for a richer built-in keyword completion
    virtualedit = "block", -- Allow cursor to move where there is no text in visual block mode
    -- Tab/Indentation
    autoindent = true, --- Good auto indent
    expandtab = true, -- convert tabs to spaces
    tabstop = tablength, -- number of spaces when you tab
    smartindent = true, -- make indenting smarter again
    smarttab = true, --- Makes tabbing smarter will realize you have 2 vs 4
    softtabstop = tablength, --- Spaces per tab
    shiftround = true, -- Round indent
    shiftwidth = tablength, -- indent when using >> or <<

    -- Search
    ignorecase = true, -- ignore case when searching
    incsearch = true, --- Start searching before pressing enter
    inccommand = "split",
    smartcase = true, -- smart case idk
    hlsearch = true, -- highlight all matches on previous search pattern

    -- Spelling ===================================================================
    -- spell = true,
    spelllang = "en,uk", -- Define spelling dictionaries
    spelloptions = "camel", -- Treat parts of camelCase words as seprate words
    -- complete:append('kspell'), -- Add spellcheck options for autocomplete
    -- complete:remove('t'),      -- Don't use tags for completion
    -- dictionary = vim.fn.stdpath("config") .. "/misc/dict/english.txt", -- Use specific dictionaries

    -- UI =========================================================================

    breakindent = true, -- Indent wrapped lines to match line start
    colorcolumn = "+1", -- Draw colored column one step to the right of desired maximum width
    cursorline = true, -- Enable highlighting of the current line    -- WARN: Potentially laggy
    -- laststatus = 2, -- Always show statusline
    -- linebreak = true, -- Wrap long lines at 'breakat' (if 'wrap' is set)
    -- list = true, -- Show helpful character indicators    ( BREAKS GOLANG INDENT)
    pumblend = 10, -- Make builtin completion menus slightly transparent
    pumheight = 10, -- Make popup menu smaller
    ruler = false, -- Don't show cursor position
    shortmess = "aoOWFcSC", -- Disable certain messages from |ins-completion-menu|
    -- shortmess     = 'aoOWFcS' ,-- Disable certain messages from |ins-completion-menu|
    showmode = false, -- Don't show vim mode in command line
    -- showtabline = 2, -- Always show tabline
    signcolumn = "yes", -- Always show signcolumn or it would frequently shift
    splitbelow = true, -- Horizontal splits will be below
    splitright = true, -- Vertical splits will be to the right
    termguicolors = true, -- Enables 24-bit RGB color in the TUI
    wrap = false, -- Display long lines as just one line

    -- fillchars = table.concat({
    --     "eob: ",
    --     "fold:╌",
    --     "horiz:═",
    --     "horizdown:╦",
    --     "horizup:╩",
    --     "vert:║",
    --     "verthoriz:╬",
    --     "vertleft:╣",
    --     "vertright:╠",
    --     "stl: ",
    -- }, ","),
    -- fillchars = { eob = " ", fold = " ", foldopen = "", foldsep = " ", foldclose = "", lastline = " " }, -- make EndOfBuffer invisible
    fillchars = table.concat({
        eob = " ",
        fold = " ",
        foldopen = "",
        foldsep = " ",
        foldclose = "",
        lastline = " ",
        stl = " ",
    }), -- make EndOfBuffer invisible
    -- listchars = table.concat({ "extends:…", "nbsp:␣", "precedes:…", "tab:> " }, ","),
    -- listchars = table.concat({ "extends:…", "nbsp:␣", "precedes:…" }, ","),
    -- Appearance
    number = true, -- show numbers on the left
    relativenumber = true, -- set relative numbered lines
    numberwidth = 2, -- set number column width {default 4}
    -- colorcolumn = "80",
    cmdheight = 1, -- 0, --- Give more space for displaying messages
    -- scrolloff = 0, -- minimal number of columns to scroll horizontally.  was 8
    scrolloff = 8, -- minimal number of columns to scroll horizontally.
    sidescrolloff = 8, -- minimal number of screen columns
    completeopt = { "menu,menuone,noselect" }, -- Better autocompletion

    -- Behavior
    hidden = true, -- required to keep multiple buffers and open multiple buffers
    mouse = "a", -- allow mouse to be used
    -- breakindent = true, -- keep indentation after wrap
    showbreak = "  ", -- characters that appear before wrapped new line
    --let &showbreak = '↳ '
    cpo = "n",
    splitkeep = "screen",
    timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)  was 500,
    updatetime = 200, -- faster completion (4000ms default)
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    lazyredraw = false, -- Won't be redrawn while executing macros, register and other commands.
    autowrite = true, -- Automatically write/auto save
    confirm = true, -- Confirm to save changes before exiting modified buffer
    sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" }, -- buffers to save
    winminwidth = 5, -- Minimum window width
    clipboard = "unnamedplus", --- Copy-paste between vim and everything else
    foldcolumn = "0",
    foldnestmax = 0,
    laststatus = 3, --- Have a global statusline at the bottom instead of one for each window
    viminfo = "'1000", --- Increase the size of file history

    -- Neovim defaults
    backspace = "indent,eol,start", --- Making sure backspace works
    --- Concealed text is completely hidden unless it has a custom replacement character defined (needed for dynamically showing tailwind classes)
    conceallevel = 0, -- so that `` is visible in markdown files			-- 2,
    concealcursor = "", --- Set to an empty string to expand tailwind class when on cursorline
    encoding = "utf-8", --- The encoding displayed
    errorbells = false, --- Disables sound effect for errors
    fileencoding = "utf-8", --- The encoding written to file

    --- unknown options
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

    -- Folds ======================================================================
    -- foldmethod = "indent", -- Set 'indent' folding method
    -- foldlevel   = 1,        -- Display all folds except top ones
    -- foldnestmax = 10,       -- Create folds only for some number of nested levels
    foldlevel = 99, --- Using ufo provider need a large value
    foldlevelstart = 99, --- Expand all folds by default
    -- markdown_folding = 1,   -- Use folding by heading in markdown files
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
