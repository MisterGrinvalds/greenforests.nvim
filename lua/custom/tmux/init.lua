-- Main tmux interface module for Neovim
local M = {}

M.window = require('custom.tmux.window')
M.session = require('custom.tmux.session')
M.utils = require('custom.tmux.utils')
M.picker = require('custom.tmux.picker')

--- Check if running inside tmux
---@return boolean
function M.is_tmux()
  return vim.env.TMUX ~= nil
end

--- Ensure we're in tmux, show error if not
---@return boolean
function M.check_tmux()
  if not M.is_tmux() then
    vim.notify('Not running inside tmux. Start tmux first: tmux new -s dev', vim.log.levels.ERROR)
    return false
  end
  return true
end

--- Quick access: create or switch to named window
---@param name string Window name
---@param opts table|nil Options
function M.goto(name, opts)
  if not M.check_tmux() then
    return
  end
  M.window.goto_or_create(name, opts)
end

--- Send command to a window
---@param window_name string|nil Window name (nil = current window)
---@param command string Command to send
---@param submit boolean|nil Auto-submit (default true)
function M.send(window_name, command, submit)
  if not M.check_tmux() then
    return
  end

  window_name = window_name or M.utils.current_window()
  M.window.send_command(window_name, command, submit)
end

--- Get list of all windows
---@return table[] List of windows
function M.list_windows()
  if not M.check_tmux() then
    return {}
  end
  return M.window.list()
end

return M
