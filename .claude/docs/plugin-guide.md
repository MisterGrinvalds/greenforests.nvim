---
sidebar_position: 2
title: Plugin Guide
description: Detailed guide for each plugin in this Neovim configuration
---

# Plugin Guide

Comprehensive documentation for every plugin in this setup.

## Custom Plugins

### Command Palette

**Repository:** `command-palette.nvim`
**Category:** Productivity, Discovery
**Keymap:** `<leader>p`, `<leader>sp`

#### What It Does

A VS Code-style command palette with intelligent context awareness and fuzzy finding. It aggregates commands from multiple sources and ranks them using a frecency algorithm (frequency + recency).

#### Features

- **Multi-Source Aggregation**
  - Neovim ex commands (`:write`, `:quit`, etc.)
  - LSP code actions (format, rename, etc.)
  - Registered keymaps (with shortcuts shown)
  - Shell commands (git, npm, cargo, etc.)
  - Terminal manager commands

- **Smart Ranking**
  - Frecency-based (commands you use often appear first)
  - Context boosting (git commands higher in git repos)
  - Persistent history across sessions

- **Context Awareness**
  - Shows LSP actions only when LSP is active
  - Git commands in git repos
  - Project-specific commands (npm in Node projects, etc.)

#### How to Use

**Basic:**
```vim
<leader>p          " Open command palette
" Type to search:
" - 'format' → Format Document
" - 'git' → Git operations
" - 'buffer' → Buffer management
```

**Examples:**

| What You Want | Type This |
|---------------|-----------|
| Save file | "save" or "write" |
| Format code | "format" |
| Git status | "git status" |
| Close buffer | "buffer delete" |
| Terminal operations | "terminal" |

**In the Palette:**
- Type to fuzzy search
- `<C-n>`/`<C-p>` to navigate
- `<Enter>` to execute
- `<Esc>` to close

#### Configuration

Location: `lua/custom/plugins/command-palette.lua`

```lua
require('command-palette').setup({
  providers = {
    'nvim',      -- Vim ex commands
    'keymaps',   -- Registered keybindings
    'lsp',       -- LSP actions
    'shell',     -- Shell commands
    'terminal',  -- Terminal manager
  },

  telescope_opts = {
    theme = 'dropdown',
  },

  enable_context_filtering = true,
})
```

#### Tips

1. **Don't Memorize!** Use the palette when you can't remember a command
2. **Learn Patterns:** Notice categories (LSP, Git, Buffer, etc.)
3. **Frecency Learning:** The more you use a command, the higher it appears
4. **Context Aware:** Commands adapt to what you're doing

---

### Terminal Manager

**Repository:** `terminal-manager.nvim`
**Category:** Workflow, Terminals
**Keymaps:** `<leader>t`, `<leader>tt`, `<leader>tn`

#### What It Does

Manages multiple persistent terminal sessions with quick access. Think of it as terminal tabs that survive hide/show operations.

#### Features

- **Multiple Named Sessions**
  - Create terminals like "dev", "git", "test"
  - Each has its own persistent buffer
  - Sessions survive hide/show

- **Quick Toggle**
  - Instant show/hide
  - Remember last used terminal
  - Telescope picker for all sessions

- **Session Management**
  - Rename terminals
  - Delete sessions
  - Send commands to terminals

#### How to Use

**Create Terminals:**
```vim
:TerminalNew dev           " Create 'dev' terminal
:TerminalNew git           " Create 'git' terminal
:TerminalNew test          " Create 'test' terminal
```

**Navigate Terminals:**
```vim
<leader>t                  " Picker - select any terminal
<leader>tt                 " Toggle last used
<leader>tg                 " Quick toggle 'git' terminal
<leader>td                 " Quick toggle 'dev' terminal
```

**In Terminal Buffer:**
```vim
<Esc><Esc>                 " Exit to normal mode
<C-\><C-h>                 " Hide terminal (keeps running!)
<C-\><C-t>                 " Open terminal picker
```

