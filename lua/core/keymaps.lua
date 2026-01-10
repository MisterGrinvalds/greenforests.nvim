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

-- Terminal management with toggle/open/close
local term_buf = nil

local function terminal_open()
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    -- Reuse existing terminal buffer
    vim.cmd('botright split')
    vim.api.nvim_win_set_buf(0, term_buf)
  else
    -- Create new terminal
    vim.cmd('botright split | terminal')
    term_buf = vim.api.nvim_get_current_buf()
  end
  vim.cmd('startinsert')
end

local function terminal_close()
  if term_buf then
    local wins = vim.fn.win_findbuf(term_buf)
    for _, win in ipairs(wins) do
      vim.api.nvim_win_close(win, true)
    end
  end
end

local function terminal_toggle()
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    local wins = vim.fn.win_findbuf(term_buf)
    if #wins > 0 then
      -- Terminal visible, close it
      terminal_close()
      return
    end
  end
  -- Terminal not visible, open it
  terminal_open()
end

vim.keymap.set('n', '<leader>tt', terminal_toggle, { desc = '[T]erminal [T]oggle' })
vim.keymap.set('n', '<leader>to', terminal_open, { desc = '[T]erminal [O]pen' })
vim.keymap.set('n', '<leader>tc', terminal_close, { desc = '[T]erminal [C]lose' })

-- NOTE: Split navigation handled by smart-splits plugin (Ctrl+hjkl)

-- Mouse back/forward buttons for jump list navigation
-- Works with mice that have side buttons (typically buttons 4/5)
vim.keymap.set('n', '<X1Mouse>', '<C-o>', { desc = 'Jump back (mouse)' })
vim.keymap.set('n', '<X2Mouse>', '<C-i>', { desc = 'Jump forward (mouse)' })
