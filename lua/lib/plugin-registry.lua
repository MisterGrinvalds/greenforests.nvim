-- Plugin Registry
-- Pre-registers all plugins with the help system
-- Add new plugins here when integrating them

local help = require 'lib.plugin-help'

-- Navigation plugins
help.register {
  name = 'telescope',
  category = 'navigation',
  description = 'Fuzzy finder for files, buffers, grep, and more',
  keymaps = {
    { key = '<leader>sf', desc = 'Search files', mode = 'n' },
    { key = '<leader>sg', desc = 'Search by grep', mode = 'n' },
    { key = '<leader>sw', desc = 'Search current word', mode = 'n' },
    { key = '<leader>sb', desc = 'Search buffers', mode = 'n' },
    { key = '<leader>sh', desc = 'Search help', mode = 'n' },
    { key = '<leader>sk', desc = 'Search keymaps', mode = 'n' },
    { key = '<leader>ss', desc = 'Search select telescope', mode = 'n' },
    { key = '<leader>sd', desc = 'Search diagnostics', mode = 'n' },
    { key = '<leader>sr', desc = 'Resume last search', mode = 'n' },
    { key = '<leader>s.', desc = 'Search recent files', mode = 'n' },
    { key = '<leader>sc', desc = 'Search commands', mode = 'n' },
    { key = '<leader>:', desc = 'Command history', mode = 'n' },
    { key = '<leader>/', desc = 'Fuzzily search in buffer', mode = 'n' },
  },
  commands = {
    { cmd = 'Telescope', desc = 'Open Telescope picker' },
  },
  tips = {
    'Use <C-q> to send results to quickfix list',
    'Press <C-/> in insert mode to see picker keymaps',
    'Use <leader>sr to resume your last search',
  },
}

help.register {
  name = 'harpoon',
  category = 'navigation',
  description = 'Quick file marks for fast navigation',
  keymaps = {
    { key = '<leader>a', desc = 'Add file to harpoon', mode = 'n' },
    { key = '<leader>m', desc = 'Toggle harpoon menu', mode = 'n' },
    { key = '<leader>1', desc = 'Jump to harpoon file 1', mode = 'n' },
    { key = '<leader>2', desc = 'Jump to harpoon file 2', mode = 'n' },
    { key = '<leader>3', desc = 'Jump to harpoon file 3', mode = 'n' },
    { key = '<leader>4', desc = 'Jump to harpoon file 4', mode = 'n' },
  },
  commands = {},
  tips = {
    'Use <leader>a to mark files you frequently switch between',
    'Marks are project-specific and persist across sessions',
    'Reorder marks in the menu by moving lines',
  },
}

-- Git plugins
help.register {
  name = 'gitsigns',
  category = 'git',
  description = 'Git change indicators and hunk operations',
  keymaps = {
    { key = ']c', desc = 'Next git hunk', mode = 'n' },
    { key = '[c', desc = 'Previous git hunk', mode = 'n' },
    { key = '<leader>gs', desc = 'Stage hunk', mode = { 'n', 'v' } },
    { key = '<leader>gr', desc = 'Reset hunk', mode = { 'n', 'v' } },
    { key = '<leader>gS', desc = 'Stage buffer', mode = 'n' },
    { key = '<leader>gu', desc = 'Undo stage hunk', mode = 'n' },
    { key = '<leader>gR', desc = 'Reset buffer', mode = 'n' },
    { key = '<leader>gp', desc = 'Preview hunk', mode = 'n' },
    { key = '<leader>gb', desc = 'Blame line', mode = 'n' },
    { key = '<leader>gB', desc = 'Toggle blame', mode = 'n' },
  },
  commands = {
    { cmd = 'Gitsigns', desc = 'Gitsigns commands' },
  },
  tips = {
    'Use ]c and [c to navigate between changes',
    'Stage individual hunks with <leader>gs',
    'Preview what changed with <leader>gp',
  },
}