**In Terminal Picker:**
- `<Enter>` - Toggle selected terminal
- `<C-n>` - Create new terminal
- `<C-d>` - Delete terminal
- `<C-r>` - Rename terminal

#### Common Workflows

**Development Server:**
```vim
:TerminalNew dev
npm run dev
<C-\><C-h>                 " Hide, server keeps running
" ... code for an hour ...
<leader>tt                 " Pop it back up
```

**Git Workflow:**
```vim
<leader>tg                 " Open git terminal
git status
git add .
git commit -m "feat: awesome"
<C-\><C-h>                 " Hide
" ... more work ...
<leader>tg                 " Back to git
git push
```

**Multi-Project:**
```vim
:TerminalNew project-a
:TerminalNew project-b
<leader>t                  " Picker - quick switch
```

#### Configuration

Location: `lua/custom/plugins/terminal-manager.lua`

```lua
require('terminal-manager').setup({
  window = {
    position = 'bottom',   -- 'float', 'right', 'left', 'bottom'
    border = 'rounded',

    float = {
      width = 0.8,
      height = 0.8,
    },

    split = {
      width = 0.4,
      height = 0.3,
    },
  },

  -- Auto-create on startup
  default_sessions = {
    -- { name = 'dev' },
    -- { name = 'git' },
  },
})
```

#### Advanced Usage

**Send Commands:**
```vim
:TerminalSend dev npm run build
" Sends command to 'dev' terminal
```

**From Lua:**
```lua
require('terminal-manager').send('test', 'pytest -v', true)
```

**Project-Specific Auto-Create:**
```lua
-- In .nvim.lua or ftplugin
vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    require('terminal-manager').new('dev')
    require('terminal-manager').send('dev', 'npm run dev', true)
  end,
})
```

#### Tips

1. **Consistent Naming:** Use same names across projects (dev, git, test)
2. **Quick Access:** Set up dedicated keymaps for your most-used terminals
3. **Long-Running Processes:** Perfect for dev servers, watchers, logs
4. **Integration:** Works with command palette - type "terminal" to see all operations

---

### Claude Code

**Repository:** `claude-code.nvim`
**Category:** AI, Assistance
**Keymaps:** `<leader>cc`, `<leader>cf`, `<leader>cs`

#### What It Does

Integrates Claude Code CLI into Neovim with a toggle-able window and context injection commands.

#### Features

- **Persistent Terminal**
  - Claude Code runs in a terminal buffer
  - Survives hide/show operations
  - Quick toggle access

- **Context Injection**
  - Send current file
  - Send visual selection
  - Send diagnostics
  - Send buffer with context

- **Command Palette**
  - Preset prompts (explain, optimize, test, etc.)
  - Custom prompts via `:ClaudeAsk`

#### How to Use

**Toggle Claude Window:**
```vim
<leader>cc                 " Toggle Claude Code window
:ClaudeCurrent             " Open in current window
```

**Send Context:**
```vim
<leader>cf                 " Send current file
<leader>cs                 " Send visual selection (in visual mode)
<leader>cd                 " Send diagnostics
<leader>cb                 " Send buffer with context
```

**Quick Prompts:**
```vim
<leader>cp                 " Command palette
" Choose from:
" - Explain this code
" - Find bugs
" - Optimize
" - Add tests
" - Refactor
" - Add documentation
```

**Custom Prompt:**
```vim
<leader>ca                 " Ask Claude
" Type your question
```

**In Claude Terminal:**
```vim
<Esc><Esc>                 " Exit to normal mode
<C-\><C-c>                 " Toggle window
```

#### Configuration

Location: `lua/custom/plugins/claude-code.lua`

```lua
require('claude-code').setup({
  window = {
    position = 'right',    -- 'float', 'right', 'left', 'bottom'
    width = 0.4,
    border = 'rounded',
  },

  keymaps = {
    toggle = '<leader>cc',
    send_file = '<leader>cf',
    send_selection = '<leader>cs',
    send_diagnostics = '<leader>cd',
    ask = '<leader>ca',
  },
})
```

#### Common Workflows

