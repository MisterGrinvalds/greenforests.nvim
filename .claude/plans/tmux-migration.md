# tmux.nvim Migration Plan

**Goal:** Replace embedded `custom/tmux` with `tmux.nvim` dependency

## Overview

Currently greenforests.nvim has tmux functionality embedded in `lua/custom/tmux/`. This should be replaced with the standalone `tmux.nvim` plugin to:
- Eliminate duplicate code
- Allow other plugins (command-palette.nvim, claude-code.nvim) to depend on it
- Provide a single source of truth for tmux integration

## Step 1: Update terminal.lua plugin spec

**File:** `lua/plugins/terminal.lua`

```lua
-- BEFORE
return {
  dir = vim.fn.stdpath 'config' .. '/lua/custom/tmux',
  name = 'tmux-wrapper',
  lazy = false,
  config = function()
    local tmux = require('custom.tmux')
    if not tmux.is_tmux() then
      return
    end
    -- ... keymaps
  end,
}

-- AFTER
return {
  dir = '/Users/mistergrinvalds/Repos/personal/tmux.nvim',
  name = 'tmux.nvim',
  lazy = false,
  config = function()
    require('tmux').setup({
      alerts = { enabled = true },
      keymaps = '<leader>t',
    })
  end,
}
```

## Step 2: Delete custom/tmux directory

**Delete entire directory:** `lua/custom/tmux/`

Files to remove:
- `lua/custom/tmux/init.lua`
- `lua/custom/tmux/window.lua`
- `lua/custom/tmux/session.lua`
- `lua/custom/tmux/picker.lua`
- `lua/custom/tmux/utils.lua`

## Step 3: Verify keymaps match

The new tmux.nvim with `keymaps = '<leader>t'` provides these default keymaps:

| Old Keymap | New Keymap | Action | Status |
|------------|------------|--------|--------|
| `<leader>tp` | `<leader>tp` | Window picker | ✓ Same |
| - | `<leader>ts` | Session picker | NEW |
| `<leader>tn` | `<leader>tn` | New window | ✓ Same |
| `<leader>tr` | `<leader>tr` | Rename window | ✓ Same |
| `<leader>tx` | `<leader>tx` | Delete window | ✓ Same |
| `<leader>th` | `<leader>th` | Previous window | ✓ Same |
| `<leader>tl` | `<leader>tl` | Next window | ✓ Same |
| - | `<leader>tL` | Last window | NEW |
| `<leader>tm` | `<leader>tm` | Toggle pane zoom | ✓ Same |
| `<leader>t\|` | `<leader>t\|` | Split vertical | ✓ Same |
| `<leader>t-` | `<leader>t-` | Split horizontal | ✓ Same |
| `<leader>tc` | - | Create with command | MISSING |
| `<leader>ts` (visual) | `<leader>tS` (visual) | Send selection | Changed |

**Action needed:** If `<leader>tc` (create window with command) is important, add it manually in the config function.

## Step 4: Test

After migration, verify:
- [ ] `:Tmux windows` opens picker
- [ ] `<leader>tp` opens window picker
- [ ] `<leader>tn` creates new window
- [ ] `<leader>tr` renames window
- [ ] `<leader>tx` deletes window
- [ ] `<leader>th/tl` navigates windows
- [ ] `<leader>tm` toggles pane zoom
- [ ] Splits work

## Execution

```bash
# 1. Update terminal.lua (manually or via editor)
# 2. Delete custom/tmux
rm -rf lua/custom/tmux/

# 3. Restart Neovim and test
```

## Dependencies

After this migration:
- greenforests.nvim depends on tmux.nvim
- command-palette.nvim can depend on tmux.nvim (instead of custom.tmux)
- claude-code.nvim can depend on tmux.nvim (for alerts)
