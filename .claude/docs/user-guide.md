---
sidebar_position: 1
title: User Guide
description: Complete guide to understanding and using this Neovim configuration
---

# Neovim Setup - User Guide

A comprehensive guide to understanding and using this Neovim configuration.

## Philosophy

This Neovim configuration is built around three core principles:

### 1. Keyboard-First, Mouse-Never

Everything is accessible via keyboard shortcuts. The goal is to keep your hands on the home row and your focus on the code.

### 2. Discoverability Over Memorization

- **Command Palette** (`<leader>p`) - Search for any command
- **Which-key** - Shows available keybindings as you type
- **Telescope** - Fuzzy find everything

You don't need to memorize hundreds of shortcuts. Just remember `<leader>p` and search for what you need.

### 3. Context-Aware Intelligence

The setup adapts to what you're doing:
- LSP actions appear when editing code
- Git commands show up in git repos
- Project-specific tools (npm, cargo, etc.) auto-detect

---

## Setup Overview

### Architecture

```
greenforests.nvim/
├── init.lua                    # Main configuration
├── lua/
│   └── custom/
│       └── plugins/            # Custom plugin configurations
│           ├── command-palette.lua
│           ├── terminal-manager.lua
│           ├── claude-code.lua
│           └── ... (other plugins)
└── .claude/
    └── docs/                   # Documentation (you are here!)
```

### Core Components

**1. Base Configuration (init.lua)**
- Options (line numbers, indentation, etc.)
- Keymaps (basic navigation, editing)
- LSP setup (code intelligence)
- Treesitter (syntax highlighting)

**2. Plugin Manager (Lazy.nvim)**
- Automatic plugin installation
- Lazy loading for performance
- Easy updates with `:Lazy`

**3. Custom Plugins**
- Command Palette - Central command hub
- Terminal Manager - Multiple terminal sessions
- Claude Code - AI assistance
- Plus community plugins (see [Plugin Guide](./plugin-guide))

---

## Core Concepts

### The Leader Key

`<leader>` is your command namespace, mapped to `<Space>`.

:::info Why Space?
- Easy to reach with either thumb
- Doesn't conflict with default Vim bindings
- Mnemonic: "Space" to "take action"
:::

**Pattern:**
```
<leader> + category + action
<leader>f + f = Find File
<leader>g + g = Git (lazygit)
<leader>t + t = Terminal Toggle
```

### Modal Editing

Neovim has different modes for different tasks:

- **Normal Mode** (Esc) - Navigate and manipulate text
- **Insert Mode** (i) - Type text
- **Visual Mode** (v) - Select text
- **Command Mode** (:) - Execute commands

:::tip Rule of Thumb
Spend most time in Normal mode, dart into Insert mode to make changes, then back to Normal.
:::

### Fuzzy Finding with Telescope

Telescope is your search interface. It can find:
- Files (`<leader>ff`)
- Text in files (`<leader>fg`)
- Commands (`<leader>sc`)
- Recent files (`<leader>s.`)
- And much more...

**Usage pattern:**
1. Trigger Telescope with a keymap
2. Start typing (fuzzy matching works!)
3. Use `<C-n>`/`<C-p>` or arrow keys to navigate
4. Press `<Enter>` to select

### LSP (Language Server Protocol)

LSP provides IDE-like features:
- Auto-completion
- Go to definition
- Find references
- Rename symbol
- Show errors/warnings

:::note Key Insight
LSP works across languages (TypeScript, Python, Go, Rust, etc.)
:::

---

## Getting Started

### Day 1: Basic Navigation

#### File Navigation

| Keymap | Action |
|--------|--------|
| `<leader>ff` | Find files in project |
| `<leader>s.` | Recent files |
| `<leader>fg` | Search text in project |
| `\` | Toggle file tree (neo-tree) |

#### Buffer Navigation

| Keymap | Action |
|--------|--------|
| `Shift+Y` | Previous buffer (like browser back) |
| `Shift+U` | Next buffer (like browser forward) |
| `<leader>bd` | Delete buffer (close file) |
| `<leader><Space>` | Fuzzy find open buffers |

#### Window Navigation

| Keymap | Action |
|--------|--------|
| `Ctrl+h/j/k/l` | Move between splits (works with tmux/ghostty!) |
| `<leader>sv` | Split vertically |
| `<leader>sh` | Split horizontally |

:::tip Exercise
Open Neovim, press `<leader>ff`, find a file, open it, navigate with `j/k`, then `<leader>s.` to see recent files.
:::

### Day 2: Editing Basics

#### Text Manipulation

| Keymap | Action |
|--------|--------|
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `o` | New line below |
| `O` | New line above |
| `dd` | Delete line |
| `yy` | Copy line |
| `p` | Paste |
| `u` | Undo |
| `Ctrl+r` | Redo |

#### With Motions

| Command | Action |
|---------|--------|
| `diw` | Delete inner word |
| `ci"` | Change inside quotes |
| `yap` | Yank (copy) a paragraph |

