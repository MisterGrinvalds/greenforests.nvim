-- Acorn Session Management System
-- Bookmarks sessions with .acorn files for easy restoration
local M = {}

M.storage = require('custom.acorn.storage')
M.picker = require('custom.acorn.picker')
M.utils = require('custom.acorn.utils')

--- Pickle (save) current session with description
---@param description string|nil Optional description
function M.pickle(description)
  local prompt_and_save = function(desc)
    -- Save all files first
    vim.cmd('wa')

    local session_id = M.utils.generate_session_id()

    -- Save vim session
    if not M.storage.save_session(session_id) then
      return
    end

    -- Create .acorn metadata
    local acorn_data = {
      session_id = session_id,
      description = desc or '',
      branch = M.utils.get_git_branch(),
      last_modified = M.utils.iso_timestamp(),
      created = M.utils.iso_timestamp(),
    }

    if M.storage.write_acorn_file(acorn_data) then
      vim.notify('Pickled session: ' .. session_id, vim.log.levels.INFO)
    end
  end

  if description then
    prompt_and_save(description)
  else
    vim.ui.input({ prompt = 'Session description: ' }, function(input)
      if input then
        prompt_and_save(input)
      end
    end)
  end
end

--- Load session from .acorn file
function M.load()
  local acorn = M.storage.read_acorn_file()
  if not acorn then
    vim.notify('No .acorn file found in project root', vim.log.levels.WARN)
    return
  end

  if not M.storage.session_exists(acorn.session_id) then
    vim.notify('Session file not found: ' .. acorn.session_id, vim.log.levels.ERROR)
    return
  end

  if M.storage.load_session(acorn.session_id) then
    local desc = acorn.description ~= '' and acorn.description or 'unnamed'
    vim.notify('Loaded acorn session: ' .. desc, vim.log.levels.INFO)
  end
end

--- Check if .acorn file exists in current project
---@return boolean
function M.has_acorn()
  return M.storage.acorn_exists()
end

--- Update description for current .acorn
function M.update_description()
  local acorn = M.storage.read_acorn_file()
  if not acorn then
    vim.notify('No .acorn file found', vim.log.levels.WARN)
    return
  end

  vim.ui.input({
    prompt = 'Update description: ',
    default = acorn.description or '',
  }, function(input)
    if input then
      acorn.description = input
      acorn.last_modified = M.utils.iso_timestamp()
      if M.storage.write_acorn_file(acorn) then
        vim.notify('Description updated', vim.log.levels.INFO)
      end
    end
  end)
end

--- Delete current project's acorn session
function M.delete()
  local acorn = M.storage.read_acorn_file()
  if not acorn then
    vim.notify('No .acorn file found', vim.log.levels.WARN)
    return
  end

  vim.ui.select({ 'Yes', 'No' }, {
    prompt = 'Delete acorn session?',
  }, function(choice)
    if choice == 'Yes' then
      M.storage.delete_session(acorn.session_id)
      M.storage.delete_acorn_file()
      vim.notify('Deleted acorn session', vim.log.levels.INFO)
    end
  end)
end

--- Show acorn session picker
function M.show_picker()
  M.picker.show()
end

--- Quit without saving
function M.quit()
  vim.cmd('qa!')
end

--- Save all files and quit
function M.save_quit()
  vim.cmd('wa')
  vim.cmd('qa')
end

--- Pickle session and quit
function M.pickle_quit()
  local session_id = M.utils.generate_session_id()
  if M.storage.save_session(session_id) then
    local acorn_data = {
      session_id = session_id,
      description = 'Auto-saved on quit',
      branch = M.utils.get_git_branch(),
      last_modified = M.utils.iso_timestamp(),
      created = M.utils.iso_timestamp(),
    }
    M.storage.write_acorn_file(acorn_data)
    vim.notify('Pickled session: ' .. session_id, vim.log.levels.INFO)
  end
  vim.cmd('wa')
  vim.cmd('qa')
end

--- Setup acorn with keymaps and autocmds
---@param opts table|nil
function M.setup(opts)
  opts = opts or {}

  -- Create keymaps
  local map = vim.keymap.set
  local prefix = opts.prefix or '<leader>a'

  map('n', prefix .. 'p', M.pickle, { desc = '[A]corn: [P]ickle session' })
  map('n', prefix .. 'l', M.load, { desc = '[A]corn: [L]oad session' })
  map('n', prefix .. 'a', M.show_picker, { desc = '[A]corn: Show [A]ll sessions' })
  map('n', prefix .. 'u', M.update_description, { desc = '[A]corn: [U]pdate description' })
  map('n', prefix .. 'd', M.delete, { desc = '[A]corn: [D]elete session' })
  map('n', prefix .. 'q', M.quit, { desc = '[A]corn: [Q]uit (no save)' })
  map('n', prefix .. 's', M.save_quit, { desc = '[A]corn: [S]ave and quit' })
  map('n', prefix .. 'x', M.pickle_quit, { desc = '[A]corn: Pickle and e[X]it' })

  -- Create VimEnter autocmd for auto-prompt
  if opts.auto_prompt ~= false then
    vim.api.nvim_create_autocmd('VimEnter', {
      group = vim.api.nvim_create_augroup('acorn-auto-prompt', { clear = true }),
      callback = function()
        -- Defer to allow other plugins to initialize
        vim.defer_fn(function()
          if M.has_acorn() then
            local acorn = M.storage.read_acorn_file()
            if acorn then
              local desc = acorn.description ~= '' and acorn.description or 'unnamed'
              vim.ui.select({ 'Yes', 'No' }, {
                prompt = string.format('Load acorn session? (%s)', desc),
              }, function(choice)
                if choice == 'Yes' then
                  M.load()
                end
              end)
            end
          end
        end, 100)
      end,
    })
  end

  -- Create user commands
  vim.api.nvim_create_user_command('AcornPickle', function(cmd)
    M.pickle(cmd.args ~= '' and cmd.args or nil)
  end, { nargs = '?', desc = 'Pickle (save) current session' })

  vim.api.nvim_create_user_command('AcornLoad', M.load, { desc = 'Load session from .acorn' })
  vim.api.nvim_create_user_command('AcornPicker', M.show_picker, { desc = 'Show acorn session picker' })
  vim.api.nvim_create_user_command('AcornUpdate', M.update_description, { desc = 'Update session description' })
  vim.api.nvim_create_user_command('AcornDelete', M.delete, { desc = 'Delete current acorn session' })
end

return M
