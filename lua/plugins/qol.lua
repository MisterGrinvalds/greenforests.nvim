-- qol.nvim - Quality of Life improvements (local development)
return {
  {
    dir = '~/Repos/personal/qol.nvim',
    name = 'qol.nvim',
    lazy = false,
    config = function()
      require('qol-nvim').setup({
        maximize = {
          enabled = true,
          keymap = '<leader>wm', -- Window Maximize toggle
        },
      })
    end,
  },
}
