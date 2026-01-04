-- Plugin Help System
-- Provides Neovim commands for in-editor plugin documentation

return {
  dir = vim.fn.stdpath 'config',
  name = 'plugin-help',
  lazy = false,
  config = function()
    require 'lib.plugin-registry'
    local help = require 'lib.plugin-help'

    vim.api.nvim_create_user_command('PluginHelp', function(opts)
      if opts.args and opts.args ~= '' then
        help.show(opts.args)
      else
        help.pick_plugin()
      end
    end, {
      desc = 'Show plugin help (or pick from list)',
      nargs = '?',
      complete = function()
        local names = {}
        for name, _ in pairs(help.get_all()) do
          table.insert(names, name)
        end
        table.sort(names)
        return names
      end,
    })

    vim.api.nvim_create_user_command('PluginKeymaps', function()
      help.pick_keymap()
    end, { desc = 'Browse all plugin keymaps' })

    vim.api.nvim_create_user_command('PluginCategories', function()
      help.show_categories()
    end, { desc = 'Show plugins by category' })

    vim.api.nvim_create_user_command('KeymapGuide', function()
      help.show_keymaps()
    end, { desc = 'Show keymap quick reference' })

    vim.keymap.set('n', '<leader>?', function()
      help.pick_plugin()
    end, { desc = 'Plugin help picker' })

    vim.keymap.set('n', '<leader>sk', function()
      help.pick_keymap()
    end, { desc = '[S]earch [K]eymaps (plugins)' })
  end,
}
