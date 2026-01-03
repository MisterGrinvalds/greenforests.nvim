-- Plugin fork URL resolver for lazy.nvim
-- Transforms 'owner/repo' to 'MisterGrinvalds/owner.repo' format

local M = {}

M.config = {
  github_username = 'MisterGrinvalds',
  separator = '.',
}

--- Convert 'owner/repo' to fork format
-- @param plugin string Plugin in 'owner/repo' format
-- @return string Fork repo in 'MisterGrinvalds/owner.repo' format
function M.fork(plugin)
  if type(plugin) ~= 'string' then
    error('fork() expects a string in "owner/repo" format, got: ' .. type(plugin))
  end

  local owner, repo = plugin:match('^([^/]+)/(.+)$')
  if not owner or not repo then
    error('Invalid plugin format: "' .. plugin .. '". Expected "owner/repo"')
  end

  return string.format('%s/%s%s%s', M.config.github_username, owner, M.config.separator, repo)
end

--- Check if a plugin spec uses a fork
-- @param spec table|string Plugin spec or name
-- @return boolean Whether it's a fork
-- @return string|nil The original plugin name if it's a fork
function M.is_fork(spec)
  local plugin_name
  if type(spec) == 'string' then
    plugin_name = spec
  elseif type(spec) == 'table' then
    plugin_name = spec[1]
  end

  if not plugin_name then
    return false, nil
  end

  local pattern = '^' .. M.config.github_username .. '/([^.]+)%.(.+)$'
  local owner, repo = plugin_name:match(pattern)

  if owner and repo then
    return true, owner .. '/' .. repo
  end

  return false, nil
end

--- Get original plugin name from fork name
-- @param fork_name string Fork name like 'MisterGrinvalds/owner.repo'
-- @return string|nil Original 'owner/repo' or nil if not a fork
function M.get_original(fork_name)
  local is_forked, original = M.is_fork(fork_name)
  return is_forked and original or nil
end

return M
