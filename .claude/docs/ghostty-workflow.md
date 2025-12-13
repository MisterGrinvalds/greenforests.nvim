# Claude Code + Neovim + Ghostty Workflow

Source: https://danielmiessler.com/blog/claude-code-neovim-ghostty-integration

## Overview

A three-pane terminal workflow that eliminates the need for VS Code/Cursor while keeping your Neovim setup:

```
┌─────────────────┬─────────────────┐
│                 │                 │
│   Claude Code   │     Neovim      │
│                 │                 │
│                 │                 │
├─────────────────┴─────────────────┤
│            Terminal               │
└───────────────────────────────────┘
```

- **Left pane**: Claude Code (AI assistant)
- **Right pane**: Neovim (your editor)
- **Bottom pane**: Terminal (for running commands)

## Why This Works

- Preserves your existing Neovim configuration
- Keeps vim muscle memory intact
- AI assistance is always visible but not intrusive
- Seamless navigation with Ctrl+hjkl

## Ghostty Configuration

Add to `~/.config/ghostty/config`:

```toml
# Pane navigation with vim-style keys
keybind = ctrl+h=goto_split:left
keybind = ctrl+j=goto_split:bottom
keybind = ctrl+k=goto_split:top
keybind = ctrl+l=goto_split:right

# Recommended: Create splits
keybind = ctrl+shift+d=new_split:right
keybind = ctrl+shift+enter=new_split:down

# Recommended: Close split
keybind = ctrl+shift+w=close_surface
```

## Potential Keybinding Conflict

**Important**: Neovim's default kickstart config uses `Ctrl+hjkl` for window navigation within Neovim. When using Ghostty with these keybindings:

1. Inside Neovim, `Ctrl+hjkl` will navigate Ghostty panes (not Neovim windows)
2. Use `<C-w>hjkl` for Neovim window navigation instead, OR
3. Remap Neovim window navigation to different keys

### Option A: Keep Ghostty priority (Recommended)

Remove or comment out these lines in `init.lua`:

```lua
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
```

Use `<C-w>h/j/k/l` for Neovim windows instead.

### Option B: Use different keys for Ghostty

Change Ghostty config to use Alt instead:

```toml
keybind = alt+h=goto_split:left
keybind = alt+j=goto_split:bottom
keybind = alt+k=goto_split:top
keybind = alt+l=goto_split:right
```

## Workflow

1. Open Ghostty
2. Create right split: `Ctrl+Shift+D`
3. Create bottom split in left pane: `Ctrl+Shift+Enter`
4. Left pane: Run `claude` (Claude Code)
5. Right pane: Run `nvim`
6. Bottom pane: Use for git, tests, builds
7. Navigate with `Ctrl+hjkl`

## iTerm2 Alternative

If using iTerm2 instead of Ghostty, similar setup:

1. Preferences > Keys > Key Bindings
2. Add shortcuts for "Select Split Pane" actions
3. Or use iTerm2's default: `Cmd+Opt+Arrow` for pane navigation

## Tips

- "The best integrations don't feel like integrations"
- Keep Claude Code visible while editing in Neovim
- Ask Claude to edit files, then `:e` to reload in Neovim
- Use the terminal pane for running tests/builds Claude suggests
