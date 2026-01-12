-- Core autocommands
-- See :help lua-guide-autocommands

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('greenforests-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Filetype-specific indentation
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Apply filetype-specific indentation',
  group = vim.api.nvim_create_augroup('greenforests-filetype-indent', { clear = true }),
  callback = function()
    require('lib.filetype').apply_indent()
  end,
})
