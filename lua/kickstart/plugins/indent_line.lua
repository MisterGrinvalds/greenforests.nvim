local fork = require('lib.forks').fork

return {
  { -- Add indentation guides even on blank lines
    fork('lukas-reineke/indent-blankline.nvim'),
    name = 'indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },
}
