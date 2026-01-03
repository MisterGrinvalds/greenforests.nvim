-- diffview.nvim - Advanced git diff viewer
-- Single tabpage interface for cycling through diffs
local fork = require('lib.forks').fork

return {
  fork('sindrets/diffview.nvim'),
  name = 'diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  opts = {},
  keys = {
    { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Open [D]iffview' },
    { '<leader>gx', '<cmd>DiffviewClose<cr>', desc = 'Close Diffview' },
    { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'File [H]istory' },
    { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = 'Branch [H]istory' },
  },
}
