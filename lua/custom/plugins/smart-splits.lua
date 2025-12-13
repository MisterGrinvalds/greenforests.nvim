-- smart-splits.nvim - Better split navigation and resizing
-- Works seamlessly with tmux, wezterm, kitty panes
return {
  'mrjones2014/smart-splits.nvim',
  event = 'VeryLazy',
  config = function()
    require('smart-splits').setup({
      -- Ignore these filetypes when resizing
      ignored_filetypes = { 'nofile', 'quickfix', 'prompt' },
      -- Ignore these buffer types when resizing
      ignored_buftypes = { 'NvimTree' },
      -- Default amount to resize
      default_amount = 3,
      -- Whether to move cursor to resized window
      move_cursor_same_row = false,
      -- Disable multiplexer navigation if current pane is zoomed
      at_edge = 'stop',
    })

    -- Navigation (move between splits)
    vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left, { desc = 'Move to left split' })
    vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down, { desc = 'Move to below split' })
    vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up, { desc = 'Move to above split' })
    vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right, { desc = 'Move to right split' })

    -- Resizing (Alt + hjkl)
    vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left, { desc = 'Resize split left' })
    vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down, { desc = 'Resize split down' })
    vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up, { desc = 'Resize split up' })
    vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right, { desc = 'Resize split right' })

    -- Swapping buffers between windows
    vim.keymap.set('n', '<leader>wh', require('smart-splits').swap_buf_left, { desc = 'Swap buffer left' })
    vim.keymap.set('n', '<leader>wj', require('smart-splits').swap_buf_down, { desc = 'Swap buffer down' })
    vim.keymap.set('n', '<leader>wk', require('smart-splits').swap_buf_up, { desc = 'Swap buffer up' })
    vim.keymap.set('n', '<leader>wl', require('smart-splits').swap_buf_right, { desc = 'Swap buffer right' })
  end,
}
