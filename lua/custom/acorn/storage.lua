-- Acorn session storage operations
local M = {}

local utils = require('custom.acorn.utils')

--- Check if .acorn file exists in project root
---@return boolean
function M.acorn_exists()
  local path = utils.get_acorn_path()
  return vim.fn.filereadable(path) == 1
end

--- Read .acorn file from project root
---@return table|nil
function M.read_acorn_file()
  local path = utils.get_acorn_path()
  if vim.fn.filereadable(path) ~= 1 then
    return nil
  end

  local content = vim.fn.readfile(path)
  if #content == 0 then
    return nil
  end

  local ok, data = pcall(vim.json.decode, table.concat(content, '\n'))
  if not ok then
    vim.notify('Failed to parse .acorn file', vim.log.levels.ERROR)
    return nil
  end

  return data
end

--- Write .acorn file to project root
---@param data table
---@return boolean
function M.write_acorn_file(data)
  local path = utils.get_acorn_path()
  local json = vim.json.encode(data)

  -- Pretty print JSON
  local formatted = json:gsub(',', ',\n  ')
  formatted = formatted:gsub('{', '{\n  ')
  formatted = formatted:gsub('}', '\n}')

  local ok = pcall(vim.fn.writefile, { formatted }, path)
  if not ok then
    vim.notify('Failed to write .acorn file', vim.log.levels.ERROR)
    return false
  end

  return true
end

--- Delete .acorn file from project root
---@return boolean
function M.delete_acorn_file()
  local path = utils.get_acorn_path()
  if vim.fn.filereadable(path) ~= 1 then
    return false
  end

  vim.fn.delete(path)
  return true
end

--- Ensure session directory exists
local function ensure_session_dir()
  local dir = utils.get_session_dir()
  if vim.fn.isdirectory(dir) ~= 1 then
    vim.fn.mkdir(dir, 'p')
  end
end

--- Save vim session to file
---@param session_id string
---@return boolean
function M.save_session(session_id)
  ensure_session_dir()
  local path = utils.get_session_path(session_id)

  local ok = pcall(vim.cmd, 'mksession! ' .. vim.fn.fnameescape(path))
  if not ok then
    vim.notify('Failed to save session', vim.log.levels.ERROR)
    return false
  end

  return true
end

--- Load vim session from file
---@param session_id string
---@return boolean
function M.load_session(session_id)
  local path = utils.get_session_path(session_id)

  if vim.fn.filereadable(path) ~= 1 then
    vim.notify('Session file not found: ' .. path, vim.log.levels.ERROR)
    return false
  end

  local ok = pcall(vim.cmd, 'source ' .. vim.fn.fnameescape(path))
  if not ok then
    vim.notify('Failed to load session', vim.log.levels.ERROR)
    return false
  end

  return true
end

--- Check if session file exists
---@param session_id string
---@return boolean
function M.session_exists(session_id)
  local path = utils.get_session_path(session_id)
  return vim.fn.filereadable(path) == 1
end

--- Delete session file
---@param session_id string
---@return boolean
function M.delete_session(session_id)
  local path = utils.get_session_path(session_id)
  if vim.fn.filereadable(path) ~= 1 then
    return false
  end

  vim.fn.delete(path)
  return true
end

--- List all acorn sessions
--- Scans session directory for acorn_*.vim files and reads associated .acorn metadata
---@return table[]
function M.list_sessions()
  local dir = utils.get_session_dir()
  if vim.fn.isdirectory(dir) ~= 1 then
    return {}
  end

  local sessions = {}
  local files = vim.fn.glob(dir .. 'acorn_*.vim', false, true)

  for _, file in ipairs(files) do
    local filename = vim.fn.fnamemodify(file, ':t')
    local session_id = filename:match('acorn_(%d+)%.vim')

    if session_id then
      local stat = vim.loop.fs_stat(file)
      table.insert(sessions, {
        session_id = session_id,
        path = file,
        mtime = stat and stat.mtime.sec or 0,
        size = stat and stat.size or 0,
      })
    end
  end

  -- Sort by modification time, newest first
  table.sort(sessions, function(a, b)
    return a.mtime > b.mtime
  end)

  return sessions
end

--- Get session info by ID
---@param session_id string
---@return table|nil
function M.get_session_info(session_id)
  local path = utils.get_session_path(session_id)
  if vim.fn.filereadable(path) ~= 1 then
    return nil
  end

  local stat = vim.loop.fs_stat(path)
  return {
    session_id = session_id,
    path = path,
    mtime = stat and stat.mtime.sec or 0,
    size = stat and stat.size or 0,
  }
end

return M
