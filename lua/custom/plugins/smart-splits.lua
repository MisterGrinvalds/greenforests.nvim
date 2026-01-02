-- smart-splits.nvim - Better split navigation and resizing
-- Works seamlessly with tmux, wezterm, kitty panes
return {
  'mrjones2014/smart-splits.nvim',
  lazy = false,  -- Load immediately for tmux integration
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

    -- Navigation (move between splits) - Shift+hjkl for clear split navigation
    vim.keymap.set('n', '<S-h>', require('smart-splits').move_cursor_left, { desc = 'Move to left split' })
    vim.keymap.set('n', '<S-j>', require('smart-splits').move_cursor_down, { desc = 'Move to below split' })
    vim.keymap.set('n', '<S-k>', require('smart-splits').move_cursor_up, { desc = 'Move to above split' })
    vim.keymap.set('n', '<S-l>', require('smart-splits').move_cursor_right, { desc = 'Move to right split' })

    -- Arrow alternatives for split navigation
    vim.keymap.set('n', '<S-Left>', require('smart-splits').move_cursor_left, { desc = 'Move to left split' })
    vim.keymap.set('n', '<S-Down>', require('smart-splits').move_cursor_down, { desc = 'Move to below split' })
    vim.keymap.set('n', '<S-Up>', require('smart-splits').move_cursor_up, { desc = 'Move to above split' })
    vim.keymap.set('n', '<S-Right>', require('smart-splits').move_cursor_right, { desc = 'Move to right split' })

    -- Resizing (Alt + hjkl and arrows)
    vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left, { desc = 'Resize split left' })
    vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down, { desc = 'Resize split down' })
    vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up, { desc = 'Resize split up' })
    vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right, { desc = 'Resize split right' })

    -- Arrow key alternatives for resizing
    vim.keymap.set('n', '<A-Left>', require('smart-splits').resize_left, { desc = 'Resize split left' })
    vim.keymap.set('n', '<A-Down>', require('smart-splits').resize_down, { desc = 'Resize split down' })
    vim.keymap.set('n', '<A-Up>', require('smart-splits').resize_up, { desc = 'Resize split up' })
    vim.keymap.set('n', '<A-Right>', require('smart-splits').resize_right, { desc = 'Resize split right' })

    -- Swapping buffers between windows (hjkl only to keep it simple)
    vim.keymap.set('n', '<leader>wh', require('smart-splits').swap_buf_left, { desc = 'Swap buffer left' })
    vim.keymap.set('n', '<leader>wj', require('smart-splits').swap_buf_down, { desc = 'Swap buffer down' })
    vim.keymap.set('n', '<leader>wk', require('smart-splits').swap_buf_up, { desc = 'Swap buffer up' })
    vim.keymap.set('n', '<leader>wl', require('smart-splits').swap_buf_right, { desc = 'Swap buffer right' })
  end,
}
