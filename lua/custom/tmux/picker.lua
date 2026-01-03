-- Telescope picker for tmux windows
local M = {}

--- Create a previewer that shows tmux window content
local function tmux_previewer()
  local previewers = require('telescope.previewers')
  local putils = require('telescope.previewers.utils')

  return previewers.new_buffer_previewer({
    title = 'Window Preview',
    define_preview = function(self, entry, status)
      -- Capture the pane content from the tmux window
      local cmd = string.format('tmux capture-pane -t :%s -p -S -50', entry.value.index)
      local handle = io.popen(cmd)
      if not handle then
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, { 'Failed to capture pane' })
        return
      end

      local content = handle:read('*a')
      handle:close()

      local lines = vim.split(content, '\n', { trimempty = false })

      -- Set buffer content
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)

      -- Try to detect filetype for syntax highlighting
      putils.highlighter(self.state.bufnr, 'bash')
    end,
  })
end

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

  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  local entry_display = require('telescope.pickers.entry_display')

  local displayer = entry_display.create({
    separator = ' ',
    items = {
      { width = 3 },   -- Window index
      { width = 20 },  -- Window name
      { width = 8 },   -- Status
    },
  })

  local make_display = function(entry)
    local status = entry.active and '' or ''
    local idx = tostring(entry.index)

    return displayer({
      { idx, 'TelescopeResultsNumber' },
      { entry.name, 'TelescopeResultsIdentifier' },
      { status, entry.active and 'TelescopeResultsFunction' or 'TelescopeResultsComment' },
    })
  end

  pickers
    .new({
      prompt_title = ' tmux Windows',
      results_title = 'Windows',
      preview_title = 'Pane Content',
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
      previewer = tmux_previewer(),
      layout_strategy = 'horizontal',
      layout_config = {
        horizontal = {
          preview_width = 0.6,
          width = 0.8,
          height = 0.8,
        },
      },
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

        -- Ctrl-n: new window
        map('i', '<c-n>', function()
          actions.close(prompt_bufnr)
          vim.ui.input({ prompt = 'Window name: ' }, function(name)
            if name and name ~= '' then
              tmux.window.create(name)
              tmux.window.goto(name)
            end
          end)
        end)

        return true
      end,
    })
    :find()
end

return M
