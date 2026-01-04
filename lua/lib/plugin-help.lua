-- Plugin Help System
-- Provides in-editor documentation and keymap discovery for plugins

local M = {}

---@class PluginKeymap
---@field key string Keymap sequence (e.g., '<leader>ff')
---@field desc string Description
---@field mode string|string[] Mode(s): 'n', 'v', 'i', etc.

---@class PluginCommand
---@field cmd string Command name (e.g., 'TelescopeFiles')
---@field desc string Description

---@class PluginInfo
---@field name string Plugin name
---@field category string Category: navigation, git, lsp, etc.
---@field description string One-line description
---@field keymaps PluginKeymap[] List of keymaps
---@field commands PluginCommand[] List of commands
---@field tips string[]|nil Quick tips for the plugin

-- Plugin registry storage
M.registry = {}

-- Category display names and icons
M.categories = {
  navigation = { name = 'Navigation', icon = '' },
  git = { name = 'Git', icon = '' },
  lsp = { name = 'LSP/Code', icon = '' },
  completion = { name = 'Completion', icon = '' },
  editing = { name = 'Editing', icon = '' },
  terminal = { name = 'Terminal', icon = '' },
  ui = { name = 'UI', icon = '' },
  treesitter = { name = 'Treesitter', icon = '' },
  debug = { name = 'Debug', icon = '' },
  formatting = { name = 'Formatting', icon = '' },
  utility = { name = 'Utility', icon = '' },
}

--- Register a plugin with the help system
---@param info PluginInfo Plugin information
function M.register(info)
  if not info.name then
    error('Plugin registration requires a name')
  end
  M.registry[info.name] = info
end

--- Get all registered plugins
---@return table<string, PluginInfo>
function M.get_all()
  return M.registry
end

--- Get plugin by name
---@param name string Plugin name
---@return PluginInfo|nil
function M.get(name)
  return M.registry[name]
end

--- Get plugins by category
---@param category string Category name
---@return PluginInfo[]
function M.get_by_category(category)
  local result = {}
  for _, plugin in pairs(M.registry) do
    if plugin.category == category then
      table.insert(result, plugin)
    end
  end
  return result
end

--- Get all keymaps across all plugins
---@return table[] List of {plugin, keymap} pairs
function M.get_all_keymaps()
  local result = {}
  for name, plugin in pairs(M.registry) do
    if plugin.keymaps then
      for _, keymap in ipairs(plugin.keymaps) do
        table.insert(result, {
          plugin = name,
          category = plugin.category,
          key = keymap.key,
          desc = keymap.desc,
          mode = keymap.mode or 'n',
        })
      end
    end
  end
  -- Sort by key
  table.sort(result, function(a, b)
    return a.key < b.key
  end)
  return result
end

--- Get all commands across all plugins
---@return table[] List of {plugin, command} pairs
function M.get_all_commands()
  local result = {}
  for name, plugin in pairs(M.registry) do
    if plugin.commands then
      for _, cmd in ipairs(plugin.commands) do
        table.insert(result, {
          plugin = name,
          category = plugin.category,
          cmd = cmd.cmd,
          desc = cmd.desc,
        })
      end
    end
  end
  -- Sort by command name
  table.sort(result, function(a, b)
    return a.cmd < b.cmd
  end)
  return result
end

--- Format plugin info as lines for display
---@param name string Plugin name
---@return string[]|nil lines
function M.format_plugin_help(name)
  local plugin = M.registry[name]
  if not plugin then
    return nil
  end

  local lines = {}
  local cat = M.categories[plugin.category] or { name = plugin.category, icon = '' }

  -- Header
  table.insert(lines, string.format('# %s', plugin.name))
  table.insert(lines, string.format('%s %s', cat.icon, cat.name))
  table.insert(lines, '')
  table.insert(lines, plugin.description or 'No description')
  table.insert(lines, '')

  -- Keymaps
  if plugin.keymaps and #plugin.keymaps > 0 then
    table.insert(lines, '## Keymaps')
    table.insert(lines, '')
    for _, km in ipairs(plugin.keymaps) do
      local mode = type(km.mode) == 'table' and table.concat(km.mode, ',') or (km.mode or 'n')
      table.insert(lines, string.format('  %s  %-15s  %s', mode, km.key, km.desc))
    end
    table.insert(lines, '')
  end

  -- Commands
  if plugin.commands and #plugin.commands > 0 then
    table.insert(lines, '## Commands')
    table.insert(lines, '')
    for _, cmd in ipairs(plugin.commands) do
      table.insert(lines, string.format('  :%s', cmd.cmd))
      table.insert(lines, string.format('    %s', cmd.desc))
    end
    table.insert(lines, '')
  end

  -- Tips
  if plugin.tips and #plugin.tips > 0 then
    table.insert(lines, '## Tips')
    table.insert(lines, '')
    for i, tip in ipairs(plugin.tips) do
      table.insert(lines, string.format('  %d. %s', i, tip))
    end
    table.insert(lines, '')
  end

  return lines
