-- scope.nvim - Tab-scoped buffers
-- Each tab maintains its own buffer list for cleaner project separation
local fork = require('lib.forks').fork

return {
  fork('tiagovla/scope.nvim'),
  name = 'scope.nvim',
  event = 'VeryLazy',
  config = function()
    require('scope').setup {}
  end,
}
