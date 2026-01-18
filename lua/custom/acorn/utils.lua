-- Acorn session management utilities
local M = {}

--- Generate epoch-based session ID
---@return string
function M.generate_session_id()
  return tostring(os.time())
end

--- Get current git branch name
---@return string|nil
function M.get_git_branch()
  local handle = io.popen('git rev-parse --abbrev-ref HEAD 2>/dev/null')
  if handle then
    local branch = handle:read('*l')
    handle:close()
    return branch
  end
  return nil
end

--- Generate ISO 8601 timestamp
---@return string
function M.iso_timestamp()
  return os.date('!%Y-%m-%dT%H:%M:%SZ')
end

--- Get XDG-compliant session directory
---@return string
function M.get_session_dir()
  return vim.fn.stdpath('state') .. '/sessions/'
end

--- Get current project root (working directory)
---@return string
function M.get_project_root()
  return vim.fn.getcwd()
end

--- Get path to acorn file for current project
---@return string
function M.get_acorn_path()
  return M.get_project_root() .. '/.acorn'
end

--- Get session file path for a given ID
---@param session_id string
---@return string
function M.get_session_path(session_id)
  return M.get_session_dir() .. 'acorn_' .. session_id .. '.vim'
end

--- Format epoch timestamp for display
---@param epoch number|string
---@return string
function M.format_timestamp(epoch)
  local ts = tonumber(epoch)
  if not ts then
    return 'unknown'
  end
  return os.date('%Y-%m-%d %H:%M', ts)
end

--- Parse ISO timestamp to epoch
---@param iso string
---@return number|nil
function M.parse_iso(iso)
  if not iso then
    return nil
  end
  local pattern = '(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)Z'
  local year, month, day, hour, min, sec = iso:match(pattern)
  if year then
    return os.time({
      year = tonumber(year),
      month = tonumber(month),
      day = tonumber(day),
      hour = tonumber(hour),
      min = tonumber(min),
      sec = tonumber(sec),
    })
  end
  return nil
end

return M