**Code Review:**
```vim
<leader>cf                 " Send file to Claude
" Ask: "Review this code for bugs and improvements"
```

**Refactoring:**
```vim
" Select code in visual mode
<leader>cs                 " Send selection
" Ask: "Refactor this to be more readable"
```

**Debugging:**
```vim
<leader>cd                 " Send diagnostics
" Claude sees your errors and suggests fixes
```

**Learning:**
```vim
<leader>ca
" Ask: "Explain how this algorithm works"
```

#### Tips

1. **Keep It Open:** Claude window persists, just hide it when not needed
2. **Context Matters:** Send relevant code/diagnostics for better answers
3. **Iterative:** Have a conversation - ask follow-up questions
4. **Command Palette:** Browse preset prompts for common tasks

---

## Community Plugins

### Telescope

**Plugin:** `telescope.nvim`
**Category:** Fuzzy Finder, Navigation
**Keymaps:** `<leader>ff`, `<leader>fg`, `<leader>s*`

#### What It Does

The fuzzy finder for Neovim. Search files, text, commands, buffers, and more.

#### Common Uses

| Keymap | Action |
|--------|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search text) |
| `<leader>s.` | Recent files |
| `<leader>sc` | Commands |
| `<leader><Space>` | Open buffers |
| `<leader>/` | Search in current file |
| `<leader>sk` | Keymaps |
| `<leader>sh` | Help tags |

#### In Telescope

- Type to fuzzy search
- `<C-n>`/`<C-p>` to navigate results
- `<Enter>` to select
- `<C-x>` to open in horizontal split
- `<C-v>` to open in vertical split
- `<Tab>` to select multiple (for some pickers)

#### Tips

1. **Fuzzy Matching:** Don't type full words - "usrctl" matches "userController"
2. **Preview:** Shows file preview as you navigate
3. **Everywhere:** Use for finding anything, not just files

---

### Neo-tree

**Plugin:** `neo-tree.nvim`
**Category:** File Explorer
**Keymap:** `\`

#### What It Does

Visual file tree sidebar for browsing project structure.

#### How to Use

```vim
\                          " Toggle neo-tree
```

**In Neo-tree:**
- `j`/`k` - Navigate
- `<Enter>` - Open file
- `o` - Open file but keep focus on tree
- `a` - Add file/directory
- `d` - Delete
- `r` - Rename
- `x` - Cut
- `c` - Copy
- `p` - Paste
- `?` - Show help

#### Tips

1. **Use Telescope:** For navigation, Telescope is faster
2. **Use Neo-tree:** For browsing, seeing structure, organizing
3. **Stay Keyboard:** Don't reach for mouse!

---

### LSP (Language Server Protocol)

**Plugins:** `nvim-lspconfig`, `mason.nvim`
**Category:** Code Intelligence
**Keymaps:** `gd`, `gr`, `<leader>rn`, etc.

#### What It Does

Provides IDE-like features: auto-completion, go to definition, find references, rename, diagnostics, and more.

#### Configured Languages

- **Python:** pyright + black + isort
- **TypeScript/JavaScript:** ts_ls + prettier
- **Go:** gopls + goimports
- **Lua:** lua_ls + stylua

#### Common Actions

| Keymap | Action |
|--------|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find references |
| `gi` | Go to implementation |
| `K` | Show hover docs |
| `<C-k>` | Signature help (insert mode) |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>f` | Format document |
| `]d`, `[d` | Next/prev diagnostic |
| `<leader>e` | Show diagnostic hover |

#### Managing LSP

```vim
:LspInfo                   " Show active clients
:LspRestart                " Restart LSP servers
:Mason                     " Install language servers
```

**Install New Language Server:**
1. `:Mason`
2. Find your language
3. Press `i` to install

#### Tips

1. **K for Docs:** `K` shows documentation - use it liberally!
2. **gd and Back:** `gd` to jump, `Ctrl+o` to jump back
3. **Rename Safely:** `<leader>rn` renames everywhere in project
4. **Format on Save:** Can enable auto-format (see config)

---

### Treesitter

