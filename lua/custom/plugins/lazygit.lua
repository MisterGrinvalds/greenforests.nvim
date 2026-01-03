-- lazygit.nvim - Open lazygit in a floating terminal
-- Requires: lazygit to be installed (brew install lazygit)
local fork = require('lib.forks').fork

return {
  fork('kdheepak/lazygit.nvim'),
  cmd = { 'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile' },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'Open Lazy[G]it' },
    { '<leader>gf', '<cmd>LazyGitCurrentFile<cr>', desc = 'LazyGit current [F]ile history' },
  },
}
