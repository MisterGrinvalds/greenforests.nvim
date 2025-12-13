-- Command Palette - VS Code-style command palette with context awareness
return {
  dir = '/Users/mistergrinvalds/Repos/personal/command-palette.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('command-palette').setup({
      -- Use dropdown theme for clean look
      telescope_opts = {
        theme = 'dropdown',
        previewer = false,
        layout_config = {
          width = 0.8,
          height = 0.6,
        },
      },

      -- Enable context filtering
      enable_context_filtering = true,
    })

    -- Set up keybindings
    vim.keymap.set('n', '<leader>p', '<cmd>CommandPalette<cr>', { desc = 'Command [P]alette' })
    vim.keymap.set('n', '<leader>sp', '<cmd>CommandPalette<cr>', { desc = '[S]earch [P]alette' })

    -- VS Code-style (Ctrl+Shift+P) - uncomment if you want this
    -- vim.keymap.set('n', '<C-S-p>', '<cmd>CommandPalette<cr>', { desc = 'Command Palette' })
  end,
}
