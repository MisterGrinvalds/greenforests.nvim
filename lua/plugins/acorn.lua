-- Acorn - Session bookmarking with .acorn files
-- Custom module, not a lazy.nvim plugin

return {
  name = 'acorn',
  dir = vim.fn.stdpath('config') .. '/lua/custom/acorn',
  lazy = false,
  config = function()
    require('custom.acorn').setup {
      prefix = '<leader>a',
      auto_prompt = true,
    }
  end,
}
