local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- ("mode", "new keymap", "old keymap", "options")
-- remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",



--------------
-- Normal Mode
--------------

-- window navigation
keymap("n", "<A-Left>", "<C-w>h", opts) 
keymap("n", "<A-Down>", "<C-w>j", opts)
keymap("n", "<A-Up>", "<C-w>k", opts)
keymap("n", "<A-Right>", "<C-w>l", opts)

-- resize window with arrows
keymap("n", "<C-Up>", ":resize +2<cr>", opts)
keymap("n", "<C-Down>", ":resize -2<cr>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<cr>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<cr>", opts)

-- netrw directory listing
keymap("n", "<leader>e", ":Lex 20<cr>", opts) -- :Lexplore with 20 width '<cr> means Enter'

-- move text up and down
keymap("n", "<A-Down>", ":m .+1<cr>==", opts)
keymap("n", "<A-Up>", ":m .-2<cr>==", opts)

-- indentation
keymap("n", "<S-Tab>", "<<", opts)
keymap("n", "<Tab>", ">>", opts)

-- Telescope plugin
keymap("n", "<leader>f", "<cmd>:Telescope find_files<cr>", opts)

---------------------
-- End of Normal Mode
---------------------


--------------
-- Visual Mode
--------------

-- stay in indent mode
keymap("v", "<S-Tab>", "<<", opts)
keymap("v", "<Tab>", ">>", opts)

keymap("v", "<S-Tab>", "<gv", opts)
keymap("v", "<Tab>", ">gv", opts)

-- move text up and down
keymap("v", "<A-Down>", ":m '>+1<cr>gv=gv", opts)
keymap("v", "<A-Up>", ":m '<-2<cr>gv=gv", opts)
keymap("v", "p", '"_dP', opts)

---------------------
-- End of Visual Mode
---------------------


--------------------
-- Visual Block Mode
--------------------

-- move text up and down
keymap("x", "<A-Down>", ":m '>+1<cr>gv=gv", opts)
keymap("x", "<A-Up>", ":m '<-2<cr>gv=gv", opts)

---------------------------
-- End of Visual Block Mode
---------------------------
