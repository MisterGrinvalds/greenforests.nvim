-- tmux integration for Neovim
-- Provides keyboard-first control of tmux from within Neovim
return {
  dir = '/Users/mistergrinvalds/Repos/personal/kickstart.nvim/lua/custom/tmux',
  name = 'tmux-wrapper',
  lazy = false,
  config = function()
    local tmux = require('custom.tmux')

    -- Only set up keybindings if inside tmux
    if not tmux.is_tmux() then
      vim.notify('tmux integration available but not inside tmux session', vim.log.levels.INFO)
      return
    end

    -- Window picker
    vim.keymap.set('n', '<leader>tw', function()
      require('custom.tmux.picker').show()
    end, { desc = '[T]mux [W]indow picker' })

    -- Create new window
    vim.keymap.set('n', '<leader>tn', function()
      vim.ui.input({ prompt = 'Window name: ' }, function(name)
        if name and name ~= '' then
          tmux.window.create(name)
          tmux.window.goto(name)
        end
      end)
    end, { desc = '[T]mux [N]ew window' })

    -- Rename current window
    vim.keymap.set('n', '<leader>tr', function()
      local current = tmux.utils.current_window_name()
      vim.ui.input({ prompt = 'New window name: ', default = current }, function(name)
        if name and name ~= '' then
          tmux.window.rename(name)
        end
      end)
    end, { desc = '[T]mux [R]ename window' })

    -- Delete current window
    vim.keymap.set('n', '<leader>tx', function()
      local current = tmux.utils.current_window()
      tmux.window.delete(current)
    end, { desc = '[T]mux window [X] delete' })

    -- Window navigation (Neovim shortcuts for tmux commands)
    vim.keymap.set('n', '<leader>tl', function()
      tmux.window.next()
    end, { desc = '[T]mux window next ([L])' })

    vim.keymap.set('n', '<leader>th', function()
      tmux.window.previous()
    end, { desc = '[T]mux window previous ([H])' })

    -- Pane management
    vim.keymap.set('n', '<leader>tm', '<cmd>silent !tmux resize-pane -Z<cr>', {
      desc = '[T]mux pane [M]aximize toggle',
    })

    vim.keymap.set('n', '<leader>t|', '<cmd>silent !tmux split-window -h<cr>', {
      desc = '[T]mux split vertical',
    })

    vim.keymap.set('n', '<leader>t-', '<cmd>silent !tmux split-window -v<cr>', {
      desc = '[T]mux split horizontal',
    })

    -- Quick access to common windows (creates if doesn't exist)
    vim.keymap.set('n', '<leader>tg', function()
      tmux.goto('git')
    end, { desc = '[T]mux [G]it window' })

    vim.keymap.set('n', '<leader>td', function()
      tmux.goto('dev')
    end, { desc = '[T]mux [D]ev window' })

    vim.keymap.set('n', '<leader>tt', function()
      tmux.goto('test')
    end, { desc = '[T]mux [T]est window' })

    -- Send visual selection to current window
    vim.keymap.set('v', '<leader>ts', function()
      local start_pos = vim.fn.getpos("'<")
      local end_pos = vim.fn.getpos("'>")
      local lines = vim.fn.getline(start_pos[2], end_pos[2])
      local command = table.concat(lines, '\n')
      tmux.send(nil, command, true) -- nil = current window
    end, { desc = '[T]mux [S]end selection' })
  end,
}