#### Custom Shortcuts

| Keymap | Action |
|--------|--------|
| `<leader>w` | Save file |
| `Alt+j/k` | Move lines up/down |
| `</>` (visual) | Indent/dedent (keeps selection) |
| `gcc` | Toggle comment (Comment.nvim) |

:::tip Exercise
Edit a file, try `ciw` to change a word, `dd` to delete a line, `gcc` to comment it.
:::

### Day 3: Command Palette & Discovery

:::success The Command Palette is your training wheels!
```
<leader>p     # Open command palette
```
:::

**Try typing:**
- "save" - See save-related commands
- "git" - See git commands
- "format" - Format document
- "terminal" - Terminal operations

**This is how you learn without memorizing!**

:::tip Exercise
1. Press `<leader>p`
2. Type "buffer"
3. See all buffer-related commands
4. Select one and see what happens
:::

### Day 4: Terminal Workflow

**Create named terminals for different tasks:**

| Keymap | Action |
|--------|--------|
| `<leader>tn` | New terminal (you'll name it) |
| `<leader>t` | Picker to switch between terminals |
| `<leader>tt` | Toggle last used terminal |

#### In Terminal

| Keymap | Action |
|--------|--------|
| `<Esc><Esc>` | Exit to normal mode |
| `<C-\><C-h>` | Hide terminal (keeps running!) |

:::info Example Workflow
1. `<leader>tn` → Create "dev" terminal
2. Run `npm run dev`
3. `<C-\><C-h>` → Hide it (server keeps running!)
4. Code for a while...
5. `<leader>tt` → Pop it back up to check logs
:::

### Day 5: LSP & Code Intelligence

**When editing code with LSP active:**

| Keymap | Action |
|--------|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Show hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>f` | Format document |

**See diagnostics (errors/warnings):**

| Keymap | Action |
|--------|--------|
| `<leader>xx` | All diagnostics (Trouble) |
| `]d` / `[d` | Next/previous diagnostic |

:::tip Exercise
1. Open a TypeScript/Python file
2. Put cursor on a variable
3. Press `gd` - jump to definition
4. Press `gr` - find all references
5. Press `<leader>rn` - rename it everywhere!
:::

---

## Essential Workflows

### 1. Starting a New Feature

```bash
1. <leader>gg        # Open lazygit
2. Create new branch
3. <leader>ff        # Find files to edit
4. Edit code
5. <leader>w         # Save
6. <leader>xx        # Check for errors
7. <leader>gg        # Commit changes
```

### 2. Debugging with Terminals

```bash
1. <leader>tn        # Create "logs" terminal
2. tail -f app.log   # Watch logs
3. <C-\><C-h>        # Hide terminal
4. Edit code
5. <leader>tn        # Create "test" terminal
6. npm test          # Run tests
7. <leader>t         # Quick switch between terminals
```

### 3. Refactoring

```bash
1. <leader>fg        # Search for function/variable name
2. <leader>rn        # Rename symbol (LSP does it everywhere!)
3. <leader>ca        # Code actions (extract, inline, etc.)
4. <leader>f         # Format code
5. <leader>gg        # Review diff, commit
```

### 4. Working Across Files

```bash
1. <leader>ff        # Open file A
2. <leader>sv        # Split vertical
3. <leader>ff        # Open file B in split
4. Ctrl+h/l          # Jump between them
5. <leader>1-4       # Harpoon marks for quick file access
```

### 5. Research & Exploration

```bash
1. <leader>fg        # Search for text across project
2. gd                # Jump to definition
3. Ctrl+o / Ctrl+i   # Jump back/forward (like browser)
4. <leader>s.        # Recent files
5. <leader>/         # Fuzzy search in current file
```

### 6. Getting Unstuck

```bash
1. <leader>p         # Command palette
2. Type what you want to do
3. Or...
4. <leader>cc        # Ask Claude Code for help!
```

---

## Learning Path

### Week 1: Core Navigation

**Focus:** File finding, buffer management, basic editing

**Daily practice:**
- Use `<leader>ff` instead of file tree
- Navigate with `hjkl` instead of arrow keys
- Try one new motion each day (like `ciw`, `yap`)

**Goal:** Can navigate and edit without mouse

### Week 2: Command Palette Mastery

**Focus:** Discovering features through palette

**Daily practice:**
- Use `<leader>p` for everything you can't remember
- Try to identify patterns (categories, shortcuts)
- Notice context-aware commands

**Goal:** Comfortable finding any command

### Week 3: Terminal Integration

**Focus:** Multi-terminal workflow

**Daily practice:**
- Create named terminals for your workflow
- Practice toggling with `<leader>tt`
- Keep long-running processes in background

**Goal:** Seamless terminal/editor workflow

### Week 4: LSP & Advanced Features

**Focus:** Code intelligence, refactoring

**Daily practice:**
- Use `gd`, `gr` for navigation
- Try `<leader>rn` for renaming
- Explore code actions `<leader>ca`

**Goal:** IDE-level productivity

---

## Troubleshooting

### "I can't find a command!"

:::tip Solution
`<leader>p` (command palette) - Type what you want to do
:::

### "LSP isn't working for my language"

**Check:**
```vim
:LspInfo              # Shows active LSP clients
:Mason                # Install language servers
:checkhealth          # Diagnose issues
```

:::warning Common Issue
Language server not installed

**Fix:** `:Mason` → Find your language → Install
:::

### "Plugin not loading"

**Check:**
```vim
:Lazy                 # Plugin manager
:Lazy sync            # Update all plugins
```

### "Keybinding not working"

**Debug:**
```vim
:verbose map <leader>ff    # Shows what the binding does
:WhichKey <leader>         # Shows all leader bindings
```

### "Terminal is acting weird"

**Reset:**
```vim
:TerminalDelete <name>     # Delete problematic terminal
:TerminalNew <name>        # Recreate it
```

### "Everything is broken!"

:::danger Nuclear Option
```bash
# Backup your config
cp -r ~/.config/nvim ~/.config/nvim.backup

# Remove plugins
rm -rf ~/.local/share/nvim

# Restart Neovim (will reinstall everything)
nvim
```
:::

---

## Quick Tips

1. **Repeat last command:** `.` (dot)
2. **Record macro:** `qq` (starts recording to register q), do actions, `q` (stops), `@q` (replay)
3. **Jump to mark:** `m` + letter to set, `'` + letter to jump
4. **Search in file:** `/` then type, `n` for next, `N` for previous
5. **Replace in file:** `:%s/old/new/g`
6. **Visual block mode:** `Ctrl+v` for column editing
7. **Increment numbers:** `Ctrl+a`, decrement: `Ctrl+x`
8. **Jump to matching bracket:** `%`
9. **Go to line:** `:42` or `42G`
10. **Paste from system clipboard:** `"+p`

---

## Advanced Topics

### Creating Custom Keybindings

In `init.lua`, add:

```lua
vim.keymap.set('n', '<leader>x', '<cmd>YourCommand<cr>', { desc = 'Description' })
```

### Adding a New Plugin

In `lua/custom/plugins/`, create `myplugin.lua`:

```lua
return {
  'author/plugin-name',
  config = function()
    require('plugin-name').setup({})
  end,
}
```

Restart Neovim, run `:Lazy sync`

### Custom Commands

```vim
:command! MyCommand lua vim.print("Hello!")
```

### Project-Specific Settings

Create `.nvim.lua` in project root:

```lua
-- Project-specific configuration
vim.opt.tabstop = 2
```

---

## Next Steps

1. **Read the [Plugin Guide](./plugin-guide)** - Deep dive into each plugin
2. **Check [Quick Reference](./quick-reference)** - Cheat sheet for keybindings
3. **Customize!** - Make it yours by tweaking `init.lua` and plugin configs

---

## Philosophy Recap

:::success You don't need to memorize everything!

Remember:
- `<leader>p` - Command palette (find anything)
- `<leader>t` - Terminal picker
- `<leader>cc` - Claude Code (AI help)

Everything else is discoverable. Learn by doing, use the palette when stuck, and gradually build muscle memory.
:::

**Happy coding!** 🚀
