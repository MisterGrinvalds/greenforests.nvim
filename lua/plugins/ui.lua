-- UI plugins - which-key, scrollbar, indent guides
local fork = require('lib.forks').fork

return {
  -- Which-key - Keybinding hints
  {
    fork('folke/which-key.nvim'),
    name = 'which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 300,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>', F2 = '<F2>', F3 = '<F3>', F4 = '<F4>',
          F5 = '<F5>', F6 = '<F6>', F7 = '<F7>', F8 = '<F8>',
          F9 = '<F9>', F10 = '<F10>', F11 = '<F11>', F12 = '<F12>',
        },
      },
      spec = {
        { '<leader>b', group = '[B]uffer' },
        { '<leader>c', group = '[C]laude Code' },
        { '<leader>f', group = '[F]ind (Telescope)' },
        { '<leader>g', group = '[G]it' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]mux' },
        { '<leader>w', group = '[W]indow' },
        { '<leader>x', group = 'Diagnostics' },
      },
    },
  },

  -- Scrollbar
  {
    fork('petertriho/nvim-scrollbar'),
    event = 'VeryLazy',
    config = function()
      require('scrollbar').setup()
    end,
  },

  -- Indent guides
  {
    fork('lukas-reineke/indent-blankline.nvim'),
    name = 'indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = { char = '│' },
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
      },
    },
  },

  -- Image rendering in Neovim (for kitty/ghostty/iTerm2)
  {
    fork('3rd/image.nvim'),
    main = 'image',
    build = false, -- use magick_cli, no luarocks needed
    opts = {
      backend = 'kitty', -- works with Ghostty and iTerm2 too
      processor = 'magick_cli',
      max_height_window_percentage = 50,
      integrations = {
        markdown = { enabled = true },
        neorg = { enabled = false },
      },
    },
  },
}
