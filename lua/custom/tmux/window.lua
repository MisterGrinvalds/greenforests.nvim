-- Window (tab) management functions for tmux
local M = {}
local utils = require('custom.tmux.utils')

--- Create a new tmux window
---@param name string Window name
---@param opts table|nil Options (cwd)
---@return boolean success
function M.create(name, opts)
  opts = opts or {}
  local args = { 'new-window' }

  if name then
    table.insert(args, '-n')
    table.insert(args, vim.fn.shellescape(name))
  end

  if opts.cwd then
    table.insert(args, '-c')
    table.insert(args, vim.fn.shellescape(opts.cwd))
  end

  local result, err = utils.exec(args)
  if err then
    vim.notify('Failed to create window: ' .. err, vim.log.levels.ERROR)
    return false
  end

  return true
end

--- Switch to window by name or index
---@param name_or_index string|number
---@return boolean success
function M.goto(name_or_index)
  local target = utils.format_target(name_or_index)
  local result, err = utils.exec({ 'select-window', '-t', target })

  if err then
    vim.notify('Failed to switch window: ' .. err, vim.log.levels.ERROR)
    return false
  end

  return true
end

--- Create window if it doesn't exist, then switch to it
---@param name string Window name
---@param opts table|nil Options
---@return boolean success
function M.goto_or_create(name, opts)
  if utils.window_exists(name) then
    return M.goto(name)
  else
    if M.create(name, opts) then
      return M.goto(name)
    end
    return false
  end
end

--- Delete window by name or index
---@param name_or_index string|number
---@return boolean success
function M.delete(name_or_index)
  local target = utils.format_target(name_or_index)

  -- Confirm before deleting
  local confirm = vim.fn.confirm('Delete tmux window "' .. tostring(name_or_index) .. '"?', '&Yes\n&No', 2)
  if confirm ~= 1 then
    return false
  end

  local result, err = utils.exec({ 'kill-window', '-t', target })
  if err then
    vim.notify('Failed to delete window: ' .. err, vim.log.levels.ERROR)
    return false
  end

  return true
end

--- Rename current window
---@param new_name string New window name
---@return boolean success
function M.rename(new_name)
  local result, err = utils.exec({ 'rename-window', vim.fn.shellescape(new_name) })
  if err then
    vim.notify('Failed to rename window: ' .. err, vim.log.levels.ERROR)
    return false
  end

  return true
end

--- List all windows
---@return table[] List of window objects
function M.list()
  local result = utils.exec({ 'list-windows', '-F', '#{window_index}:#{window_name}:#{window_active}' })
  if not result then
    return {}
  end

  local windows = {}
  for line in result:gmatch('[^\n]+') do
    local index, name, active = line:match('(%d+):([^:]*):([01])')
    if index then
      table.insert(windows, {
        index = tonumber(index),
        name = name ~= '' and name or 'window-' .. index,
        active = active == '1',
      })
    end
  end

  return windows
end

--- Send command to a window's pane
---@param name_or_index string|number Window to send to
---@param command string Command to send
---@param submit boolean|nil Auto-submit (default true)
---@return boolean success
function M.send_command(name_or_index, command, submit)
  submit = submit == nil and true or submit
  local target = utils.format_target(name_or_index)

  local keys = command
  if submit then
    keys = keys .. ' Enter'
  end

  local result, err = utils.exec({ 'send-keys', '-t', target, keys })
  if err then
    vim.notify('Failed to send command: ' .. err, vim.log.levels.ERROR)
    return false
  end

  return true
end

--- Go to next window
function M.next()
  utils.exec({ 'next-window' })
end

--- Go to previous window
function M.previous()
  utils.exec({ 'previous-window' })
end

return M
