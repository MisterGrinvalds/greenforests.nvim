-- Core Neovim options
-- See :help vim.o and :help option-list

-- Leader key (must be set before plugins load)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Nerd Font detection
vim.g.have_nerd_font = true

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Mouse
vim.o.mouse = 'a'

-- Mode display (handled by statusline)
vim.o.showmode = false

-- Clipboard (sync with OS)
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Indentation
vim.o.breakindent = true

-- Undo persistence
vim.o.undofile = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- UI
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 200
vim.o.cursorline = true
vim.o.winbar = '%=%m %f'
vim.o.scrolloff = 10

-- Splits
vim.o.splitright = true
vim.o.splitbelow = true

-- Whitespace display
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Live substitution preview
vim.o.inccommand = 'split'

-- Confirmation dialogs
vim.o.confirm = true

-- Auto-reload files changed externally
vim.o.autoread = true
