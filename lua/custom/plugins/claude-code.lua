-- Claude Code integration for Neovim
-- Local development version - points to standalone plugin
return {
  dir = '/Users/mistergrinvalds/Repos/personal/claude-code.nvim',
  name = 'claude-code',
  event = 'VeryLazy',
  dependencies = {
    'nvim-telescope/telescope.nvim', -- Optional: for command palette
  },
  config = function()
    require('claude-code').setup({
      window = {
        position = 'right', -- 'right', 'left', 'bottom', 'float'
        width = 0.4, -- 40% of screen width
        height = 0.3, -- 30% of screen height (for bottom)
      },
      keymaps = {
        toggle = '<leader>cc', -- Toggle Claude Code window
        send_file = '<leader>cf', -- Send current file
        send_selection = '<leader>cs', -- Send visual selection
        send_diagnostics = '<leader>cd', -- Send LSP diagnostics
        send_buffer = '<leader>cb', -- Send buffer with full context
        command_palette = '<leader>cp', -- Open command palette
        ask = '<leader>ca', -- Ask Claude
      },
      auto_scroll = true,
      close_on_exit = true,
      start_insert = false, -- Stay in normal mode, press 'i' to type
    })

    -- Add quick toggle with just <leader>c
    vim.keymap.set('n', '<leader>c', '<cmd>ClaudeToggle<cr>', { desc = '[C]laude Code Toggle' })
  end,
}
