-- Claude Code integration for Neovim
-- Multi-instance with lazygit-style floating window
return {
  dir = '/Users/mistergrinvalds/Repos/personal/claude-code.nvim',
  name = 'claude-code',
  event = 'VeryLazy',
  dependencies = {
    'nvim-telescope/telescope.nvim', -- For session picker
  },
  config = function()
    require('claude-code').setup({
      window = {
        width = 0.9, -- 90% of screen (lazygit-style)
        height = 0.9,
        border = 'rounded',
      },
      command = 'claude',
      default_session = 'main', -- Auto-created on first <leader>cc
    })

    -- Main toggle (auto-creates "main" or uses last session)
    vim.keymap.set('n', '<leader>cc', function()
      require('claude-code').toggle()
    end, { desc = '[C]laude [C]ode toggle' })

    -- Quick toggle alias
    vim.keymap.set('n', '<leader>c', function()
      require('claude-code').toggle()
    end, { desc = '[C]laude Code' })

    -- Session picker
    vim.keymap.set('n', '<leader>cp', function()
      require('claude-code').picker()
    end, { desc = '[C]laude [P]icker' })

    -- New session
    vim.keymap.set('n', '<leader>cn', function()
      require('claude-code').new_session()
    end, { desc = '[C]laude [N]ew session' })

    -- Context injection
    vim.keymap.set('n', '<leader>cf', function()
      require('claude-code').send_file()
    end, { desc = '[C]laude: Send [F]ile' })

    vim.keymap.set('v', '<leader>cs', function()
      require('claude-code').send_selection()
    end, { desc = '[C]laude: Send [S]election' })

    vim.keymap.set('n', '<leader>cd', function()
      require('claude-code').send_diagnostics()
    end, { desc = '[C]laude: Send [D]iagnostics' })

    -- Ask with custom prompt
    vim.keymap.set('n', '<leader>ca', function()
      require('claude-code').ask()
    end, { desc = '[C]laude: [A]sk' })
  end,
}
