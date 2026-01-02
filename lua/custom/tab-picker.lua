-- Telescope picker for Vim tabs (similar to tmux window picker)
local M = {}

--- Show tab picker
function M.show()
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  local entry_display = require('telescope.pickers.entry_display')

  -- Get all tabs using tabpage handles (compatible with all Neovim versions)
  local tabs = {}
  local tabpages = vim.api.nvim_list_tabpages()
  local current_tabpage = vim.api.nvim_get_current_tabpage()

  for i, tabpage in ipairs(tabpages) do
    -- Get tab info
    local tabnr = i
    local buflist = vim.fn.tabpagebuflist(tabnr)
    local winnr = vim.fn.tabpagewinnr(tabnr)
    local bufnr = buflist[winnr]
    local bufname = vim.fn.bufname(bufnr)

    -- Get BufferLine tab name if set, otherwise use filename
    -- This syncs with BufferLineTabRename command
    local ok, bufferline_name = pcall(vim.api.nvim_tabpage_get_var, tabpage, 'bufferline_tab_name')
    local name = ok and bufferline_name or (bufname ~= '' and vim.fn.fnamemodify(bufname, ':t') or '[No Name]')

    table.insert(tabs, {
      tabnr = tabnr,
      tabpage = tabpage,
      name = name,
      bufname = bufname,
      active = tabpage == current_tabpage,
      has_custom_name = ok,
    })
  end

  if #tabs == 0 then
    vim.notify('No tabs open', vim.log.levels.INFO)
    return
  end

  local displayer = entry_display.create({
    separator = ' ',
    items = {
      { width = 4 },
      { remaining = true },
      { width = 3 },
    },
  })

  local make_display = function(entry)
    return displayer({
      { '[' .. entry.tabnr .. ']', 'TelescopeResultsNumber' },
      { entry.name, 'TelescopeResultsIdentifier' },
      { entry.active and '●' or ' ', entry.active and 'TelescopeResultsFunction' or 'TelescopeResultsComment' },
    })
  end

  pickers
    .new({
      prompt_title = ' Tabs',
      finder = finders.new_table({
        results = tabs,
        entry_maker = function(entry)
          return {
            value = entry,
            display = make_display,
            ordinal = entry.name .. ' ' .. entry.tabnr,
            tabnr = entry.tabnr,
            name = entry.name,
            active = entry.active,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
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
            -- Refresh picker
            actions.close(prompt_bufnr)
            M.show()
          else
            vim.notify("Can't delete last tab", vim.log.levels.WARN)
          end
        end)

        -- Ctrl-n: new tab
        map('i', '<c-n>', function()
          actions.close(prompt_bufnr)
          vim.cmd('tabnew')
        end)

        -- Ctrl-r: rename tab
        map('i', '<c-r>', function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          if selection then
            local current_name = selection.value.name
            vim.ui.input({ prompt = 'Tab name: ', default = current_name }, function(name)
              if name and name ~= '' then
                -- Use BufferLine's tab naming system for consistency
                -- This syncs with :BufferLineTabRename command
                vim.api.nvim_tabpage_set_var(selection.value.tabpage, 'bufferline_tab_name', name)
                vim.notify('Tab renamed to: ' .. name, vim.log.levels.INFO)
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
