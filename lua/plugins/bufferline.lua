-- Bufferline - Visual buffer tabs + scope
local fork = require('lib.forks').fork

return {
  -- Bufferline
  {
    fork('akinsho/bufferline.nvim'),
    name = 'bufferline.nvim',
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
      { '<leader>bp', '<cmd>Telescope buffers<cr>', desc = 'Buffer [P]icker' },
      {
        '<leader>xn',
        function()
          vim.ui.input({ prompt = 'Tab name: ' }, function(name)
            if name and name ~= '' then
              vim.cmd('tabedit ' .. vim.fn.fnameescape(name))
              vim.cmd('BufferLineTabRename ' .. name)
            else
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
        mode = 'buffers',
        numbers = 'ordinal',
        close_command = 'bdelete! %d',
        right_mouse_command = 'bdelete! %d',
        diagnostics = 'nvim_lsp',
        always_show_bufferline = true,
        separator_style = 'slant',
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
  },

  -- Scope - Tab-scoped buffers
  {
    fork('tiagovla/scope.nvim'),
    name = 'scope.nvim',
    event = 'VeryLazy',
    config = function()
      require('scope').setup {}
    end,
  },
}
