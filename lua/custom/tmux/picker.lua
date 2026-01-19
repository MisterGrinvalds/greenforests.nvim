-- Telescope picker for tmux windows
local M = {}

--- Create a previewer that shows tmux window content
local function tmux_previewer()
  local previewers = require('telescope.previewers')
  local putils = require('telescope.previewers.utils')

  return previewers.new_buffer_previewer({
    title = 'Window Preview',
    define_preview = function(self, entry, status)
      -- Capture the pane content from the tmux window
      local cmd = string.format('tmux capture-pane -t :%s -p -S -50', entry.value.index)
      local handle = io.popen(cmd)
      if not handle then
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, { 'Failed to capture pane' })
        return
      end

      local content = handle:read('*a')
      handle:close()

      local lines = vim.split(content, '\n', { trimempty = false })

      -- Set buffer content
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)

      -- Try to detect filetype for syntax highlighting
      putils.highlighter(self.state.bufnr, 'bash')
    end,
  })
end

--- Show tmux window picker
function M.show()
  local tmux = require('custom.tmux')

  if not tmux.is_tmux() then
    vim.notify('Not running inside tmux', vim.log.levels.ERROR)
    return
  end

  local windows = tmux.window.list()

  if #windows == 0 then
    vim.notify('No tmux windows found', vim.log.levels.WARN)
    return
  end

  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  local entry_display = require('telescope.pickers.entry_display')

  local displayer = entry_display.create({
    separator = ' ',
    items = {
      { width = 3 },   -- Window index
      { width = 20 },  -- Window name
      { width = 8 },   -- Status
    },
  })

  local make_display = function(entry)
    local status = entry.active and '' or ''
    local idx = tostring(entry.index)

    return displayer({
      { idx, 'TelescopeResultsNumber' },
      { entry.name, 'TelescopeResultsIdentifier' },
      { status, entry.active and 'TelescopeResultsFunction' or 'TelescopeResultsComment' },
    })
  end

  pickers
    .new({
      prompt_title = ' tmux Windows',
      results_title = 'Windows',
      preview_title = 'Pane Content',
      finder = finders.new_table({
        results = windows,
        entry_maker = function(entry)
          return {
            value = entry,
            display = make_display,
            ordinal = entry.name .. ' ' .. entry.index,
            index = entry.index,
            name = entry.name,
            active = entry.active,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      previewer = tmux_previewer(),
      layout_strategy = 'horizontal',
      layout_config = {
        horizontal = {
          preview_width = 0.6,
          width = 0.8,
          height = 0.8,
        },
      },
      attach_mappings = function(prompt_bufnr, map)
        -- Default: goto window
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          if selection then
            tmux.window.goto(selection.value.index)
          end
        end)

        -- Ctrl-x: delete window
        map('i', '<c-x>', function()
          local selection = action_state.get_selected_entry()
          if selection and #windows > 1 then
            actions.close(prompt_bufnr)
            tmux.window.delete(selection.value.index)
          else
            vim.notify("Can't delete last window", vim.log.levels.WARN)
          end
        end)

        -- Ctrl-r: rename window
        map('i', '<c-r>', function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          if selection then
            vim.ui.input({ prompt = 'New name: ', default = selection.value.name }, function(name)
              if name and name ~= '' then
                tmux.window.goto(selection.value.index)
                tmux.window.rename(name)
              end
            end)
          end
        end)

        -- Ctrl-n: new window
        map('i', '<c-n>', function()
          actions.close(prompt_bufnr)
          vim.ui.input({ prompt = 'Window name: ' }, function(name)
            if name and name ~= '' then
              tmux.window.create(name)
              tmux.window.goto(name)
            end
          end)
        end)

        return true
      end,
    })
    :find()
end

--- Show repository picker and open in new tmux window
--- Mimics the shell `trepo` function
---@param opts table|nil Options (repos_dir, max_depth)
function M.trepo(opts)
  opts = opts or {}
  local repos_dir = opts.repos_dir or vim.env.TMUX_REPOS_DIR or vim.env.HOME .. '/Repos'
  local max_depth = opts.max_depth or 4

  local tmux = require('custom.tmux')

  if not tmux.is_tmux() then
    vim.notify('Not running inside tmux', vim.log.levels.ERROR)
    return
  end

  -- Check if repos directory exists
  if vim.fn.isdirectory(repos_dir) ~= 1 then
    vim.notify('Repos directory not found: ' .. repos_dir, vim.log.levels.ERROR)
    return
  end

  -- Find all git repositories
  local cmd = string.format(
    'find %s -maxdepth %d -type d -name ".git" 2>/dev/null | sed "s|/\\.git$||" | sort',
    vim.fn.shellescape(repos_dir),
    max_depth
  )
  local handle = io.popen(cmd)
  if not handle then
    vim.notify('Failed to find repositories', vim.log.levels.ERROR)
    return
  end

  local result = handle:read('*a')
  handle:close()

  local repos = {}
  for line in result:gmatch('[^\n]+') do
    local display_name = line:gsub('^' .. vim.pesc(repos_dir) .. '/', '')
    table.insert(repos, {
      path = line,
      display = display_name,
      name = vim.fn.fnamemodify(line, ':t'),
    })
  end

  if #repos == 0 then
    vim.notify('No git repositories found in ' .. repos_dir, vim.log.levels.WARN)
    return
  end

  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')

  pickers
    .new({
      prompt_title = ' Open Repo in tmux',
      results_title = 'Repositories',
      finder = finders.new_table({
        results = repos,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry.display,
            ordinal = entry.display,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      previewer = false,
      layout_config = {
        width = 0.6,
        height = 0.6,
      },
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          if selection then
            local repo = selection.value
            tmux.window.create(repo.name, { cwd = repo.path })
            vim.notify('Opened window "' .. repo.name .. '" in ' .. repo.path, vim.log.levels.INFO)
          end
        end)

        return true
      end,
    })
    :find()
end

return M
