---@class Maximize
local M = {}

---@class MaximizeConfig
---@field enabled boolean
---@field keymap? string
local defaults = {
  enabled = true,
  keymap = nil,
}

---@type MaximizeConfig
M.config = vim.deepcopy(defaults)

---@class WindowState
---@field bufnr number
---@field cursor number[]
---@field view table

---@class SavedLayout
---@field windows table<number, WindowState>
---@field layout any
---@field winrestcmd string
---@field current_win number
---@field current_buf number

---@type SavedLayout?
M._saved = nil

---@type boolean
M._maximized = false

---Check if currently maximized
---@return boolean
function M.is_maximized()
  return M._maximized
end

---Save current window layout
---@return SavedLayout
local function save_layout()
  local saved = {
    windows = {},
    layout = vim.fn.winlayout(),
    winrestcmd = vim.fn.winrestcmd(),
    current_win = vim.api.nvim_get_current_win(),
    current_buf = vim.api.nvim_get_current_buf(),
  }

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    -- Only save normal buffers (skip floating windows)
    local win_config = vim.api.nvim_win_get_config(win)
    if win_config.relative == '' then
      saved.windows[win] = {
        bufnr = buf,
        cursor = vim.api.nvim_win_get_cursor(win),
        view = vim.api.nvim_win_call(win, function()
          return vim.fn.winsaveview()
        end),
      }
    end
  end

  return saved
end

---Recursively restore window layout from winlayout() structure
---@param layout any The layout structure from vim.fn.winlayout()
---@param win_states table<number, WindowState> Saved window states
---@return table<number, number> Mapping of old window IDs to new window IDs
local function restore_layout_recursive(layout, win_states)
  local win_map = {}
  local kind = layout[1]

  if kind == 'leaf' then
    local old_winid = layout[2]
    local new_winid = vim.api.nvim_get_current_win()
    win_map[old_winid] = new_winid

    local state = win_states[old_winid]
    if state and vim.api.nvim_buf_is_valid(state.bufnr) then
      vim.api.nvim_win_set_buf(new_winid, state.bufnr)
    end
  elseif kind == 'row' or kind == 'col' then
    local children = layout[2]
    local split_cmd = kind == 'row' and 'vsplit' or 'split'

    for i, child in ipairs(children) do
      if i > 1 then
        vim.cmd(split_cmd)
      end
      local child_map = restore_layout_recursive(child, win_states)
      for old, new in pairs(child_map) do
        win_map[old] = new
      end
    end
  end

  return win_map
end

---Restore saved window layout
---@param saved SavedLayout
local function restore_layout(saved)
  -- Close all windows except current
  vim.cmd('silent! only')

  -- Recreate window layout structure
  local win_map = restore_layout_recursive(saved.layout, saved.windows)

  -- Restore window sizes
  vim.cmd(saved.winrestcmd)

  -- Restore cursor positions and views
  for old_win, state in pairs(saved.windows) do
    local new_win = win_map[old_win]
    if new_win and vim.api.nvim_win_is_valid(new_win) then
      pcall(vim.api.nvim_win_set_cursor, new_win, state.cursor)
      pcall(vim.api.nvim_win_call, new_win, function()
        vim.fn.winrestview(state.view)
      end)
    end
  end

  -- Restore focus to original window
  local new_current = win_map[saved.current_win]
  if new_current and vim.api.nvim_win_is_valid(new_current) then
    vim.api.nvim_set_current_win(new_current)
  end
end

---Maximize current window
function M.maximize()
  if M._maximized then
    return
  end

  M._saved = save_layout()
  vim.cmd('only')
  M._maximized = true
end

---Restore previous layout
function M.restore()
  if not M._maximized or not M._saved then
    return
  end

  restore_layout(M._saved)
  M._saved = nil
  M._maximized = false
end

---Toggle maximize state
function M.toggle()
  if M._maximized then
    M.restore()
  else
    M.maximize()
  end
end

---Setup maximize feature
---@param opts? MaximizeConfig
function M.setup(opts)
  M.config = vim.tbl_deep_extend('force', defaults, opts or {})

  if not M.config.enabled then
    return
  end

  -- Register command
  vim.api.nvim_create_user_command('QolMaximize', function()
    M.toggle()
  end, { desc = 'Toggle window maximize' })

  -- Register keymap if configured
  if M.config.keymap then
    vim.keymap.set('n', M.config.keymap, M.toggle, { desc = 'Toggle maximize' })
  end
end

return M
