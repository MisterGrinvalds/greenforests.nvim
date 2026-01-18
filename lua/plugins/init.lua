-- Plugin specifications
-- Flattens all plugin modules into a single table for lazy.nvim

local specs = {}

local function is_single_spec(t)
  -- Single spec using 'dir' instead of [1]
  if t.dir then
    return true
  end

  -- A single spec has [1] as a string (plugin name) and possibly config keys
  -- A list of specs has [1] as a table or string that's a complete spec
  if type(t[1]) == 'string' then
    -- Check if it has lazy.nvim spec keys (indicating single spec)
    local has_spec_keys = t.config or t.opts or t.event or t.cmd or t.ft
      or t.keys or t.dependencies or t.lazy ~= nil or t.name or t.branch
    if has_spec_keys then
      return true
    end
    -- If [2] exists and is a table, it's a list of specs
    if t[2] and type(t[2]) == 'table' then
      return false
    end
    -- Single string with no other keys is a shorthand spec
    return not t[2]
  end
  -- If [1] is a table, it's a list of specs
  return false
end

local function add(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.notify('Failed to load ' .. module .. ': ' .. result, vim.log.levels.ERROR)
    return
  end

  if is_single_spec(result) then
    table.insert(specs, result)
  else
    -- List of specs - flatten
    for _, spec in ipairs(result) do
      table.insert(specs, spec)
    end
  end
end

-- Core functionality
add('plugins.telescope')
add('plugins.lsp')
add('plugins.treesitter')
add('plugins.completion')
add('plugins.formatting')

-- UI
add('plugins.colorscheme')
add('plugins.ui')
add('plugins.bufferline')
add('plugins.statusline')

-- Git
add('plugins.git')

-- Navigation
add('plugins.navigation')

-- Editing
add('plugins.editing')

-- Diagnostics
add('plugins.diagnostics')

-- Terminal
add('plugins.terminal')

-- Tools
add('plugins.claude-code')
add('plugins.docusaurus')
add('plugins.plugin-help')

-- Session management
add('plugins.persistence')
add('plugins.acorn')

return specs