end

--- Format all keymaps by category
---@return string[]
function M.format_keymap_guide()
  local lines = {
    '# Keymap Guide',
    '',
  }

  -- Group keymaps by category
  local by_category = {}
  for _, km in ipairs(M.get_all_keymaps()) do
    local cat = km.category or 'utility'
    if not by_category[cat] then
      by_category[cat] = {}
    end
    table.insert(by_category[cat], km)
  end

  -- Output by category
  for cat_key, cat_info in pairs(M.categories) do
    local keymaps = by_category[cat_key]
    if keymaps and #keymaps > 0 then
      table.insert(lines, string.format('## %s %s', cat_info.icon, cat_info.name))
      table.insert(lines, '')
      for _, km in ipairs(keymaps) do
        table.insert(lines, string.format('  %-15s  %s  (%s)', km.key, km.desc, km.plugin))
      end
      table.insert(lines, '')
    end
  end

  return lines
end

--- Format category overview
---@return string[]
function M.format_category_overview()
  local lines = {
    '# Plugin Categories',
    '',
  }

  for cat_key, cat_info in pairs(M.categories) do
    local plugins = M.get_by_category(cat_key)
    if #plugins > 0 then
      table.insert(lines, string.format('## %s %s', cat_info.icon, cat_info.name))
      table.insert(lines, '')
      for _, plugin in ipairs(plugins) do
        table.insert(lines, string.format('  - **%s**: %s', plugin.name, plugin.description or ''))
      end
      table.insert(lines, '')
    end
  end

  return lines
end

--- Show help in a floating window
---@param content string[] Lines to display
---@param title string Window title
function M.show_float(content, title)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
  vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf })
  vim.api.nvim_set_option_value('filetype', 'markdown', { buf = buf })
  vim.api.nvim_set_option_value('modifiable', false, { buf = buf })

  -- Calculate window size
  local width = math.min(80, vim.o.columns - 4)
  local height = math.min(#content + 2, vim.o.lines - 4)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
    title = ' ' .. title .. ' ',
    title_pos = 'center',
  })

  -- Close on q or Escape
  vim.keymap.set('n', 'q', function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf, nowait = true })
  vim.keymap.set('n', '<Esc>', function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf, nowait = true })
end

--- Show help for a specific plugin
---@param name string Plugin name
function M.show(name)
  local lines = M.format_plugin_help(name)
  if not lines then
    vim.notify('Plugin not found: ' .. name, vim.log.levels.WARN)
    return
  end
  M.show_float(lines, name .. ' Help')
end

--- Show all keymaps
function M.show_keymaps()
  local lines = M.format_keymap_guide()
  M.show_float(lines, 'Keymap Guide')
end

--- Show category overview
function M.show_categories()
  local lines = M.format_category_overview()
  M.show_float(lines, 'Plugin Categories')
end

--- Show plugin picker (requires telescope)
function M.pick_plugin()
  local ok, telescope = pcall(require, 'telescope.builtin')
  if not ok then
    vim.notify('Telescope required for plugin picker', vim.log.levels.WARN)
    return
  end

  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'

  local plugins = {}
  for name, info in pairs(M.registry) do
    local cat = M.categories[info.category] or { icon = '' }
    table.insert(plugins, {
      name = name,
      display = string.format('%s %s - %s', cat.icon, name, info.description or ''),
    })
  end

  pickers
    .new({}, {
      prompt_title = 'Plugin Help',
      finder = finders.new_table {
        results = plugins,
        entry_maker = function(entry)
          return {
            value = entry.name,
            display = entry.display,
            ordinal = entry.name,
          }
        end,
      },
      sorter = conf.generic_sorter {},
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if selection then
            M.show(selection.value)
          end
        end)
        return true
      end,
    })
    :find()
end

--- Show keymap picker (requires telescope)
function M.pick_keymap()
  local ok, _ = pcall(require, 'telescope.builtin')
  if not ok then
    vim.notify('Telescope required for keymap picker', vim.log.levels.WARN)
    return
  end

  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'

  local keymaps = M.get_all_keymaps()

  pickers
    .new({}, {
      prompt_title = 'Plugin Keymaps',
      finder = finders.new_table {
        results = keymaps,
        entry_maker = function(entry)
          local cat = M.categories[entry.category] or { icon = '' }
          return {
            value = entry,
            display = string.format('%s %-15s %s (%s)', cat.icon, entry.key, entry.desc, entry.plugin),
            ordinal = entry.key .. ' ' .. entry.desc .. ' ' .. entry.plugin,
          }
        end,
      },
      sorter = conf.generic_sorter {},
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if selection then
            -- Execute the keymap
            local key = vim.api.nvim_replace_termcodes(selection.value.key, true, false, true)
            vim.api.nvim_feedkeys(key, 'n', false)
          end
        end)
        return true
      end,
    })
    :find()
end

return M
