-- Session management functions for tmux
local M = {}
local utils = require('custom.tmux.utils')

--- Get current session name
---@return string|nil
function M.current()
  local result = utils.exec({ 'display-message', '-p', '#{session_name}' })
  return result
end

--- List all sessions
---@return table[] List of session objects
function M.list()
  local result = utils.exec({ 'list-sessions', '-F', '#{session_name}:#{session_attached}' })
  if not result then
    return {}
  end

  local sessions = {}
  for line in result:gmatch('[^\n]+') do
    local name, attached = line:match('([^:]+):([01])')
    if name then
      table.insert(sessions, {
        name = name,
        attached = attached == '1',
      })
    end
  end

  return sessions
end

--- Create new session
---@param name string Session name
---@param opts table|nil Options (cwd)
---@return boolean success
function M.create(name, opts)
  opts = opts or {}
  local args = { 'new-session', '-d', '-s', vim.fn.shellescape(name) }

  if opts.cwd then
    table.insert(args, '-c')
    table.insert(args, vim.fn.shellescape(opts.cwd))
  end

  local result, err = utils.exec(args)
  if err then
    vim.notify('Failed to create session: ' .. err, vim.log.levels.ERROR)
    return false
  end

  return true
end

--- Switch to session
---@param name string Session name
---@return boolean success
function M.switch(name)
  local result, err = utils.exec({ 'switch-client', '-t', vim.fn.shellescape(name) })
  if err then
    vim.notify('Failed to switch session: ' .. err, vim.log.levels.ERROR)
    return false
  end
  return true
end

return M
