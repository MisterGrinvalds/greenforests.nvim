-- Acorn session Telescope picker
local M = {}

local utils = require('custom.acorn.utils')
local storage = require('custom.acorn.storage')

--- Create a previewer that shows session metadata
local function session_previewer()
  local previewers = require('telescope.previewers')

  return previewers.new_buffer_previewer({
    title = 'Session Info',
    define_preview = function(self, entry, status)
      local session = entry.value
      local lines = {
        '  Acorn Session',
        '',
        '  ID:       ' .. session.session_id,
        '  Created:  ' .. utils.format_timestamp(session.session_id),
        '  Modified: ' .. utils.format_timestamp(session.mtime),
        '  Size:     ' .. string.format('%.1f KB', session.size / 1024),
        '',
        '  Path:',
        '  ' .. session.path,
        '',
        '  Keybindings:',
        '  <CR>    Load session',
        '  <C-x>   Delete session',
        '  <C-q>   Quit Neovim (no save)',
        '  <C-w>   Save files and quit',
        '  <C-p>   Pickle session and quit',
      }

      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
      vim.bo[self.state.bufnr].filetype = 'markdown'
    end,
  })
end

--- Show acorn session picker
function M.show()
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  local entry_display = require('telescope.pickers.entry_display')

  local sessions = storage.list_sessions()

  if #sessions == 0 then
    vim.notify('No acorn sessions found', vim.log.levels.INFO)
    return
  end

  local displayer = entry_display.create({
    separator = ' ',
    items = {
      { width = 12 }, -- Session ID
      { width = 18 }, -- Created
      { width = 18 }, -- Modified
      { width = 10 }, -- Size
      { remaining = true }, -- Path
    },
  })

  local make_display = function(entry)
    local session = entry.value
    local created = utils.format_timestamp(session.session_id)
    local modified = utils.format_timestamp(session.mtime)
    local size = string.format('%.1f KB', session.size / 1024)

    return displayer({
      { session.session_id, 'TelescopeResultsNumber' },
      { created, 'TelescopeResultsIdentifier' },
      { modified, 'TelescopeResultsFunction' },
      { size, 'TelescopeResultsComment' },
      { session.path, 'TelescopeResultsLineNr' },
    })
  end

  pickers
    .new({
      prompt_title = ' Acorn Sessions',
      results_title = 'Sessions',
      preview_title = 'Session Info',
      finder = finders.new_table({
        results = sessions,
        entry_maker = function(entry)
          return {
            value = entry,
            display = make_display,
            ordinal = entry.session_id .. ' ' .. entry.path,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      previewer = session_previewer(),
      layout_strategy = 'horizontal',
      layout_config = {
        horizontal = {
          preview_width = 0.4,
          width = 0.8,
          height = 0.6,
        },
      },
      attach_mappings = function(prompt_bufnr, map)
        -- Default: load session
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          if selection then
            storage.load_session(selection.value.session_id)
            vim.notify('Loaded acorn session: ' .. selection.value.session_id, vim.log.levels.INFO)
          end
        end)

        -- Ctrl-x: delete session
        map('i', '<c-x>', function()
          local selection = action_state.get_selected_entry()
          if selection then
            vim.ui.select({ 'Yes', 'No' }, {
              prompt = 'Delete session ' .. selection.value.session_id .. '?',
            }, function(choice)
              if choice == 'Yes' then
                storage.delete_session(selection.value.session_id)
                vim.notify('Deleted session: ' .. selection.value.session_id, vim.log.levels.INFO)
                actions.close(prompt_bufnr)
                -- Refresh picker
                vim.defer_fn(M.show, 100)
              end
            end)
          end
        end)

        map('n', '<c-x>', function()
          local selection = action_state.get_selected_entry()
          if selection then
            vim.ui.select({ 'Yes', 'No' }, {
              prompt = 'Delete session ' .. selection.value.session_id .. '?',
            }, function(choice)
              if choice == 'Yes' then
                storage.delete_session(selection.value.session_id)
                vim.notify('Deleted session: ' .. selection.value.session_id, vim.log.levels.INFO)
                actions.close(prompt_bufnr)
                vim.defer_fn(M.show, 100)
              end
            end)
          end
        end)

        -- Ctrl-q: quit without saving
        local quit_no_save = function()
          actions.close(prompt_bufnr)
          vim.cmd('qa!')
        end
        map('i', '<c-q>', quit_no_save)
        map('n', '<c-q>', quit_no_save)

        -- Ctrl-w: save and quit
        local save_and_quit = function()
          actions.close(prompt_bufnr)
          vim.cmd('wa')
          vim.cmd('qa')
        end
        map('i', '<c-w>', save_and_quit)
        map('n', '<c-w>', save_and_quit)

        -- Ctrl-p: pickle session and quit
        local pickle_and_quit = function()
          actions.close(prompt_bufnr)
          -- Pickle with auto-generated description, then quit
          local session_id = utils.generate_session_id()
          if storage.save_session(session_id) then
            local acorn_data = {
              session_id = session_id,
              description = 'Auto-saved on quit',
              branch = utils.get_git_branch(),
              last_modified = utils.iso_timestamp(),
              created = utils.iso_timestamp(),
            }
            storage.write_acorn_file(acorn_data)
            vim.notify('Pickled session: ' .. session_id, vim.log.levels.INFO)
          end
          vim.cmd('wa')
          vim.cmd('qa')
        end
        map('i', '<c-p>', pickle_and_quit)
        map('n', '<c-p>', pickle_and_quit)

        return true
      end,
    })
    :find()
end

return M
