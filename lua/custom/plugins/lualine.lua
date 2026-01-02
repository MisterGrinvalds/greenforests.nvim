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
        -- Claude Code status (model, tokens, lines changed)
        {
          function()
            local ok, statusline = pcall(require, 'claude-code.statusline')
            if ok then
              return statusline.get_status()
            end
            return ''
          end,
          color = function()
            local ok, statusline = pcall(require, 'claude-code.statusline')
            if ok then
              return { fg = statusline.get_color() }
            end
            return {}
          end,
          cond = function()
            local ok, statusline = pcall(require, 'claude-code.statusline')
            return ok and statusline.get_cached_status() ~= nil
          end,
        },
        'encoding',
        'fileformat',
        'filetype',
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
  },
}
