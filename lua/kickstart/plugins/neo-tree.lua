-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
local fork = require('lib.forks').fork

return {
  fork('nvim-neo-tree/neo-tree.nvim'),
  name = 'neo-tree.nvim',
  version = '*',
  dependencies = {
    fork('nvim-lua/plenary.nvim'),
    fork('nvim-tree/nvim-web-devicons'), -- not strictly required, but recommended
    fork('MunifTanjim/nui.nvim'),
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>e', ':Neotree toggle<CR>', desc = 'File [E]xplorer', silent = true },
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,  -- Show hidden files by default
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          '.DS_Store',
          'thumbs.db',
        },
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['H'] = 'toggle_hidden',  -- Toggle hidden files with H
        },
      },
    },
  },
}
