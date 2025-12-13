-- Comment.nvim - Toggle comments easily
-- gcc: toggle comment on current line
-- gc: toggle comment on motion/selection (e.g., gc5j, gcip, visual gc)
return {
  'numToStr/Comment.nvim',
  event = 'VeryLazy',
  opts = {},
}
