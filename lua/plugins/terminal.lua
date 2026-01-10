-- Terminal - tmux integration
return {
  dir = vim.fn.stdpath 'config' .. '/lua/custom/tmux',
  name = 'tmux-wrapper',
  lazy = false,
  config = function()
    local tmux = require('custom.tmux')

    if not tmux.is_tmux() then
      return
    end

    -- Window picker
    vim.keymap.set('n', '<leader>tp', function()
      require('custom.tmux.picker').show()
    end, { desc = '[T]mux [P]icker' })

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

    -- Window navigation
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

    -- Create window with command (moved from tc to tw to free tc for terminal close)
    vim.keymap.set('n', '<leader>tw', function()
      vim.ui.input({ prompt = 'Window name: ' }, function(name)
        if not name or name == '' then
          return
        end
        vim.ui.input({ prompt = 'Command to run (or Enter for shell): ' }, function(command)
          tmux.window.create(name)
          tmux.window.goto(name)
          if command and command ~= '' then
            tmux.window.send_command(name, command, true)
          end
        end)
      end)
    end, { desc = '[T]mux [W]indow with command' })

    -- Send visual selection
    vim.keymap.set('v', '<leader>ts', function()
      local start_pos = vim.fn.getpos("'<")
      local end_pos = vim.fn.getpos("'>")
      local lines = vim.fn.getline(start_pos[2], end_pos[2])
      local command = table.concat(lines, '\n')
      tmux.send(nil, command, true)
    end, { desc = '[T]mux [S]end selection' })
  end,
}
