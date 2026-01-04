-- Core keymaps (non-plugin)
-- See :help vim.keymap.set()

-- Clear search highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Quick save
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = '[W]rite/Save file' })

-- Move lines up/down
vim.keymap.set('n', '<A-j>', '<cmd>m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', '<cmd>m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })

-- Diagnostics
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Terminal mode exit
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- NOTE: Split navigation handled by smart-splits plugin (Ctrl+hjkl)

-- Mouse back/forward buttons for jump list navigation
-- Works with mice that have side buttons (typically buttons 4/5)
vim.keymap.set('n', '<X1Mouse>', '<C-o>', { desc = 'Jump back (mouse)' })
vim.keymap.set('n', '<X2Mouse>', '<C-i>', { desc = 'Jump forward (mouse)' })
