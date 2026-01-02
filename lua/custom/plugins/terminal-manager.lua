-- Terminal Manager - Multiple persistent terminal sessions
return {
  dir = '/Users/mistergrinvalds/Repos/personal/terminal-manager.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('terminal-manager').setup({
      -- Window configuration
      window = {
        position = 'bottom', -- 'float', 'right', 'left', 'bottom'
        border = 'rounded',

        float = {
          width = 0.8,
          height = 0.8,
        },

        split = {
          width = 0.4,
          height = 0.3,
        },
      },

      -- Auto-create default terminals (optional)
      default_sessions = {
        -- { name = 'dev' },
        -- { name = 'git' },
      },

      -- Telescope picker theme
      picker_opts = {
        theme = 'dropdown',
        previewer = false,
        layout_config = {
          width = 0.8,
          height = 0.6,
        },
      },

      start_insert = true,
    })

    -- Set up keybindings
    vim.keymap.set('n', '<leader>t', '<cmd>TerminalPicker<cr>', { desc = '[T]erminal Picker' })
    vim.keymap.set('n', '<leader>tt', '<cmd>TerminalTogglePane<cr>', { desc = '[T]erminal [T]oggle Pane' })
    vim.keymap.set('n', '<leader>tn', '<cmd>TerminalNew<cr>', { desc = '[T]erminal [N]ew' })
    vim.keymap.set('n', '<leader>tm', '<cmd>TerminalToggleMaximize<cr>', { desc = '[T]erminal [M]aximize Toggle' })
    vim.keymap.set('n', '<leader>th', '<cmd>TerminalHidePane<cr>', { desc = '[T]erminal [H]ide Pane' })

    -- Quick access to common terminals
    vim.keymap.set('n', '<leader>tg', function()
      require('terminal-manager').toggle('git')
    end, { desc = '[T]erminal [G]it' })

    vim.keymap.set('n', '<leader>td', function()
      require('terminal-manager').toggle('dev')
    end, { desc = '[T]erminal [D]ev' })
  end,
}
