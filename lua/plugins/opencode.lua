-- OpenCode integration for Neovim
-- Multi-instance OpenCode sessions with workspace management
return {
  dir = '/Users/mistergrinvalds/Repos/personal/opencode.nvim',
  name = 'opencode',
  lazy = false,
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('opencode').setup {
      window = {
        mode = 'tab',
        border = 'rounded',
      },
      tabs = {
        enabled = true,
        show_tabline = false, -- Using bufferline
      },
      command = 'opencode',
      default_session = 'main',
      default_agent = 'build',
    }

    -- UI controls: toggle/open/close/focus
    vim.keymap.set('n', '<leader>oo', function()
      require('opencode').toggle()
    end, { desc = '[O]penCode T[o]ggle' })

    vim.keymap.set('n', '<leader>oO', function()
      require('opencode').show()
    end, { desc = '[O]penCode [O]pen' })

    vim.keymap.set('n', '<leader>oq', function()
      require('opencode').hide()
    end, { desc = '[O]penCode [Q]uit/close' })

    vim.keymap.set('n', '<leader>of', function()
      require('opencode').focus()
    end, { desc = '[O]penCode [F]ocus' })

    -- Session management
    vim.keymap.set('n', '<leader>op', function()
      require('opencode').picker()
    end, { desc = '[O]penCode [P]icker' })

    vim.keymap.set('n', '<leader>on', function()
      require('opencode').new_session()
    end, { desc = '[O]penCode [N]ew session' })

    vim.keymap.set('n', '<leader>ox', function()
      require('opencode').delete_session()
    end, { desc = '[O]penCode delete/e[X]it session' })

    -- Context injection
    vim.keymap.set('n', '<leader>os', function()
      require('opencode').send_file()
    end, { desc = '[O]penCode [S]end file' })

    vim.keymap.set('v', '<leader>os', function()
      require('opencode').send_selection()
    end, { desc = '[O]penCode [S]end selection' })

    vim.keymap.set('n', '<leader>od', function()
      require('opencode').send_diagnostics()
    end, { desc = '[O]penCode Send [D]iagnostics' })

    vim.keymap.set('n', '<leader>oa', function()
      require('opencode').ask()
    end, { desc = '[O]penCode [A]sk' })

    vim.keymap.set({ 'n', 'v' }, '<leader>or', function()
      require('opencode').pick_and_replace()
    end, { desc = '[O]penCode [R]eplace with code' })

    -- Agent switching
    vim.keymap.set('n', '<leader>ob', function()
      require('opencode').switch_agent 'build'
    end, { desc = '[O]penCode [B]uild agent' })

    vim.keymap.set('n', '<leader>ol', function()
      require('opencode').switch_agent 'plan'
    end, { desc = '[O]penCode P[l]an agent' })

    -- OpenCode commands
    vim.keymap.set('n', '<leader>ou', function()
      require('opencode').run_command 'undo'
    end, { desc = '[O]penCode [U]ndo' })

    vim.keymap.set('n', '<leader>oR', function()
      require('opencode').run_command 'redo'
    end, { desc = '[O]penCode [R]edo' })

    vim.keymap.set('n', '<leader>oi', function()
      require('opencode').run_command 'init'
    end, { desc = '[O]penCode [I]nit' })

    vim.keymap.set('n', '<leader>om', function()
      require('opencode').run_command 'models'
    end, { desc = '[O]penCode [M]odels' })

    -- Terminal workspace
    vim.keymap.set('n', '<leader>ot', function()
      require('opencode').toggle_terminal()
    end, { desc = '[O]penCode [T]erminal' })
  end,
}
