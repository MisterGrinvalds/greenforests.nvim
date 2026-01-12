-- Editing plugins - mini, comment, autopairs, todo-comments, guess-indent
local fork = require('lib.forks').fork

return {
  -- Guess indent
  fork('NMAC427/guess-indent.nvim'),

  -- Mini.nvim collection
  {
    fork('echasnovski/mini.nvim'),
    config = function()
      -- Better Around/Inside textobjects
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings
      require('mini.surround').setup()
    end,
  },

  -- Comment.nvim
  {
    fork('numToStr/Comment.nvim'),
    name = 'Comment.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- Autopairs
  {
    fork('windwp/nvim-autopairs'),
    name = 'nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  -- Todo comments
  {
    fork('folke/todo-comments.nvim'),
    name = 'todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  -- Multi-cursor editing (like VS Code Cmd+D)
  -- https://github.com/mg979/vim-visual-multi
  {
    fork('mg979/vim-visual-multi'),
    branch = 'master',
    event = 'VeryLazy',
    init = function()
      vim.g.VM_maps = {
        ['Find Under'] = '<C-n>',         -- Select word under cursor, repeat for next
        ['Find Subword Under'] = '<C-n>', -- Also works on partial words
        ['Select All'] = '<C-S-l>',       -- Select all occurrences
        ['Add Cursor Down'] = '<C-Down>', -- Add cursor below
        ['Add Cursor Up'] = '<C-Up>',     -- Add cursor above
      }
    end,
  },
}
