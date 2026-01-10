-- Diagnostics - trouble.nvim
local fork = require('lib.forks').fork

return {
  fork('folke/trouble.nvim'),
  name = 'trouble.nvim',
  cmd = 'Trouble',
  opts = {},
  keys = {
    { '<leader>xt', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics [T]oggle' },
    { '<leader>xo', '<cmd>Trouble diagnostics open<cr>', desc = 'Diagnostics [O]pen' },
    { '<leader>xc', '<cmd>Trouble diagnostics close<cr>', desc = 'Diagnostics [C]lose' },
    { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics' },
    { '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = '[S]ymbols' },
    { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = '[L]ocation List' },
    { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = '[Q]uickfix List' },
  },
}
