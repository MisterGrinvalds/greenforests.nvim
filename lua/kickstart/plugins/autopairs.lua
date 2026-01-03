-- autopairs
-- https://github.com/windwp/nvim-autopairs
local fork = require('lib.forks').fork

return {
  fork('windwp/nvim-autopairs'),
  name = 'nvim-autopairs',
  event = 'InsertEnter',
  opts = {},
}
