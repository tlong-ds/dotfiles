-- ==============================================================================
-- Basic, Zero-Dependency Neovim Configuration
-- Fast, clean, and distraction-free.
-- ==============================================================================

-- 1. Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 2. Line Numbers & UI
vim.opt.number = true               -- Show line numbers
vim.opt.relativenumber = true       -- Show relative line numbers
vim.opt.cursorline = true           -- Highlight the current line
vim.opt.signcolumn = "yes"          -- Always show the sign column
vim.opt.termguicolors = true        -- True 24-bit color support
vim.opt.scrolloff = 8               -- Keep 8 lines of context when scrolling
vim.opt.sidescrolloff = 8           -- Keep 8 columns of context horizontally
vim.opt.showmode = false            -- Mode is already visible in statusline
vim.opt.wrap = false                -- Don't wrap long lines by default

-- 3. Tabs & Indentation
vim.opt.tabstop = 4                 -- Number of spaces that a <Tab> counts for
vim.opt.softtabstop = 4             -- Number of spaces for editing operations
vim.opt.shiftwidth = 4              -- Size of an indent
vim.opt.expandtab = true            -- Use spaces instead of tabs
vim.opt.smartindent = true          -- Auto-indent new lines

-- 4. Search Settings
vim.opt.ignorecase = true           -- Case-insensitive search
vim.opt.smartcase = true            -- Case-sensitive if search contains capitals
vim.opt.hlsearch = true             -- Highlight search results
vim.opt.incsearch = true            -- Incremental search

-- 5. System & Undo
vim.opt.clipboard = "unnamedplus"   -- Sync with macOS system clipboard
vim.opt.undofile = true             -- Save undo history across sessions
vim.opt.swapfile = false            -- Don't use swap files
vim.opt.backup = false              -- Don't use backup files
vim.opt.updatetime = 250            -- Faster completion & response time
vim.opt.timeoutlen = 300            -- Time to wait for mapped sequence
vim.opt.mouse = "a"                 -- Enable mouse support

-- 6. Splits
vim.opt.splitright = true           -- Put new horizontal splits to right
vim.opt.splitbelow = true           -- Put new vertical splits below

-- 7. Colorscheme
pcall(vim.cmd.colorscheme, "habamax") -- Built-in modern clean colorscheme

-- ==============================================================================
-- Keymaps
-- ==============================================================================
local keymap = vim.keymap.set

-- Clear search highlights on pressing Esc in normal mode
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Quick Save & Quit
keymap("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit window" })

-- Split Navigation (Ctrl + h/j/k/l)
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to lower split" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to upper split" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- Move selected text up/down in Visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Center cursor when jumping half-page
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll down & center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll up & center" })

-- Keep search matches centered
keymap("n", "n", "nzzzv", { desc = "Next search match & center" })
keymap("n", "N", "Nzzzv", { desc = "Prev search match & center" })

-- ==============================================================================
-- Autocommands
-- ==============================================================================
-- Highlight on yank (briefly flash copied text)
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ timeout = 150 })
    end,
})
