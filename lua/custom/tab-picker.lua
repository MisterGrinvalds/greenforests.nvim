-- Telescope picker for Vim tabs
local M = {}

--- Create a previewer that shows the tab's active buffer content
local function tab_previewer()
  local previewers = require('telescope.previewers')
  local putils = require('telescope.previewers.utils')

  return previewers.new_buffer_previewer({
    title = 'Buffer Preview',
    define_preview = function(self, entry, status)
      local tabnr = entry.value.tabnr
      local buflist = vim.fn.tabpagebuflist(tabnr)
      local winnr = vim.fn.tabpagewinnr(tabnr)
      local bufnr = buflist[winnr]

      -- Get buffer content
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 100, false)

      if #lines == 0 then
        lines = { '[Empty buffer]' }
      end

      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)

      -- Try to apply syntax highlighting based on the buffer's filetype
      local ft = vim.bo[bufnr].filetype
      if ft and ft ~= '' then
        putils.highlighter(self.state.bufnr, ft)
      end
    end,
  })
end

--- Show tab picker
function M.show()
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  local entry_display = require('telescope.pickers.entry_display')

  -- Get all tabs
  local tabs = {}
  local tabpages = vim.api.nvim_list_tabpages()
  local current_tabpage = vim.api.nvim_get_current_tabpage()

  for i, tabpage in ipairs(tabpages) do
    local tabnr = i
    local buflist = vim.fn.tabpagebuflist(tabnr)
    local winnr = vim.fn.tabpagewinnr(tabnr)
    local bufnr = buflist[winnr]
    local bufname = vim.fn.bufname(bufnr)

    -- Get BufferLine tab name if set, otherwise use filename
    local ok, bufferline_name = pcall(vim.api.nvim_tabpage_get_var, tabpage, 'bufferline_tab_name')
    local name = ok and bufferline_name or (bufname ~= '' and vim.fn.fnamemodify(bufname, ':t') or '[No Name]')

    table.insert(tabs, {
      tabnr = tabnr,
      tabpage = tabpage,
      bufnr = bufnr,
      name = name,
      bufname = bufname,
      active = tabpage == current_tabpage,
    })
  end

  if #tabs == 0 then
    vim.notify('No tabs open', vim.log.levels.INFO)
    return
  end

  local displayer = entry_display.create({
    separator = ' ',
    items = {
      { width = 3 },   -- Tab number
      { width = 20 },  -- Tab name
      { width = 8 },   -- Status
      { remaining = true },  -- Path
    },
  })

  local make_display = function(entry)
    local status = entry.active and '' or ''
    local idx = tostring(entry.tabnr)
    local path = entry.bufname ~= '' and vim.fn.fnamemodify(entry.bufname, ':~:.') or ''

    return displayer({
      { idx, 'TelescopeResultsNumber' },
      { entry.name, 'TelescopeResultsIdentifier' },
      { status, entry.active and 'TelescopeResultsFunction' or 'TelescopeResultsComment' },
      { path, 'TelescopeResultsLineNr' },
    })
  end

  pickers
    .new({
      prompt_title = '󰓩 Tabs',
      results_title = 'Tabs',
      preview_title = 'Buffer Content',
      finder = finders.new_table({
        results = tabs,
        entry_maker = function(entry)
          return {
            value = entry,
            display = make_display,
            ordinal = entry.name .. ' ' .. entry.tabnr .. ' ' .. entry.bufname,
            tabnr = entry.tabnr,
            name = entry.name,
            active = entry.active,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      previewer = tab_previewer(),
      layout_strategy = 'horizontal',
      layout_config = {
        horizontal = {
          preview_width = 0.6,
          width = 0.8,
          height = 0.8,
        },
      },
      attach_mappings = function(prompt_bufnr, map)
        -- Default: goto tab
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          if selection then
            vim.cmd('tabnext ' .. selection.value.tabnr)
          end
        end)

        -- Ctrl-x: delete tab
        map('i', '<c-x>', function()
          local selection = action_state.get_selected_entry()
          if selection and #tabs > 1 then
            vim.cmd('tabclose ' .. selection.value.tabnr)
            actions.close(prompt_bufnr)
            M.show()
          else
            vim.notify("Can't delete last tab", vim.log.levels.WARN)
          end
        end)

        -- Ctrl-n: new tab
        map('i', '<c-n>', function()
          actions.close(prompt_bufnr)
          vim.ui.input({ prompt = 'Tab name: ' }, function(name)
            if name and name ~= '' then
              vim.cmd('tabnew')
              local tabpage = vim.api.nvim_get_current_tabpage()
              vim.api.nvim_tabpage_set_var(tabpage, 'bufferline_tab_name', name)
            else
              vim.cmd('tabnew')
            end
          end)
        end)

        -- Ctrl-r: rename tab
        map('i', '<c-r>', function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          if selection then
            vim.ui.input({ prompt = 'Tab name: ', default = selection.value.name }, function(name)
              if name and name ~= '' then
                vim.api.nvim_tabpage_set_var(selection.value.tabpage, 'bufferline_tab_name', name)
                vim.notify('Tab renamed to: ' .. name, vim.log.levels.INFO)
              end
            end)
          end
        end)

        return true
      end,
    })
    :find()
end

return M
