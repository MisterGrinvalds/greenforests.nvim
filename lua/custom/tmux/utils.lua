-- Utility functions for tmux command execution
local M = {}

--- Execute tmux command and return output
---@param args table List of command arguments
---@return string|nil result Command output
---@return string|nil error Error message if failed
function M.exec(args)
  local cmd = 'tmux ' .. table.concat(args, ' ')
  local handle = io.popen(cmd .. ' 2>&1')
  if not handle then
    return nil, 'Failed to execute tmux command'
  end

  local result = handle:read('*a')
  local success = handle:close()

  if not success then
    return nil, result
  end

  return result:gsub('%s+$', ''), nil -- trim trailing whitespace
end

--- Check if a window exists by name
---@param name string Window name
---@return boolean
function M.window_exists(name)
  local result = M.exec({ 'list-windows', '-F', '#{window_name}' })
  if not result then
    return false
  end

  for window in result:gmatch('[^\n]+') do
    if window == name then
      return true
    end
  end
  return false
end

--- Get current window index
---@return string|nil
function M.current_window()
  local result = M.exec({ 'display-message', '-p', '#{window_index}' })
  return result
end

--- Get current window name
---@return string|nil
function M.current_window_name()
  local result = M.exec({ 'display-message', '-p', '#{window_name}' })
  return result
end

--- Format tmux target (window name or index)
---@param name_or_index string|number
---@return string Formatted target
function M.format_target(name_or_index)
  -- If numeric, treat as index, otherwise as name
  if tonumber(name_or_index) then
    return ':' .. name_or_index
  else
    return '=' .. vim.fn.shellescape(name_or_index)
  end
end

return M
