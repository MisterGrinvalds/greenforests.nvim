-- Claude Code integration for Neovim
-- Multi-instance with lazygit-style floating window
return {
  dir = '/Users/mistergrinvalds/Repos/personal/claude-code.nvim',
  name = 'claude-code',
  lazy = false,
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

    -- UI controls: toggle/open/close/focus
    vim.keymap.set('n', '<leader>ct', function()
      require('claude-code').toggle()
    end, { desc = '[C]laude [T]oggle' })

    vim.keymap.set('n', '<leader>co', function()
      require('claude-code').show()
    end, { desc = '[C]laude [O]pen' })

    vim.keymap.set('n', '<leader>cc', function()
      require('claude-code').hide()
    end, { desc = '[C]laude [C]lose' })

    -- Shift+Enter for newline in terminal mode (Enter sends to Claude CLI)
    vim.keymap.set('t', '<S-CR>', '<C-v><CR>', { desc = 'Insert newline' })

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

    -- Focus Claude window
    vim.keymap.set('n', '<leader>cf', function()
      require('claude-code').focus()
    end, { desc = '[C]laude [F]ocus' })

    -- Context injection (send file in normal, selection in visual)
    vim.keymap.set('n', '<leader>cs', function()
      require('claude-code').send_file()
    end, { desc = '[C]laude [S]end file' })

    vim.keymap.set('v', '<leader>cs', function()
      require('claude-code').send_selection()
    end, { desc = '[C]laude [S]end selection' })

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

    vim.keymap.set('n', '<leader>cl', '<cmd>Claude float<cr>', { desc = '[C]laude f[L]oat' })

    -- Workspace cycling (Shift+Alt+[])
    -- Order: code → claude → terminal → code...
    local workspaces = { 'code', 'claude', 'terminal' }

    local function cycle_workspace(direction)
      local tab = require('claude-code').tab
      local current = tab.get_current_tab_type() or 'code'
      local current_idx = 1
      for i, ws in ipairs(workspaces) do
        if ws == current then
          current_idx = i
          break
        end
      end
      local next_idx = current_idx + direction
      if next_idx < 1 then next_idx = #workspaces end
      if next_idx > #workspaces then next_idx = 1 end
      tab.go_to_tab(workspaces[next_idx], true)
    end

    vim.keymap.set('n', '<S-A-[>', function()
      cycle_workspace(-1)
    end, { desc = 'Previous workspace' })

    vim.keymap.set('n', '<S-A-]>', function()
      cycle_workspace(1)
    end, { desc = 'Next workspace' })
  end,
}
