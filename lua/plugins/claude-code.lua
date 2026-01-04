-- Claude Code integration for Neovim
-- Multi-instance with lazygit-style floating window
return {
  dir = '/Users/mistergrinvalds/Repos/personal/claude-code.nvim',
  name = 'claude-code',
  event = 'VeryLazy',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('claude-code').setup {
      window = {
        width = 0.9,
        height = 0.9,
        border = 'rounded',
      },
      command = 'claude',
      default_session = 'main',
    }

    -- Main toggle
    vim.keymap.set('n', '<leader>cc', function()
      require('claude-code').toggle()
    end, { desc = '[C]laude [C]ode toggle' })

    vim.keymap.set('n', '<leader>c', function()
      require('claude-code').toggle()
    end, { desc = '[C]laude Code' })

    -- Session management
    vim.keymap.set('n', '<leader>cp', function()
      require('claude-code').picker()
    end, { desc = '[C]laude [P]icker' })

    vim.keymap.set('n', '<leader>cn', function()
      require('claude-code').new_session()
    end, { desc = '[C]laude [N]ew session' })

    vim.keymap.set('n', '<leader>cx', function()
      require('claude-code').delete_session()
    end, { desc = '[C]laude delete/e[X]it session' })

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

    vim.keymap.set('n', '<leader>ca', function()
      require('claude-code').ask()
    end, { desc = '[C]laude: [A]sk' })

    vim.keymap.set({ 'n', 'v' }, '<leader>cr', function()
      require('claude-code').pick_and_replace()
    end, { desc = '[C]laude: [R]eplace with code' })

    vim.keymap.set('n', '<leader>cb', function()
      require('claude-code').sync.force_refresh()
    end, { desc = '[C]laude: Refresh [B]uffers' })
  end,
}
