---@class QolNvim
---@field maximize Maximize
local M = {}

---@class QolConfig
---@field maximize MaximizeConfig
local defaults = {
  maximize = {
    enabled = true,
    keymap = nil, -- Set to a keymap string like '<leader>z' to auto-register
  },
}

---@type QolConfig
M.config = vim.deepcopy(defaults)

---@type boolean
M._setup_done = false

---Setup qol-nvim with user configuration
---@param opts? QolConfig
function M.setup(opts)
  if M._setup_done then
    return
  end
  M._setup_done = true

  M.config = vim.tbl_deep_extend('force', defaults, opts or {})

  -- Load maximize module
  M.maximize = require('qol-nvim.maximize')
  M.maximize.setup(M.config.maximize)
end

return M
