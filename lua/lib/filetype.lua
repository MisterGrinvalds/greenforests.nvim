-- Filetype-specific settings
local M = {}

-- Indentation config: filetype -> spaces count
M.indent = {
  -- 2 spaces
  lua = 2,
  javascript = 2,
  typescript = 2,
  typescriptreact = 2,
  javascriptreact = 2,
  json = 2,
  jsonc = 2,
  yaml = 2,
  html = 2,
  css = 2,
  scss = 2,
  markdown = 2,
  vim = 2,

  -- 4 spaces
  go = 4,
  python = 4,
  sh = 4,
  bash = 4,
  zsh = 4,
}

-- Default for unlisted filetypes
M.default_indent = 2

--- Apply indentation settings to current buffer
function M.apply_indent()
  local ft = vim.bo.filetype
  local spaces = M.indent[ft] or M.default_indent

  vim.bo.expandtab = true      -- Use spaces, not tabs
  vim.bo.shiftwidth = spaces   -- Indent size
  vim.bo.tabstop = spaces      -- Tab display width
  vim.bo.softtabstop = spaces  -- Backspace behavior
end

return M
