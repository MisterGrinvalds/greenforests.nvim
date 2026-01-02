-- lualine.nvim - Status line with Claude Code integration
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'catppuccin',
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      globalstatus = true, -- Single status line for all windows
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename' },
      lualine_x = {
        -- Claude Code status indicator
        function()
          local ok, claude_status = pcall(require, 'claude-code.statusline')
          if ok then
            return claude_status.get_status_string()
          end
          return ''
        end,
        -- Encoding, fileformat, filetype
        'encoding',
        'fileformat',
        'filetype',
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
  },
}
