-- bufferline.nvim - Visual buffer tabs
-- Displays buffers as tabs at the top of your editor
return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = 'VeryLazy',
  keys = {
    { '<leader>bi', '<Cmd>BufferLineTogglePin<CR>', desc = 'P[i]n buffer toggle' },
    { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete non-pinned buffers' },
    { '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', desc = 'Delete [O]ther buffers' },
    { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete buffers to [R]ight' },
    { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete buffers to [L]eft' },
    { '<leader>bd', '<Cmd>bdelete<CR>', desc = '[D]elete buffer' },
    { '<leader>bj', '<Cmd>BufferLinePick<CR>', desc = '[J]ump to buffer (visual)' },
    { '<leader>bp', '<cmd>lua require("custom.buffer-picker").show()<cr>', desc = 'Buffer [P]icker' },
    -- Tab navigation (with picker)
    { '<leader>xp', '<cmd>lua require("custom.tab-picker").show()<cr>', desc = 'Tab [P]icker' },
    {
      '<leader>xn',
      function()
        vim.ui.input({ prompt = 'Tab name: ' }, function(name)
          if name and name ~= '' then
            vim.cmd('tabnew')
            -- Set BufferLine tab name
            vim.t.bufferline_tab_name = name
            vim.notify('Created tab: ' .. name, vim.log.levels.INFO)
          else
            -- No name provided, just create tab
            vim.cmd('tabnew')
          end
        end)
      end,
      desc = 'Tab [N]ew (with name)',
    },
    { '<leader>xc', '<Cmd>tabclose<CR>', desc = 'Tab [C]lose' },
    { '<leader>xo', '<Cmd>tabonly<CR>', desc = 'Tab [O]nly (close others)' },
    { ']t', '<Cmd>tabnext<CR>', desc = 'Next Tab' },
    { '[t', '<Cmd>tabprev<CR>', desc = 'Prev Tab' },
  },
  opts = {
    options = {
      mode = 'tabs', -- Show Vim tabs instead of buffers (syncs with tab picker!)
      numbers = 'ordinal', -- Show buffer numbers
      close_command = 'bdelete! %d',
      right_mouse_command = 'bdelete! %d',
      diagnostics = 'nvim_lsp',
      always_show_bufferline = true,
      separator_style = 'slant', -- 'slant' | 'slope' | 'thick' | 'thin'
      show_buffer_close_icons = true,
      show_close_icon = false,
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
