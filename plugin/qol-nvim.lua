-- qol-nvim: Quality of Life improvements for Neovim
-- Entry point - automatically loaded by Neovim

-- Guard against double-loading
if vim.g.loaded_qol_nvim then
  return
end
vim.g.loaded_qol_nvim = true

-- Version check
if vim.fn.has('nvim-0.9') ~= 1 then
  vim.notify('qol-nvim requires Neovim 0.9+', vim.log.levels.ERROR)
  return
end

-- Auto-setup with defaults
require('qol-nvim').setup {
  maximize = {
    enabled = true,
    keymap = '<leader>ww', -- Window Maximize toggle
  },
}
