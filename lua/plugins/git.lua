-- Git plugins - gitsigns, lazygit, diffview
local fork = require('lib.forks').fork

return {
  -- Gitsigns - Git change indicators in gutter
  {
    fork('lewis6991/gitsigns.nvim'),
    name = 'gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- Lazygit - Terminal UI for git
  {
    fork('kdheepak/lazygit.nvim'),
    cmd = { 'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'Open Lazy[G]it' },
      { '<leader>gf', '<cmd>LazyGitCurrentFile<cr>', desc = 'LazyGit current [F]ile history' },
    },
  },

  -- Diffview - Advanced git diff viewer
  {
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
  },
}
