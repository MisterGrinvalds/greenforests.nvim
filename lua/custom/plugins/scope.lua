-- scope.nvim - Tab-scoped buffers
-- Each tab maintains its own buffer list for cleaner project separation
return {
  'tiagovla/scope.nvim',
  event = 'VeryLazy',
  config = function()
    require('scope').setup {}
  end,
}
