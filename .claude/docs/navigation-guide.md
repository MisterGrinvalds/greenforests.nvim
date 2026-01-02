---
sidebar_position: 4
title: Navigation Architecture
description: Complete guide to navigating in the Neovim + tmux setup
---

# Navigation Architecture Guide

Understanding how to navigate efficiently in this setup.

## Two Domains, Clear Boundaries

### tmux Domain (Terminals & Processes)

**Purpose:** Run processes, terminals, servers, tests

**Elements:**
- **Sessions** - Project workspaces (dev, personal)
- **Windows** - Terminal tabs (git, server, logs)
- **Panes** - Terminal splits (side-by-side)

**Control:** `<leader>t*` commands from Neovim, or native tmux

### Neovim Domain (Text Editing)

**Purpose:** Edit code, navigate files

**Elements:**
- **Splits** - Window panes showing buffers
- **Buffers** - Open files
- **Harpoon** - Bookmarked files (core 4)

**Control:** Keyboard shortcuts, all lowercase after `<leader>`

---

## Navigation Decision Tree

### "I want to navigate..."

| To... | Use This | Why |
|-------|----------|-----|
| **Different part of code** | `hjkl`, `w`, `{`, `gg` | Vim motions |
| **Different split** | `Ctrl+h/j/k/l` | Physical direction |
| **Next/prev file** | `Shift+H/L` | Quick cycling |
| **Specific file (know name)** | `<leader><leader>` | Fuzzy search |
| **Specific file (see all)** | `<leader>bj` | Visual picker |
| **My core 4 files** | `<leader>1/2/3/4` | Harpoon bookmarks |
| **Browse project** | `<leader>e` | File explorer |
| **Find any file** | `<leader>ff` | Telescope |
| **Different terminal** | `<leader>tw` | tmux window picker |
| **Next/prev terminal** | `Alt+H/L` | tmux window cycling |

---

## Semantic Direction Principles

### Consistent Meaning Everywhere

**Left/Right (H/L):**
- `Shift+H` = Previous buffer (← in list)
- `Shift+L` = Next buffer (→ in list)
- `Alt+H` = Previous tmux window (← in tabs)
- `Alt+L` = Next tmux window (→ in tabs)
- **Meaning:** Navigate through a list/sequence

**Up/Down/Left/Right (h/j/k/l):**
- `Ctrl+h` = Move to left split (← on screen)
- `Ctrl+j` = Move to split below (↓ on screen)
- `Ctrl+k` = Move to split above (↑ on screen)
- `Ctrl+l` = Move to right split (→ on screen)
- **Meaning:** Physical screen direction

### Modifier Keys Pattern

| Modifier | Domain | Example |
|----------|--------|---------|
| `Ctrl` | Splits | `Ctrl+h` move left |
| `Shift` | Buffers | `Shift+H` prev buffer |
| `Alt` | Resize / tmux | `Alt+h` resize, `Alt+H` tmux window |
| `<leader>` | Actions | `<leader>e` explorer |

---

## Neovim Navigation Deep Dive

### Level 1: Within a File (Vim Motions)

**Basic movement:**
- `h/j/k/l` - Left/Down/Up/Right
- `w/b` - Next/previous word
- `{/}` - Previous/next paragraph
- `gg/G` - Top/bottom of file

**This is standard Vim - learn it gradually!**

### Level 2: Between Splits (Window Panes)

**Navigate:**
```
┌─────────┬─────────┐
│ Split 1 │ Split 2 │  Ctrl+h ← → Ctrl+l
│         │    ◄────┼─── You are here
└─────────┴─────────┘
```

| Key | Action |
|-----|--------|
| `Ctrl+h` | Move to split on left |
| `Ctrl+j` | Move to split below |
| `Ctrl+k` | Move to split above |
| `Ctrl+l` | Move to split on right |

**Resize:**
- `Alt+h/j/k/l` - Resize in that direction

**Swap buffers:**
- `<leader>wh/j/k/l` - Swap buffer in that direction

### Level 3: Between Buffers (Open Files)

**You have 3 methods - use the right tool:**

**Method 1: Cycling (Muscle Memory)**
```
Shift+H ← [file1.js] [file2.js] [file3.js ✓] [file4.js] → Shift+L
```

| Key | When to Use |
|-----|-------------|
| `Shift+H` | Go to previous file in list |
| `Shift+L` | Go to next file in list |

**Best for:** Cycling through 2-5 recently used files

**Method 2: Fuzzy Find (Many Files)**
```vim
<leader><leader>
" Type: "user"
" Matches: userController.js, userModel.js, etc.
```

**Best for:** 10+ buffers, know part of filename

**Method 3: Visual Picker (See All)**
```vim
<leader>bj
" Shows numbered list of all buffers
" Press number to jump
```

**Best for:** Want to see what's open

### Level 4: Harpoon (Your Core Files)

**Philosophy:** Mark your 3-4 most important files

**Workflow:**
```vim
" Mark your core files:
" In main.ts
<leader>a         " Mark as file 1

" In utils.ts
<leader>a         " Mark as file 2

" In test.ts
<leader>a         " Mark as file 3

" Now jump anywhere:
<leader>1         " Jump to main.ts
<leader>2         " Jump to utils.ts
<leader>3         " Jump to test.ts

" See all marks:
<leader>m         " Harpoon menu
```

**Best for:** Your 3-4 core files per project

---

## tmux Navigation Deep Dive

