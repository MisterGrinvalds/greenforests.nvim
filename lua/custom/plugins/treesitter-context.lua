-- nvim-treesitter-context - Show current code context
-- Displays the current function/class/method at the top of the window
return {
  'nvim-treesitter/nvim-treesitter-context',
  event = 'VeryLazy',
  opts = {
    max_lines = 3, -- How many lines the context can show
    min_window_height = 0,
    line_numbers = true,
    multiline_threshold = 20,
    trim_scope = 'outer',
    mode = 'cursor',
  },
  keys = {
    {
      '<leader>tc',
      function()
        require('treesitter-context').toggle()
      end,
      desc = '[T]oggle [C]ontext',
    },
  },
}
