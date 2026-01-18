-- Treesitter - Syntax highlighting and code understanding
local fork = require('lib.forks').fork

return {
  -- Main treesitter
  {
    fork('nvim-treesitter/nvim-treesitter'),
    build = ':TSUpdate',
    lazy = false,
    priority = 1000,
    config = function()
      local parsers = {
        'bash', 'c', 'diff', 'html', 'css',
        'javascript', 'typescript', 'tsx', 'json',
        'lua', 'luadoc', 'markdown', 'markdown_inline',
        'python', 'go', 'gomod', 'gosum', 'gowork',
        'query', 'vim', 'vimdoc',
        'yaml',
      }

      local ts = require('nvim-treesitter')
      vim.schedule(function()
        ts.install(parsers)
      end)

      -- Enable treesitter-based highlighting
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
      -- Enable for all existing buffers
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= '' then
          pcall(vim.treesitter.start, buf)
        end
      end

      -- Enable treesitter-based indentation
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  -- Treesitter context - Show current function at top
  {
    fork('nvim-treesitter/nvim-treesitter-context'),
    name = 'nvim-treesitter-context',
    event = 'VeryLazy',
    opts = {
      max_lines = 3,
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
  },
}
