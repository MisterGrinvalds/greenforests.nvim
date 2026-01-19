-- Obsidian.nvim - Write and navigate Obsidian vaults in Neovim
-- https://github.com/epwalsh/obsidian.nvim
local fork = require('lib.forks').fork

return {
  fork 'epwalsh/obsidian.nvim',
  version = '*',
  ft = 'markdown',
  dependencies = {
    fork 'nvim-lua/plenary.nvim',
  },
  opts = {
    -- Configure your vault(s) here
    workspaces = {
      {
        name = 'notes',
        path = vim.env.OBSIDIAN_VAULT or '~/Notes',
      },
    },

    -- Note naming: use title as filename
    note_id_func = function(title)
      if title ~= nil then
        -- Clean title for filename
        return title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      else
        -- Generate random ID if no title
        return tostring(os.time())
      end
    end,

    -- Daily notes configuration
    daily_notes = {
      folder = 'daily',
      date_format = '%Y-%m-%d',
      template = nil,
    },

    -- Completion settings
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    -- UI settings
    ui = {
      enable = true,
      checkboxes = {
        [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
        ['x'] = { char = '', hl_group = 'ObsidianDone' },
        ['>'] = { char = '', hl_group = 'ObsidianRightArrow' },
        ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
      },
    },

    -- Use telescope for picking
    picker = {
      name = 'telescope.nvim',
    },

    -- Follow links on gf
    follow_url_func = function(url)
      vim.fn.jobstart({ 'open', url })
    end,
  },
  keys = {
    { '<leader>on', '<cmd>ObsidianNew<CR>', desc = '[O]bsidian [N]ew note' },
    { '<leader>oo', '<cmd>ObsidianQuickSwitch<CR>', desc = '[O]bsidian [O]pen note' },
    { '<leader>of', '<cmd>ObsidianFollowLink<CR>', desc = '[O]bsidian [F]ollow link' },
    { '<leader>ob', '<cmd>ObsidianBacklinks<CR>', desc = '[O]bsidian [B]acklinks' },
    { '<leader>ot', '<cmd>ObsidianToday<CR>', desc = '[O]bsidian [T]oday' },
    { '<leader>oy', '<cmd>ObsidianYesterday<CR>', desc = '[O]bsidian [Y]esterday' },
    { '<leader>os', '<cmd>ObsidianSearch<CR>', desc = '[O]bsidian [S]earch' },
    { '<leader>ol', '<cmd>ObsidianLinks<CR>', desc = '[O]bsidian [L]inks' },
    { '<leader>or', '<cmd>ObsidianRename<CR>', desc = '[O]bsidian [R]ename' },
    { '<leader>oc', '<cmd>ObsidianToggleCheckbox<CR>', desc = '[O]bsidian toggle [C]heckbox' },
    { '<leader>op', '<cmd>ObsidianPasteImg<CR>', desc = '[O]bsidian [P]aste image' },
    -- Visual mode: create link from selection
    { '<leader>ol', ':ObsidianLink<CR>', mode = 'v', desc = '[O]bsidian [L]ink selection' },
    { '<leader>oe', ':ObsidianLinkNew<CR>', mode = 'v', desc = '[O]bsidian link to n[E]w note' },
  },
}