**Plugin:** `nvim-treesitter`
**Category:** Syntax Highlighting, Code Understanding
**Keymaps:** `Ctrl+Space` for incremental selection

#### What It Does

Better syntax highlighting and code understanding using actual parsers.

#### Features

- **Accurate Highlighting:** Understands code structure
- **Incremental Selection:** Smart code selection
- **Text Objects:** Navigate by function, class, etc.

#### Incremental Selection

```vim
Ctrl+Space                 " Start selection (expands to node)
Ctrl+Space                 " Expand to next node
Backspace                  " Shrink selection
```

Example:
1. Cursor on variable
2. `Ctrl+Space` → Selects variable
3. `Ctrl+Space` → Selects statement
4. `Ctrl+Space` → Selects function
5. `Ctrl+Space` → Selects class

#### Configured Languages

css, javascript, typescript, tsx, json, python, go, gomod, gosum, lua, vim, vimdoc, and more.

---

### Comment.nvim

**Plugin:** `Comment.nvim`
**Category:** Editing
**Keymaps:** `gcc`, `gc`, `gbc`

#### What It Does

Toggle comments with motions.

#### How to Use

**Normal Mode:**
```vim
gcc                        " Toggle line comment
gc + motion                " Comment motion (gcap = comment paragraph)
gbc                        " Toggle block comment
```

**Visual Mode:**
```vim
gc                         " Toggle comment for selection
gb                         " Toggle block comment for selection
```

#### Examples

| Command | Result |
|---------|--------|
| `gcc` | Comment current line |
| `gc2j` | Comment current line + 2 below |
| `gcap` | Comment paragraph |
| `gc` (visual) | Comment selection |

---

### Harpoon

**Plugin:** `harpoon`
**Category:** Navigation
**Keymaps:** `<leader>a`, `<leader>e`, `<leader>1-4`

#### What It Does

Quick marks for your most-used files. Like browser tabs for files.

#### How to Use

```vim
<leader>a                  " Add file to harpoon
<leader>e                  " Harpoon menu (see all marks)
<leader>1                  " Jump to file 1
<leader>2                  " Jump to file 2
<leader>3                  " Jump to file 3
<leader>4                  " Jump to file 4
```

#### Workflow

```vim
" Working on 4 key files:
:edit src/main.ts
<leader>a                  " Mark as file 1

:edit src/utils.ts
<leader>a                  " Mark as file 2

:edit src/api.ts
<leader>a                  " Mark as file 3

:edit tests/main.test.ts
<leader>a                  " Mark as file 4

" Now quick switch:
<leader>1                  " Jump to main.ts
<leader>3                  " Jump to api.ts
<leader>4                  " Jump to test
```

#### Tips

1. **Core Files:** Mark your most-edited files
2. **Fast Navigation:** Faster than Telescope for known files
3. **Per-Project:** Harpoon remembers marks per project

---

### Lazygit

**Plugin:** `lazygit.nvim`
**Category:** Git
**Keymap:** `<leader>gg`

#### What It Does

Terminal UI for Git operations. Full git workflow without leaving Neovim.

#### How to Use

```vim
<leader>gg                 " Open lazygit
```

**In Lazygit:**
- `←` `→` - Navigate panels
- `↑` `↓` - Navigate items
- `<Space>` - Stage/unstage
- `c` - Commit
- `P` - Push
- `p` - Pull
- `?` - Show help

#### Common Workflows

**Basic Commit:**
1. `<leader>gg`
2. Stage files with `<Space>`
3. Press `c` to commit
4. Write message, save and close
5. Press `P` to push

**View History:**
1. `<leader>gg`
2. Navigate to "Commits" panel
3. Browse history
4. `<Enter>` to see diff

#### Tips

1. **Full Git:** Handles branches, merges, rebases, stashes
2. **Visual Diff:** Easy to see what changed
3. **Stay in Neovim:** No context switching

---

### Trouble

**Plugin:** `trouble.nvim`
**Category:** Diagnostics
**Keymaps:** `<leader>xx`, `<leader>xX`

#### What It Does

Beautiful list of diagnostics, references, and more.

