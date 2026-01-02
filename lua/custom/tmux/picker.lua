-- Telescope picker for tmux windows
local M = {}

--- Show tmux window picker
function M.show()
  local tmux = require('custom.tmux')

  if not tmux.is_tmux() then
    vim.notify('Not running inside tmux', vim.log.levels.ERROR)
    return
  end

  local windows = tmux.window.list()

  if #windows == 0 then
    vim.notify('No tmux windows found', vim.log.levels.WARN)
    return
  end

  -- Convert to telescope entries
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  local entry_display = require('telescope.pickers.entry_display')

  local displayer = entry_display.create({
    separator = ' ',
    items = {
      { width = 25 },  -- Window name
      { width = 10 },  -- Status
      { width = 15 },  -- Window index
      { remaining = true },  -- Description
    },
  })

  local make_display = function(entry)
    local status = entry.active and 'active' or 'background'
    local win_info = 'window ' .. entry.index
    local description = 'tmux window'

    return displayer({
      { entry.name, 'TelescopeResultsIdentifier' },
      { status, entry.active and 'TelescopeResultsFunction' or 'TelescopeResultsComment' },
      { win_info, 'TelescopeResultsSpecialComment' },
      { description, 'TelescopeResultsLineNr' },
    })
  end

  pickers
    .new({
      prompt_title = ' tmux Windows',
      finder = finders.new_table({
        results = windows,
        entry_maker = function(entry)
          return {
            value = entry,
            display = make_display,
            ordinal = entry.name .. ' ' .. entry.index,
            index = entry.index,
            name = entry.name,
            active = entry.active,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        -- Default: goto window
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          if selection then
            tmux.window.goto(selection.value.index)
          end
        end)

        -- Ctrl-x: delete window
        map('i', '<c-x>', function()
          local selection = action_state.get_selected_entry()
          if selection and #windows > 1 then
            actions.close(prompt_bufnr)
            tmux.window.delete(selection.value.index)
          else
            vim.notify("Can't delete last window", vim.log.levels.WARN)
          end
        end)

        -- Ctrl-r: rename window
        map('i', '<c-r>', function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          if selection then
            vim.ui.input({ prompt = 'New name: ', default = selection.value.name }, function(name)
              if name and name ~= '' then
                tmux.window.goto(selection.value.index)
                tmux.window.rename(name)
              end
            end)
          end
        end)

        return true
      end,
    }, require('telescope.themes').get_dropdown({
      previewer = false,
      layout_config = {
        width = 0.6,
        height = 0.5,
      },
    }))
    :find()
end

return M
