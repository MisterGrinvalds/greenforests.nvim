-- Harpoon - Quick file navigation
-- Mark files and jump to them instantly
return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  lazy = false,  -- Load immediately so keymaps work
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    -- Keymaps
    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Harpoon: [A]dd file' })

    vim.keymap.set('n', '<leader>e', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon: Toggle m[E]nu' })

    -- Quick jump to files 1-4
    vim.keymap.set('n', '<leader>1', function()
      harpoon:list():select(1)
    end, { desc = 'Harpoon: File [1]' })
    vim.keymap.set('n', '<leader>2', function()
      harpoon:list():select(2)
    end, { desc = 'Harpoon: File [2]' })
    vim.keymap.set('n', '<leader>3', function()
      harpoon:list():select(3)
    end, { desc = 'Harpoon: File [3]' })
    vim.keymap.set('n', '<leader>4', function()
      harpoon:list():select(4)
    end, { desc = 'Harpoon: File [4]' })
  end,
}
