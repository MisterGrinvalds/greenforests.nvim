-- bufferline.nvim - Visual buffer tabs
-- Displays buffers as tabs at the top of your editor
return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = 'VeryLazy',
  keys = {
    { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle [P]in' },
    { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-[P]inned Buffers' },
    { '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', desc = 'Delete [O]ther Buffers' },
    { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the [R]ight' },
    { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the [L]eft' },
    { '<leader>bd', '<Cmd>bdelete<CR>', desc = '[D]elete Buffer' },
    { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move Buffer Left' },
    { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move Buffer Right' },
  },
  opts = {
    options = {
      close_command = 'bdelete! %d',
      right_mouse_command = 'bdelete! %d',
      diagnostics = 'nvim_lsp',
      always_show_bufferline = false, -- Only show when multiple buffers
      separator_style = 'slant', -- 'slant' | 'slope' | 'thick' | 'thin'
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'File Explorer',
          highlight = 'Directory',
          text_align = 'left',
        },
      },
    },
  },
}
