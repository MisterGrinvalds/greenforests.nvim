# Neovim Configuration Session State - 2025-12-13

## Repositories

### kickstart.nvim
- **Path:** `/Users/mistergrinvalds/Repos/personal/kickstart.nvim`
- **Status:** Modified, uncommitted changes in `init.lua` (command palette keymaps)

### claude-code.nvim
- **Path:** `/Users/mistergrinvalds/Repos/personal/claude-code.nvim`
- **Status:** Clean, all committed

---

## Uncommitted Changes

### init.lua (kickstart.nvim)
Added command palette keymaps:
```lua
vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader>:', builtin.command_history, { desc = 'Command History' })
```

---

## Installed Plugins

| Plugin | File | Purpose |
|--------|------|---------|
| neo-tree | kickstart built-in | File explorer (`\`) |
| autopairs | kickstart built-in | Auto-close brackets |
| indent-blankline | kickstart built-in | Indent guides |
| Comment.nvim | `comment.lua` | Toggle comments (`gcc`, `gc`) |
| harpoon | `harpoon.lua` | Quick file marks (`<Space>1-4`) |
| lazygit.nvim | `lazygit.lua` | Git TUI (`<Space>gg`) |
| trouble.nvim | `trouble.lua` | Better diagnostics (`<Space>xx`) |
| diffview.nvim | `diffview.lua` | Git diffs (`<Space>gd`) |
| treesitter-context | `treesitter-context.lua` | Show function context |
| bufferline.nvim | `bufferline.lua` | Buffer tabs (Shift+H/L) |
| scope.nvim | `scope.lua` | Tab-scoped buffers |
| smart-splits.nvim | `smart-splits.lua` | Pane navigation (Ctrl+hjkl) |
| claude-code.nvim | `claude-code.lua` | Claude Code integration |

---

## Configuration Changes Made

### Basic Options
- Nerd Font enabled (`have_nerd_font = true`)
- Relative line numbers enabled
- Winbar enabled (shows file path at top of splits)

### Keymaps Added
- `<Space>w` - Save file
- `<Alt>j/k` - Move lines up/down
- `</>` in visual - Indent keeping selection
- `<Space>sc` - Command palette
- `<Space>:` - Command history

### LSP Configured
- Python (pyright + black + isort)
- TypeScript/JavaScript (ts_ls + prettier)
- Go (gopls + goimports)
- Lua (lua_ls + stylua)

### Colorscheme
- catppuccin-mocha

### Treesitter
- Added: css, javascript, typescript, tsx, json, python, go, gomod, gosum
- Incremental selection enabled (Ctrl+Space)

---

## Keybinding Reference

### General
| Key | Action |
|-----|--------|
| `<Space>w` | Save file |
| `<Space>sc` | Command palette |
| `<Space>:` | Command history |
| `\` | Toggle neo-tree |

### Buffers
| Key | Action |
|-----|--------|
| `Shift+H/L` | Prev/Next buffer |
| `<Space>bj` | Jump to buffer (visual picker) |
| `<Space>bd` | Delete buffer |
| `<Space>bp` | Pin buffer |
| `<Space><Space>` | Fuzzy find buffers |

### Tabs
| Key | Action |
|-----|--------|
| `<Space>tn` | New tab |
| `<Space>tc` | Close tab |
| `]t` / `[t` | Next/Prev tab |

### Harpoon
| Key | Action |
|-----|--------|
| `<Space>a` | Add file |
| `<Space>e` | Menu |
| `<Space>1-4` | Jump to file |

### Git
| Key | Action |
|-----|--------|
| `<Space>gg` | Lazygit |
| `<Space>gd` | Diffview |
| `<Space>gh` | File history |

### Diagnostics
| Key | Action |
|-----|--------|
| `<Space>xx` | All diagnostics |
| `<Space>xX` | Buffer diagnostics |

### Claude Code
| Key | Action |
|-----|--------|
| `<Space>cc` | Toggle Claude window |
| `<Space>cp` | Command palette |
| `<Space>ca` | Ask Claude |
| `<Space>cf` | Send file |
| `<Space>cs` | Send selection |
| `<Space>cd` | Send diagnostics |
| `:ClaudeCurrent` | Open in current window |

### Navigation (smart-splits)
| Key | Action |
|-----|--------|
| `Ctrl+hjkl` | Navigate splits |
| `Alt+hjkl` | Resize splits |
| `<Space>whjkl` | Swap buffers |

### Terminal (Claude Code pane)
| Key | Action |
|-----|--------|
| `<Esc>` | Passes to Claude |
| `<Esc><Esc>` | Exit to Neovim normal mode |

---

## External Tools Installed

- JetBrainsMono Nerd Font
- lazygit
- Ghostty terminal (configured)

### Ghostty Config (`~/.config/ghostty/config`)
- Font: JetBrainsMono Nerd Font
- Theme: catppuccin-mocha
- Pane navigation: Ctrl+hjkl

---

## Claude Agents

| Command | Purpose |
|---------|---------|
| `/nvim-config` | Interactive configuration assistant |
| `/nvim-research` | Plugin research and recommendations |

---

## Git Commit History

### claude-code.nvim
```
72f00d7 feat: add open in current window command
6d0bec6 docs: add README with installation and usage
1fdfac0 feat: initial plugin core
```

### kickstart.nvim (recent)
```
fc8f3a7 feat: add buffer jump, winbar, and tab management
87a3f27 feat: add smart-splits for seamless pane navigation
dcb2f3d feat: enhance base config
d7787d7 feat: add Claude Code integration plugin
e6cc066 feat: add buffer management plugins
e0a2fbc feat: add diagnostic and git diff plugins
77edbe3 feat: add editing and navigation plugins
75fa982 feat: add Claude agents for nvim config and research
```

---

## Next Steps / TODO

1. Commit command palette keymaps to kickstart.nvim
2. Publish claude-code.nvim to GitHub
3. Consider adding: oil.nvim, flash.nvim, noice.nvim
