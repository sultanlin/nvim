local keymap = vim.keymap.set
------------------------
-- Term Mode
------------------------
local opts = { silent = true }
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)

------------------------
-- Insert Mode
------------------------
opts = { noremap = true, silent = true }
-- Move current line / block with Alt-j/k ala vscode.
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
-- navigation
keymap("i", "<A-Up>", "<C-\\><C-N><C-w>k", opts)
keymap("i", "<A-Down>", "<C-\\><C-N><C-w>j", opts)
keymap("i", "<A-Left>", "<C-\\><C-N><C-w>h", opts)
keymap("i", "<A-Right>", "<C-\\><C-N><C-w>l", opts)

------------------------
-- Normal Mode
------------------------
-- Better window movement
opts.desc = "Go to Left Window"
keymap("n", "<C-h>", "<C-w>h", opts)
opts.desc = "Go to Lower Window"
keymap("n", "<C-j>", "<C-w>j", opts)
opts.desc = "Go to Upper Window"
keymap("n", "<C-k>", "<C-w>k", opts)
opts.desc = "Go to Right Window"
keymap("n", "<C-l>", "<C-w>l", opts)
-- Center after scrolling down or up
keymap("n", "J", "mzJ`z", opts) -- TODO: Does it even work?
-- -- Center after searching (next and previous)
-- keymap("n", "n", "nzzzv", opts)
-- keymap("n", "N", "Nzzzv", opts)
-- Resize window with arrows
opts.desc = "Increase Window Height"
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
opts.desc = "Decrease Window Height"
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
-- Move current line / block with Alt-j/k ala vscode.
opts.desc = ""
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
-- QuickFix TODO: Check conflict/if I need it
keymap("n", "]q", ":cnext<CR>", opts)
keymap("n", "[q", ":cprev<CR>", opts)
keymap("n", "<C-q>", ":call QuickFixToggle()<CR>", opts)
-- Increment/Decrement
keymap("n", "+", "<C-a>", opts)
keymap("n", "-", "<C-x>", opts)
-- Select all
keymap("n", "<C-a>", "ggVG", opts)
keymap("n", "Q", "<nop>", opts) -- ??
-- BUG: Jiggery/Jittery/Flickery
-- Buggy when scrolling from top or bottom of screen
-- Center after scrolling down or up
-- keymap("n", "<C-d>", "<C-d>zz", opts) -- ??
-- keymap("n", "<C-u>", "<C-u>zz", opts) -- ??

-- buffers
opts.desc = "Prev Buffer"
keymap("n", "<S-h>", "<cmd>bprevious<cr>", opts)
keymap("n", "[b", "<cmd>bprevious<cr>", opts)
opts.desc = "Next Buffer"
keymap("n", "<S-l>", "<cmd>bnext<cr>", opts)
keymap("n", "]b", "<cmd>bnext<cr>", opts)

------------------------
-- Visual Mode
------------------------
-- Better indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
-- keymap("v", "p", '"0p', opts) -- ??
-- keymap("v", "P", '"0P', opts) -- ??

------------------------
-- Visual block Mode
------------------------
-- Move current line / block with Alt-j/k ala vscode.
-- keymap("x", "<A-j>", ":m '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":m '<-2<CR>gv-gv", opts)
keymap("x", "J", ":m '>+1<CR>gv-gv", opts)
keymap("x", "K", ":m '<-2<CR>gv-gv", opts)

------------------------
-- Command Mode
------------------------
-- navigate tab completion with <c-j> and <c-k> -- runs conditionally
opts.expr = true
keymap("c", "<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', opts)
keymap("c", "<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', opts)

------------------------
-- Operator Pending Mode ("o")
------------------------

------------------------
-- Extras
------------------------
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
keymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
keymap({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
keymap({ "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
keymap("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
keymap({ "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Save file
keymap({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
-- vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<ESC>:update<CR>", opts)

--keywordprg
keymap("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- tabs
keymap("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
keymap("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
keymap("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
keymap("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
keymap("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
keymap("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
keymap("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
-- { "<leader>a", group = "Tab" },
-- -- { "<leader><tab>", group = "Tab" },
-- { "<leader>aN", "<cmd>$tabnew<cr>", desc = "New Empty Tab" },
-- { "<leader>aa", "<cmd>tabnext<cr>", desc = "Goto next tab" },
-- { "<leader>ah", "<cmd>-tabmove<cr>", desc = "Move Left" },
-- { "<leader>al", "<cmd>+tabmove<cr>", desc = "Move Right" },
-- { "<leader>an", "<cmd>tabnew %<cr>", desc = "New Tab" },
-- { "<leader>ao", "<cmd>tabonly<cr>", desc = "Only" },

-- -- Some more convenient keymaps for split management
keymap("n", "<leader>wv", "<C-w>v", { desc = "Window split vertically" })
keymap("n", "<leader>w<Bslash>", "<C-w>v", { desc = "Window split vertically" })
keymap("n", "<leader>w|", "<C-w>v", { desc = "Window split vertically" })
keymap("n", "<leader>wh", "<C-w>s", { desc = "Window split horizontally" })
keymap("n", "<leader>w-", "<C-w>s", { desc = "Window split horizontally" })
keymap("n", "<leader>we", "<C-w>=", { desc = "Make Window splits equal size" })
keymap("n", "<leader>w=", "<C-w>=", { desc = "Make Window splits equal size" })
keymap("n", "<leader>wq", "<cmd>close<CR>", { desc = "Quit window" })
keymap("n", "<leader>wo", "<C-w>o", { desc = "Close other windows" })
keymap("n", "<leader>wm", "<C-w>o", { desc = "Maximize" })
keymap("n", "<leader>wH", "<C-w>H", { desc = "Move window left" })
keymap("n", "<leader>wL", "<C-w>L", { desc = "Move window right" })
keymap("n", "<leader>wJ", "<C-w>J", { desc = "Move window down" })
keymap("n", "<leader>wK", "<C-w>K", { desc = "Move window up" })

-- Quickly go to the start/end of the line while in insert mode.
keymap("i", "<C-a>", "<C-o>I", { desc = "Go to the start of the line" })
keymap("i", "<C-e>", "<C-o>A", { desc = "Go to the end of the line" })
