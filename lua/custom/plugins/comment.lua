-- Comment.nvim - Toggle comments easily
-- gcc: toggle comment on current line
-- gc: toggle comment on motion/selection (e.g., gc5j, gcip, visual gc)
local fork = require('lib.forks').fork

return {
  fork('numToStr/Comment.nvim'),
  name = 'Comment.nvim',
  event = 'VeryLazy',
  opts = {},
}