### Level 1: Between Panes (Terminal Splits)

**Exactly like Neovim splits:**
```
┌──────────┬──────────┐
│ Neovim   │ Terminal │  Ctrl+h ← → Ctrl+l (seamless!)
│          │     ◄────┼─── Works across both!
└──────────┴──────────┘
```

**The magic:** Same `Ctrl+hjkl` keys work in Neovim AND tmux!

### Level 2: Between Windows (Terminal Tabs)

**You have 2 methods:**

**Method 1: Picker (From Neovim)**
```vim
<leader>tw
" Fuzzy find window
" Type window name
" <Enter> to switch
```

**Method 2: Cycling (In Terminal)**
```bash
Alt+H         # Previous window
Alt+L         # Next window
# No prefix needed!
```

**Quick access:**
```vim
<leader>tg    # Always go to 'git' window
<leader>td    # Always go to 'dev' window
<leader>tt    # Always go to 'test' window
```

### Level 3: Between Sessions (Rare)

```bash
Ctrl-b s      # Session list
# Navigate with j/k
# Press Enter to switch
```

---

## Common Workflows

### Workflow 1: Editing Multiple Files

```vim
" Open files
<leader>ff → main.ts
<leader>ff → utils.ts
<leader>ff → types.ts

" Navigate between them
Shift+H/L         " Cycle through

" Or mark them:
<leader>a         " In main.ts
<leader>a         " In utils.ts
<leader>a         " In types.ts

" Jump with:
<leader>1/2/3
```

### Workflow 2: Split Screen Coding

```vim
" Open file
<leader>ff → main.ts

" Split
Ctrl+w v          " Vertical split (or use command)

" Open another file
<leader>ff → test.ts

" Navigate
Ctrl+h            " To main.ts
Ctrl+l            " To test.ts

" Both files visible!
```

### Workflow 3: Development with Terminals

```bash
# In tmux, create windows
<leader>tn → "server"
npm run dev

<Esc><Esc>        " Exit terminal mode
<leader>tn → "git"
<leader>tw → select "nvim"

# Now switch between:
Alt+H/L           " Cycle: nvim ← → server ← → git

# Or fuzzy find:
<leader>tw → "server"
```

### Workflow 4: Multi-Pane Monitoring

```bash
# Create 'monitor' window
<leader>tn → "monitor"

# Split it
<leader>t|        " Vertical split
<leader>t-        " Horizontal split (in right pane)

# Now have 3 panes:
# Pane 1: npm run dev
# Pane 2: npm test -- --watch
# Pane 3: tail -f app.log

# Navigate between them:
Ctrl+h/j/k/l      " Jump to any pane

# Maximize one:
<leader>tm        " Full screen
<leader>tm        " Restore
```

---

## Muscle Memory Guide

### Learn in This Order

**Week 1: Splits**
- `Ctrl+h/j/k/l` - Navigate splits
- Practice until automatic

**Week 2: Buffers**
- `Shift+H/L` - Cycle files
- `<leader><leader>` - Find file

**Week 3: Harpoon**
- `<leader>a` - Mark files
- `<leader>1-4` - Jump to marks
- `<leader>m` - See menu

**Week 4: tmux**
- `<leader>tw` - Window picker
- `<leader>tg/td/tt` - Quick windows
- `Alt+H/L` - Cycle windows

### Common Mistakes

**Mistake:** Using `<leader>bj` instead of `<leader><leader>`
**Better:** `<leader><leader>` is more versatile (Telescope)

**Mistake:** Creating Vim tabs
**Better:** Use buffers + Harpoon instead

**Mistake:** Forgetting which domain
**Remember:**
- Editing code? Neovim domain
- Running processes? tmux domain

---

## Quick Reference

### Neovim Domain

| Keys | Action | Use For |
|------|--------|---------|
| `Ctrl+hjkl` | Navigate splits | Screen panes |
| `Shift+H/L` | Cycle buffers | Files |
| `<leader><leader>` | Find buffer | Many files |
| `<leader>bj` | Buffer jump | See list |
| `<leader>1-4` | Harpoon jump | Core files |
| `<leader>m` | Harpoon menu | Manage marks |
| `<leader>a` | Add to Harpoon | Mark file |
| `<leader>e` | File explorer | Browse |
| `<leader>ff` | Find files | Project search |

### tmux Domain

| Keys | Action | Use For |
|------|--------|---------|
| `<leader>tw` | Window picker | Find terminal |
| `<leader>tg/td/tt` | Quick windows | Git/Dev/Test |
| `<leader>tn` | New window | Create terminal |
| `<leader>tm` | Maximize | Full screen |
| `Alt+H/L` | Cycle windows | Switch terminals |
| `Ctrl+hjkl` | Navigate panes | Terminal splits |

---

## Philosophy

**Simplicity over options:**
- One primary method per navigation type
- Fallback methods for specific use cases
- Clear when to use what

**Semantic consistency:**
- Same keys mean same thing across contexts
- Physical direction vs list navigation
- Muscle memory friendly

**Domain clarity:**
- Neovim for editing
- tmux for processes
- Clear handoff between them

**The goal:** Navigate without thinking. Let muscle memory take over.

---

## Next Steps

1. Practice split navigation (`Ctrl+hjkl`) until automatic
2. Use `Shift+H/L` as your primary buffer navigation
3. Mark your core 4 files with Harpoon
4. Create tmux windows for your workflow
5. Let the system fade into the background

**Happy navigating!** 🚀
