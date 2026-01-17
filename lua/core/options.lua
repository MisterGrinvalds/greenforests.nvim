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

-- Indentation defaults (filetypes override via autocmd)
vim.o.expandtab = true    -- Use spaces instead of tabs
vim.o.shiftwidth = 2      -- Default indent size
vim.o.tabstop = 2         -- Tab display width
vim.o.softtabstop = 2     -- Backspace deletes indent
vim.o.smartindent = true  -- Smart auto-indenting
vim.o.breakindent = true  -- Preserve indent on wrapped lines

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
vim.opt.listchars = {
  tab = '→ ',
  trail = '·',
  nbsp = '␣',
  extends = '⟩',
  precedes = '⟨',
}

-- Live substitution preview
vim.o.inccommand = 'split'

-- Confirmation dialogs
vim.o.confirm = true

-- Auto-reload files changed externally
vim.o.autoread = true

-- Treesitter-based folding
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldenable = false -- Don't fold by default
vim.o.foldlevel = 99
