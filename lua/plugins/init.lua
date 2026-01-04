-- Plugin specifications
-- Each module returns a table (or table of tables) for lazy.nvim

return {
  -- Core functionality
  require('plugins.telescope'),
  require('plugins.lsp'),
  require('plugins.treesitter'),
  require('plugins.completion'),
  require('plugins.formatting'),

  -- UI
  require('plugins.colorscheme'),
  require('plugins.ui'),
  require('plugins.bufferline'),
  require('plugins.statusline'),

  -- Git
  require('plugins.git'),

  -- Navigation
  require('plugins.navigation'),

  -- Editing
  require('plugins.editing'),

  -- Diagnostics
  require('plugins.diagnostics'),

  -- Terminal
  require('plugins.terminal'),

  -- Tools
  require('plugins.claude-code'),
  require('plugins.docusaurus'),
  require('plugins.plugin-help'),
}
