-- persistence.nvim - Automated session management
-- https://github.com/folke/persistence.nvim
local fork = require('lib.forks').fork

return {
  fork('folke/persistence.nvim'),
  event = 'BufReadPre',
  opts = {
    dir = vim.fn.stdpath('state') .. '/sessions/',
    need = 1, -- minimum buffers to save session
    branch = true, -- use git branch for session organization
  },
  keys = {
    {
      '<leader>qs',
      function()
        require('persistence').load()
      end,
      desc = '[Q]uit/Session: Load current directory session',
    },
    {
      '<leader>qS',
      function()
        require('persistence').select()
      end,
      desc = '[Q]uit/Session: [S]elect session',
    },
    {
      '<leader>ql',
      function()
        require('persistence').load({ last = true })
      end,
      desc = '[Q]uit/Session: Load [L]ast session',
    },
    {
      '<leader>qd',
      function()
        require('persistence').stop()
      end,
      desc = '[Q]uit/Session: [D]on\'t save current session',
    },
  },
}
