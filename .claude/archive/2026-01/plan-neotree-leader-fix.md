# Plan: Fix Neo-tree Space/Leader Key Issue

## Problem
When focus is in Neo-tree, pressing `<Space>` (the leader key) is not registered properly. This breaks the workflow because leader-based keymaps don't work inside the Neo-tree window.

## Root Cause
Neo-tree uses `nowait = true` by default for its window mappings. Setting `['<Space>'] = 'none'` disables the action but may not properly release the key for leader sequences because the mapping still exists with `nowait`.

## Current Configuration
In `lua/plugins/navigation.lua`, space is disabled in two places:
- Line 60: `window.mappings['<Space>'] = 'none'`
- Line 79: `filesystem.window.mappings['<Space>'] = 'none'`

## Solution
Change the space mapping to explicitly set `nowait = false`, allowing Neovim to wait for additional keystrokes (like leader sequences):

```lua
['<Space>'] = { 'none', nowait = false }
```

This needs to be applied in both locations:
1. The main `window.mappings` section
2. The `filesystem.window.mappings` section

## Files to Modify
- `lua/plugins/navigation.lua` (lines 60 and 79)

## Implementation Steps
1. Change line 60 from:
   ```lua
   ['<Space>'] = 'none',
   ```
   to:
   ```lua
   ['<Space>'] = { 'none', nowait = false },
   ```

2. Change line 79 from:
   ```lua
   ['<Space>'] = 'none',
   ```
   to:
   ```lua
   ['<Space>'] = { 'none', nowait = false },
   ```

## Verification
1. Open Neovim and focus on Neo-tree (`:Neotree focus` or `\`)
2. Press `<Space>` - it should wait for the next key (timeout)
3. Test leader sequences like `<Space>et` to toggle Neo-tree, or `<Space>a` for harpoon
4. Ensure `<Enter>` still works normally in Neo-tree for opening files
