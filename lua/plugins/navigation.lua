-- Navigation plugins - harpoon, neo-tree, smart-splits
local fork = require('lib.forks').fork

return {
  -- Harpoon - Quick file marks
  {
    fork 'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = false,
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end, { desc = 'Harpoon: [A]dd file' })

      vim.keymap.set('n', '<leader>m', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Harpoon: [M]arks menu' })

      vim.keymap.set('n', '<leader>1', function()
        harpoon:list():select(1)
      end, { desc = 'Harpoon: File [1]' })
      vim.keymap.set('n', '<leader>2', function()
        harpoon:list():select(2)
      end, { desc = 'Harpoon: File [2]' })
      vim.keymap.set('n', '<leader>3', function()
        harpoon:list():select(3)
      end, { desc = 'Harpoon: File [3]' })
      vim.keymap.set('n', '<leader>4', function()
        harpoon:list():select(4)
      end, { desc = 'Harpoon: File [4]' })
    end,
  },

  -- Neo-tree - File explorer
  {
    fork 'nvim-neo-tree/neo-tree.nvim',
    name = 'neo-tree.nvim',
    version = '*',
    dependencies = {
      fork 'nvim-lua/plenary.nvim',
      fork 'nvim-tree/nvim-web-devicons',
      fork 'MunifTanjim/nui.nvim',
    },
    lazy = false,
    keys = {
      { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
      { '<leader>et', ':Neotree toggle<CR>', desc = '[E]xplorer [T]oggle', silent = true },
      { '<leader>eo', ':Neotree focus<CR>', desc = '[E]xplorer [O]pen', silent = true },
      { '<leader>ec', ':Neotree close<CR>', desc = '[E]xplorer [C]lose', silent = true },
      { '<leader>ef', ':Neotree focus<CR>', desc = '[E]xplorer [F]ocus', silent = true },
    },
    config = function(_, opts)
      -- Set up <Esc><Esc> to close NeoTree when focused
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'neo-tree',
        callback = function()
          vim.keymap.set('n', '<Esc><Esc>', ':Neotree close<CR>', { buffer = true, silent = true, desc = 'Close NeoTree' })
        end,
      })
      require('neo-tree').setup(opts)
    end,
    opts = {
      window = {
        mappings = {
          -- Disable Space so global <leader> keymaps work in NeoTree
          ['<Space>'] = {
            'toggle_node',
            nowait = false,
          },
          ['P'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = true } },
          ['l'] = 'focus_preview',
          ['<C-f>'] = { 'scroll_preview', config = { direction = -10 } },
          ['<C-b>'] = { 'scroll_preview', config = { direction = 10 } },
          -- Arrow key navigation
          ['<Left>'] = 'close_node',
          ['<Right>'] = 'open',
        },
      },
      use_popups_for_input = false,
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = { '.DS_Store', 'thumbs.db' },
        },
        window = {
          mappings = {
            ['\\'] = 'close_window',
            ['H'] = 'toggle_hidden',
          },
        },
      },
    },
  },

  -- Smart-splits - Seamless split/tmux navigation
  {
    fork 'mrjones2014/smart-splits.nvim',
    lazy = false,
    config = function()
      require('smart-splits').setup {
        ignored_filetypes = { 'nofile', 'quickfix', 'prompt' },
        ignored_buftypes = { 'NvimTree' },
        default_amount = 3,
        move_cursor_same_row = false,
        at_edge = 'stop',
      }

      -- Navigation (Shift+hjkl)
      vim.keymap.set('n', '<S-h>', require('smart-splits').move_cursor_left, { desc = 'Move to left split' })
      vim.keymap.set('n', '<S-j>', require('smart-splits').move_cursor_down, { desc = 'Move to below split' })
      vim.keymap.set('n', '<S-k>', require('smart-splits').move_cursor_up, { desc = 'Move to above split' })
      vim.keymap.set('n', '<S-l>', require('smart-splits').move_cursor_right, { desc = 'Move to right split' })

      -- Arrow alternatives
      vim.keymap.set('n', '<S-Left>', require('smart-splits').move_cursor_left, { desc = 'Move to left split' })
      vim.keymap.set('n', '<S-Down>', require('smart-splits').move_cursor_down, { desc = 'Move to below split' })
      vim.keymap.set('n', '<S-Up>', require('smart-splits').move_cursor_up, { desc = 'Move to above split' })
      vim.keymap.set('n', '<S-Right>', require('smart-splits').move_cursor_right, { desc = 'Move to right split' })

      -- Resizing (Shift+Alt+hjkl)
      vim.keymap.set('n', '<S-A-h>', require('smart-splits').resize_left, { desc = 'Resize split left' })
      vim.keymap.set('n', '<S-A-j>', require('smart-splits').resize_down, { desc = 'Resize split down' })
      vim.keymap.set('n', '<S-A-k>', require('smart-splits').resize_up, { desc = 'Resize split up' })
      vim.keymap.set('n', '<S-A-l>', require('smart-splits').resize_right, { desc = 'Resize split right' })

      -- Arrow alternatives for resizing
      vim.keymap.set('n', '<S-A-Left>', require('smart-splits').resize_left, { desc = 'Resize split left' })
      vim.keymap.set('n', '<S-A-Down>', require('smart-splits').resize_down, { desc = 'Resize split down' })
      vim.keymap.set('n', '<S-A-Up>', require('smart-splits').resize_up, { desc = 'Resize split up' })
      vim.keymap.set('n', '<S-A-Right>', require('smart-splits').resize_right, { desc = 'Resize split right' })

      -- Swapping buffers
      vim.keymap.set('n', '<leader>wh', require('smart-splits').swap_buf_left, { desc = 'Swap buffer left' })
      vim.keymap.set('n', '<leader>wj', require('smart-splits').swap_buf_down, { desc = 'Swap buffer down' })
      vim.keymap.set('n', '<leader>wk', require('smart-splits').swap_buf_up, { desc = 'Swap buffer up' })
      vim.keymap.set('n', '<leader>wl', require('smart-splits').swap_buf_right, { desc = 'Swap buffer right' })
    end,
  },
}