help.register {
  name = 'lazygit',
  category = 'git',
  description = 'Terminal UI for git',
  keymaps = {
    { key = '<leader>gg', desc = 'Open lazygit', mode = 'n' },
  },
  commands = {
    { cmd = 'LazyGit', desc = 'Open lazygit' },
  },
  tips = {
    'Press ? in lazygit for keybindings help',
    'Space to stage/unstage files',
    'c to commit, P to push',
  },
}

help.register {
  name = 'diffview',
  category = 'git',
  description = 'Diff viewer for git changes',
  keymaps = {
    { key = '<leader>gd', desc = 'Open diffview', mode = 'n' },
    { key = '<leader>gh', desc = 'File history', mode = 'n' },
  },
  commands = {
    { cmd = 'DiffviewOpen', desc = 'Open diff view' },
    { cmd = 'DiffviewFileHistory', desc = 'View file history' },
    { cmd = 'DiffviewClose', desc = 'Close diff view' },
  },
  tips = {
    'Use :DiffviewOpen HEAD~3 to compare with 3 commits ago',
    'Press g? in diffview for keybindings',
  },
}

-- LSP/Code plugins
help.register {
  name = 'trouble',
  category = 'lsp',
  description = 'Pretty list for diagnostics and references',
  keymaps = {
    { key = '<leader>xx', desc = 'Toggle trouble', mode = 'n' },
    { key = '<leader>xw', desc = 'Workspace diagnostics', mode = 'n' },
    { key = '<leader>xd', desc = 'Document diagnostics', mode = 'n' },
    { key = '<leader>xq', desc = 'Quickfix list', mode = 'n' },
    { key = '<leader>xl', desc = 'Location list', mode = 'n' },
  },
  commands = {
    { cmd = 'Trouble', desc = 'Toggle trouble window' },
    { cmd = 'TroubleToggle', desc = 'Toggle trouble window' },
  },
  tips = {
    'Use <leader>xx to quickly see all diagnostics',
    'Press m to toggle between modes',
    'Press o to jump to location and close',
  },
}

-- Terminal plugins
help.register {
  name = 'terminal-manager',
  category = 'terminal',
  description = 'Multiple named terminal sessions',
  keymaps = {
    { key = '<leader>t', desc = 'Open terminal picker', mode = 'n' },
    { key = '<leader>tt', desc = 'Toggle last terminal', mode = 'n' },
    { key = '<leader>tn', desc = 'New terminal', mode = 'n' },
    { key = '<leader>tg', desc = 'Git terminal', mode = 'n' },
    { key = '<leader>td', desc = 'Dev terminal', mode = 'n' },
  },
  commands = {
    { cmd = 'TerminalToggle', desc = 'Toggle terminal' },
    { cmd = 'TerminalNew', desc = 'Create new terminal' },
    { cmd = 'TerminalPick', desc = 'Pick a terminal' },
  },
  tips = {
    'Create named terminals for different tasks',
    'Use <leader>tg for a dedicated git terminal',
    'Terminals persist when hidden',
  },
}

-- UI plugins
help.register {
  name = 'bufferline',
  category = 'ui',
  description = 'Buffer tabs with icons',
  keymaps = {
    { key = '<S-h>', desc = 'Previous buffer', mode = 'n' },
    { key = '<S-l>', desc = 'Next buffer', mode = 'n' },
    { key = '[b', desc = 'Previous buffer', mode = 'n' },
    { key = ']b', desc = 'Next buffer', mode = 'n' },
    { key = '<leader>bp', desc = 'Pin buffer', mode = 'n' },
    { key = '<leader>bP', desc = 'Close unpinned', mode = 'n' },
    { key = '<leader>bj', desc = 'Pick buffer', mode = 'n' },
  },
  commands = {
    { cmd = 'BufferLinePick', desc = 'Pick a buffer' },
    { cmd = 'BufferLinePickClose', desc = 'Pick buffer to close' },
  },
  tips = {
    'Use Shift+H/L to quickly switch buffers',
    'Pin important buffers with <leader>bp',
    'Use <leader>bj to visually pick a buffer',
  },
}

