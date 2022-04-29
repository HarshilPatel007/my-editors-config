-- :help options

-- ----------------
-- general settings
-- ----------------

vim.opt.number = true                       -- set numbered lines
vim.opt.relativenumber = false				-- set relative numbered lines
vim.opt.cursorline = true                   -- highlight the current line
vim.opt.wrap = false                        -- display lines as one long line
vim.opt.expandtab = true                    -- convert tabs to spaces
vim.opt.shiftwidth = 4                      -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4                         -- insert 4 spaces for a tab
vim.opt.mouse = "a"                         -- allow the mouse to be used in neovim
vim.opt.smartcase = true                    -- smart case
vim.opt.smartindent = true                  -- make indenting smarter again
vim.opt.clipboard = "unnamedplus"           -- allows neovim to access the system clipboard
vim.opt.fileencoding = "utf-8"              -- the encoding written to a file
vim.opt.hlsearch = true                     -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                   -- ignore case in search patterns
vim.opt.showtabline = 2                     -- always show tabs
vim.opt.termguicolors = true                -- set term gui colors
vim.opt.laststatus = 3                      -- set the global statusline and remove statusline on each windows
vim.opt.timeoutlen = 200                    -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.updatetime = 300                    -- faster completion
vim.opt.scrolloff = 8                       -- minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8                   -- minimal number of screen lines to keep left and right of the cursor
vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd "set iskeyword+=-"