#### How to Use

```vim
<leader>xx                 " All diagnostics
<leader>xX                 " Buffer diagnostics
```

**In Trouble:**
- `j`/`k` - Navigate
- `<Enter>` - Jump to location
- `q` - Close

#### Tips

1. **Error Overview:** See all errors at once
2. **Jump to Fix:** Navigate and jump to each issue
3. **LSP Integration:** Works with any LSP

---

### Diffview

**Plugin:** `diffview.nvim`
**Category:** Git
**Keymaps:** `<leader>gd`, `<leader>gh`

#### What It Does

View git diffs and file history in beautiful UI.

#### How to Use

```vim
<leader>gd                 " Diff view
<leader>gh                 " File history
```

**In Diffview:**
- `]c` / `[c` - Next/prev change
- `<Enter>` - Focus file
- `gf` - Go to file
- `<Tab>` - Toggle fold

#### Tips

1. **Before Commit:** Review changes before committing
2. **File History:** See how file evolved over time
3. **Side-by-Side:** Easy to see exactly what changed

---

### Bufferline

**Plugin:** `bufferline.nvim`
**Category:** UI, Navigation
**Keymaps:** `Shift+H/L`, `<leader>bj`

#### What It Does

Visual buffer tabs at the top with buffer management.

#### How to Use

```vim
Shift+H                    " Previous buffer
Shift+L                    " Next buffer
<leader>bj                 " Buffer jump (visual picker)
<leader>bd                 " Delete buffer
<leader>bp                 " Pin buffer
```

#### Features

- Shows open buffers as tabs
- Tab numbers for quick access
- Visual indicator for modified files
- Tab-scoped buffers (with scope.nvim)

#### Tips

1. **Visual Navigation:** See all open files
2. **Quick Jump:** `<leader>bj` for visual picker
3. **Pin Important:** Pin files you reference often

---

### Smart-splits

**Plugin:** `smart-splits.nvim`
**Category:** Navigation
**Keymaps:** `Ctrl+h/j/k/l`, `Alt+h/j/k/l`

#### What It Does

Seamless navigation between Neovim splits and terminal multiplexers (tmux, kitty, wezterm).

#### How to Use

**Navigate Splits:**
```vim
Ctrl+h                     " Left
Ctrl+j                     " Down
Ctrl+k                     " Up
Ctrl+l                     " Right
```

**Resize Splits:**
```vim
Alt+h                      " Resize left
Alt+j                      " Resize down
Alt+k                      " Resize up
Alt+l                      " Resize right
```

**Swap Buffers:**
```vim
<leader>wh                 " Swap left
<leader>wj                 " Swap down
<leader>wk                 " Swap up
<leader>wl                 " Swap right
```

#### Tips

1. **Works with Ghostty:** Configured to work with your terminal
2. **Muscle Memory:** Same keys for terminal and Neovim
3. **Seamless:** Doesn't feel like different applications

---

## Plugin Management

### Lazy.nvim

**Category:** Plugin Manager
**Command:** `:Lazy`

#### Commands

```vim
:Lazy                      " Open Lazy UI
:Lazy sync                 " Install/update/clean plugins
:Lazy update               " Update plugins
:Lazy clean                " Remove unused plugins
:Lazy profile              " Profile startup time
```

#### UI Actions

- `I` - Install missing plugins
- `U` - Update plugins
- `X` - Clean unused plugins
- `C` - Check for updates
- `L` - View log
- `?` - Help

---

## Next Steps

1. **Explore Each Plugin:** Try the keymaps, see what they do
2. **Customize:** Tweak configs in `lua/custom/plugins/`
3. **Add Plugins:** Create new plugin files in `lua/custom/plugins/`
4. **Check [Quick Reference](./quick-reference)** for a cheat sheet

---

## Getting Help

1. **`:help <plugin-name>`** - Built-in help
2. **`<leader>p`** - Command palette to discover features
3. **`<leader>cc`** - Ask Claude Code for help
4. **`:checkhealth`** - Diagnose issues

Happy exploring! 🚀