-- Editing plugins
help.register {
  name = 'comment',
  category = 'editing',
  description = 'Toggle comments with motions',
  keymaps = {
    { key = 'gcc', desc = 'Toggle line comment', mode = 'n' },
    { key = 'gc', desc = 'Toggle comment (motion)', mode = { 'n', 'v' } },
    { key = 'gbc', desc = 'Toggle block comment', mode = 'n' },
    { key = 'gb', desc = 'Toggle block comment (motion)', mode = { 'n', 'v' } },
  },
  commands = {},
  tips = {
    'Use gcc to quickly comment a line',
    'Use gc + motion (e.g., gcap) for paragraphs',
    'Visual select then gc to comment selection',
  },
}

-- Utility plugins
help.register {
  name = 'which-key',
  category = 'utility',
  description = 'Popup with keybinding hints',
  keymaps = {},
  commands = {
    { cmd = 'WhichKey', desc = 'Show all keymaps' },
  },
  tips = {
    'Press <leader> and wait to see available keys',
    'Works with any prefix like g, z, [, ]',
    'Press <BS> to go back a level',
  },
}

help.register {
  name = 'smart-splits',
  category = 'utility',
  description = 'Seamless navigation with terminal multiplexers',
  keymaps = {
    { key = '<C-h>', desc = 'Move to left split', mode = 'n' },
    { key = '<C-j>', desc = 'Move to below split', mode = 'n' },
    { key = '<C-k>', desc = 'Move to above split', mode = 'n' },
    { key = '<C-l>', desc = 'Move to right split', mode = 'n' },
    { key = '<A-h>', desc = 'Resize left', mode = 'n' },
    { key = '<A-j>', desc = 'Resize down', mode = 'n' },
    { key = '<A-k>', desc = 'Resize up', mode = 'n' },
    { key = '<A-l>', desc = 'Resize right', mode = 'n' },
  },
  commands = {},
  tips = {
    'Ctrl+hjkl moves between splits AND tmux panes',
    'Alt+hjkl resizes windows',
    'Works with tmux, wezterm, and kitty',
  },
}

-- Treesitter plugins
help.register {
  name = 'treesitter-context',
  category = 'treesitter',
  description = 'Show current function at top of buffer',
  keymaps = {},
  commands = {
    { cmd = 'TSContextToggle', desc = 'Toggle context display' },
  },
  tips = {
    'Helps navigate long functions',
    'Click the context line to jump there',
  },
}

-- Documentation plugins
help.register {
  name = 'docusaurus',
  category = 'utility',
  description = 'Docusaurus documentation editing with version-aware insertion',
  keymaps = {
    { key = '<leader>Dc', desc = 'Insert component', mode = 'n' },
    { key = '<leader>Dp', desc = 'Insert partial', mode = 'n' },
    { key = '<leader>Db', desc = 'Insert code block', mode = 'n' },
    { key = '<leader>Du', desc = 'Insert URL/link', mode = 'n' },
    { key = '<leader>Dn', desc = 'Create new plugin', mode = 'n' },
    { key = '<leader>Da', desc = 'Browse API docs', mode = 'n' },
  },
  commands = {
    { cmd = 'DocusaurusInsertComponent', desc = 'Insert React component with import' },
    { cmd = 'DocusaurusInsertPartial', desc = 'Insert partial with smart import' },
    { cmd = 'DocusaurusInsertCodeBlock', desc = 'Insert code block with raw-loader' },
    { cmd = 'DocusaurusInsertURL', desc = 'Insert markdown link' },
    { cmd = 'DocusaurusCreatePlugin', desc = 'Scaffold new Docusaurus plugin' },
    { cmd = 'DocusaurusBrowseAPI', desc = 'Browse Docusaurus config API' },
  },
  tips = {
    'All keymaps use <leader>D prefix',
    'Version-aware: filters content by current doc version',
    'Smart imports: auto-detects @site vs relative paths',
    'Does NOT include dev server - use npm start in terminal',
  },
}

return {
  setup = function()
    -- Registry is loaded when this module is required
    -- All plugins are registered via help.register() above
  end,
}
