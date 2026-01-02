-- Telescope picker for buffers (matching tab/tmux picker style)
local M = {}

--- Show buffer picker
function M.show()
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  local entry_display = require('telescope.pickers.entry_display')

  -- Get all valid buffers
  local buffers = {}
  local current_buf = vim.api.nvim_get_current_buf()

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    -- Only show listed, valid buffers
    if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].buflisted then
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      local filename = bufname ~= '' and vim.fn.fnamemodify(bufname, ':t') or '[No Name]'
      local modified = vim.bo[bufnr].modified

      table.insert(buffers, {
        bufnr = bufnr,
        name = filename,
        bufname = bufname,
        active = bufnr == current_buf,
        modified = modified,
      })
    end
  end

  if #buffers == 0 then
    vim.notify('No buffers open', vim.log.levels.INFO)
    return
  end

  -- Sort by buffer number for consistent ordering
  table.sort(buffers, function(a, b)
    return a.bufnr < b.bufnr
  end)

  local displayer = entry_display.create({
    separator = ' ',
    items = {
      { width = 4 },
      { remaining = true },
      { width = 3 },
    },
  })

  local make_display = function(entry)
    local modified_indicator = entry.modified and '+' or ' '
    return displayer({
      { '[' .. entry.bufnr .. ']', 'TelescopeResultsNumber' },
      { entry.name .. modified_indicator, 'TelescopeResultsIdentifier' },
      { entry.active and '●' or ' ', entry.active and 'TelescopeResultsFunction' or 'TelescopeResultsComment' },
    })
  end

  pickers
    .new({
      prompt_title = ' Buffers',
      finder = finders.new_table({
        results = buffers,
        entry_maker = function(entry)
          return {
            value = entry,
            display = make_display,
            ordinal = entry.name .. ' ' .. entry.bufnr,
            bufnr = entry.bufnr,
            name = entry.name,
            active = entry.active,
            modified = entry.modified,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        -- Default: goto buffer
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          if selection then
            vim.api.nvim_set_current_buf(selection.value.bufnr)
          end
        end)

        -- Ctrl-x: delete buffer
        map('i', '<c-x>', function()
          local selection = action_state.get_selected_entry()
          if selection then
            actions.close(prompt_bufnr)
            vim.cmd('bdelete ' .. selection.value.bufnr)
          end
        end)

        -- Ctrl-p: toggle pin buffer
        map('i', '<c-p>', function()
          local selection = action_state.get_selected_entry()
          if selection then
            vim.cmd('BufferLineTogglePin')
          end
        end)

        -- Ctrl-n: new buffer
        map('i', '<c-n>', function()
          actions.close(prompt_bufnr)
          vim.cmd('enew')
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
