---
sidebar_position: 3
title: Quick Reference
description: Cheat sheet for all keybindings and commands
---

# Quick Reference

A concise cheat sheet for all keybindings and commands in this Neovim setup.

## Essential Keybindings

### The Most Important

| Keymap | Action | Plugin |
|--------|--------|--------|
| `<leader>p` | **Command Palette** (find anything!) | command-palette |
| `<leader>t` | **Terminal Picker** | terminal-manager |
| `<leader>cc` | **Claude Code** (AI help) | claude-code |
| `<leader>ff` | **Find Files** | telescope |

:::tip Remember These Three
- `<leader>p` - When you can't remember a command
- `<leader>t` - When you need a terminal
- `<leader>cc` - When you need help
:::

---

## File Navigation

| Keymap | Action | Plugin |
|--------|--------|--------|
| `<leader>ff` | Find files | telescope |
| `<leader>fg` | Find text (grep) | telescope |
| `<leader>s.` | Recent files | telescope |
| `<leader><Space>` | Find open buffers | telescope |
| `<leader>/` | Search in current file | telescope |
| `\` | Toggle file tree | neo-tree |

---

## Buffer Management

| Keymap | Action | Plugin |
|--------|--------|--------|
| `Shift+H` | Previous buffer | bufferline |
| `Shift+L` | Next buffer | bufferline |
| `<leader>bj` | Buffer jump (picker) | bufferline |
| `<leader>bd` | Delete buffer | bufferline |
| `<leader>bp` | Pin buffer | bufferline |
| `<leader><Space>` | Find buffers | telescope |

---

## Window/Split Management

| Keymap | Action | Plugin |
|--------|--------|--------|
| `Ctrl+h/j/k/l` | Navigate splits | smart-splits |
| `Alt+h/j/k/l` | Resize splits | smart-splits |
| `<leader>wh/j/k/l` | Swap buffers | smart-splits |
| `<leader>sv` | Split vertical | built-in |
| `<leader>sh` | Split horizontal | built-in |
| `<leader>se` | Make splits equal | built-in |
| `<leader>sx` | Close split | built-in |

---

## tmux Integration

### Main Actions

| Keymap | Action |
|--------|--------|
| `<leader>tw` | tmux window picker |
| `<leader>tn` | New tmux window |
| `<leader>tr` | Rename window |
| `<leader>tx` | Delete window |
| `<leader>tg` | Go to 'git' window |
| `<leader>td` | Go to 'dev' window |
| `<leader>tt` | Go to 'test' window |

### Navigation

| Keymap | Action |
|--------|--------|
| `<leader>tl` | Next window |
| `<leader>th` | Previous window |
| `Alt+H` | Previous window (in terminal) |
| `Alt+L` | Next window (in terminal) |
| `Ctrl+h/j/k/l` | Navigate panes (seamless!) |

### Pane Management

| Keymap | Action |
|--------|--------|
| `<leader>tm` | Toggle maximize pane |
| `<leader>t\|` | Split vertical |
| `<leader>t-` | Split horizontal |

### In Terminal

| Keymap | Action |
|--------|--------|
| `<Esc><Esc>` | Exit to normal mode |
| `<C-]>` | Alternative exit |

### In tmux Window Picker

| Keymap | Action |
|--------|--------|
| `<Enter>` | Go to selected window |
| `<C-x>` | Delete window |
| `<C-r>` | Rename window |

### tmux Commands (Native)

```bash
# Prefix is Ctrl-b
Ctrl-b c               " Create new window
Ctrl-b ,               " Rename window
Ctrl-b |               " Split vertical
Ctrl-b -               " Split horizontal
Ctrl-b m               " Maximize pane
Ctrl-b d               " Detach session
Ctrl-b s               " List sessions
Ctrl-b I               " Install tmux plugins (TPM)
```

---

## LSP (Code Intelligence)

### Navigation

| Keymap | Action |
|--------|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find references |
| `gi` | Go to implementation |
| `gt` | Go to type definition |
| `Ctrl+o` | Jump back |
| `Ctrl+i` | Jump forward |

### Actions

| Keymap | Action |
|--------|--------|
| `K` | Hover documentation |
| `<C-k>` | Signature help (insert mode) |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>f` | Format document |

### Diagnostics

| Keymap | Action |
|--------|--------|
| `]d` | Next diagnostic |
| `[d` | Previous diagnostic |
| `<leader>e` | Show diagnostic hover |
| `<leader>xx` | All diagnostics (Trouble) |
| `<leader>xX` | Buffer diagnostics (Trouble) |

### LSP Commands

```vim
:LspInfo                   " Show active LSP clients
:LspRestart                " Restart LSP
:Mason                     " Install language servers
```

---

## Git

### Lazygit

| Keymap | Action |
|--------|--------|
| `<leader>gg` | Open lazygit |

**In Lazygit:**
- `←` `→` - Navigate panels
- `↑` `↓` - Navigate items
- `<Space>` - Stage/unstage
- `c` - Commit
- `P` - Push
- `p` - Pull
- `?` - Help

### Diffview

| Keymap | Action |
|--------|--------|
| `<leader>gd` | Diff view |
| `<leader>gh` | File history |

**In Diffview:**
- `]c` / `[c` - Next/prev change
- `<Tab>` - Toggle fold

---

## Editing

### Basic Operations

| Keymap | Action |
|--------|--------|
| `<leader>w` | Save file |
| `Alt+j/k` | Move lines up/down |
| `</>` (visual) | Indent/dedent (keeps selection) |
| `gcc` | Toggle line comment |
| `gc` (visual) | Toggle comment |
| `u` | Undo |
| `Ctrl+r` | Redo |

### Text Objects

| Motion | Action |
|--------|--------|
| `diw` | Delete inner word |
| `ciw` | Change inner word |
| `yiw` | Yank inner word |
| `di"` | Delete inside quotes |
| `ci"` | Change inside quotes |
| `dap` | Delete a paragraph |
| `yap` | Yank a paragraph |

### Treesitter

| Keymap | Action |
|--------|--------|
| `Ctrl+Space` | Start incremental selection |
| `Ctrl+Space` | Expand selection |
| `Backspace` | Shrink selection |

---

## Harpoon (Quick Marks)

| Keymap | Action |
|--------|--------|
| `<leader>a` | Add file to harpoon |
| `<leader>e` | Harpoon menu |
| `<leader>1` | Jump to file 1 |
| `<leader>2` | Jump to file 2 |
| `<leader>3` | Jump to file 3 |
| `<leader>4` | Jump to file 4 |

---

## Claude Code

### Main Actions

| Keymap | Action |
|--------|--------|
| `<leader>cc` | Toggle Claude window |
| `<leader>cf` | Send file to Claude |
| `<leader>cs` | Send selection (visual) |
| `<leader>cd` | Send diagnostics |
| `<leader>cb` | Send buffer with context |
| `<leader>cp` | Claude command palette |
| `<leader>ca` | Ask Claude |

### Commands

```vim
:ClaudeToggle              " Toggle window
:ClaudeOpen                " Open window
:ClaudeCurrent             " Open in current window
:ClaudeClose               " Close window
:ClaudeAsk [question]      " Ask Claude
```

---

## Telescope Pickers

### File & Text

| Keymap | Action |
|--------|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fw` | Grep word under cursor |
| `<leader>s.` | Recent files |
| `<leader>/` | Search current buffer |

### Vim

| Keymap | Action |
|--------|--------|
| `<leader>sc` | Commands |
| `<leader>:` | Command history |
| `<leader>sk` | Keymaps |
| `<leader>sh` | Help tags |
| `<leader>sd` | Diagnostics |
| `<leader>sr` | Resume last picker |

### In Telescope

| Keymap | Action |
|--------|--------|
| `<C-n>` / `<C-p>` | Next/prev result |
| `<C-x>` | Open in horizontal split |
| `<C-v>` | Open in vertical split |
| `<Tab>` | Select multiple |
| `<C-q>` | Send to quickfix |
| `<Esc>` | Close |

---

## Tabs

| Keymap | Action |
|--------|--------|
| `<leader>tn` | New tab |
| `<leader>tc` | Close tab |
| `<leader>to` | Close other tabs |
| `]t` | Next tab |
| `[t` | Previous tab |

---

## Search & Replace

| Command | Action |
|--------|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next match |
| `N` | Previous match |
| `:%s/old/new/g` | Replace all in file |
| `:%s/old/new/gc` | Replace with confirmation |
| `:s/old/new/g` | Replace in line |

---

## Vim Motions (Built-in)

### Navigation

| Motion | Action |
|--------|--------|
| `h/j/k/l` | Left/Down/Up/Right |
| `w` | Next word |
| `b` | Previous word |
| `e` | End of word |
| `0` | Start of line |
| `^` | First non-blank |
| `$` | End of line |
| `gg` | Top of file |
| `G` | Bottom of file |
| `{` / `}` | Previous/next paragraph |
| `%` | Matching bracket |
| `Ctrl+u` / `Ctrl+d` | Half page up/down |
| `Ctrl+b` / `Ctrl+f` | Full page up/down |

### Editing

| Command | Action |
|--------|--------|
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `I` | Insert start of line |
| `A` | Insert end of line |
| `o` | New line below |
| `O` | New line above |
| `r` | Replace character |
| `x` | Delete character |
| `dd` | Delete line |
| `yy` | Copy line |
| `p` | Paste after |
| `P` | Paste before |
| `u` | Undo |
| `Ctrl+r` | Redo |
| `.` | Repeat last command |

### Visual Mode

| Command | Action |
|--------|--------|
| `v` | Character visual |
| `V` | Line visual |
| `Ctrl+v` | Block visual |
| `gv` | Reselect last selection |

---

## Command Mode

| Command | Action |
|--------|--------|
| `:w` | Save |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:q!` | Quit without saving |
| `:wa` | Save all |
| `:qa` | Quit all |
| `:e <file>` | Edit file |
| `:split` | Horizontal split |
| `:vsplit` | Vertical split |
| `:term` | Open terminal |
| `:%!<cmd>` | Filter buffer through command |

---

## Plugin Management (Lazy.nvim)

```vim
:Lazy                      " Open Lazy UI
:Lazy sync                 " Install/update/clean
:Lazy update               " Update plugins
:Lazy clean                " Remove unused
:Lazy profile              " Startup profiling
```

---

## Diagnostics & Health

```vim
:checkhealth               " Check Neovim health
:LspInfo                   " LSP status
:Mason                     " Manage LSP servers
:Lazy                      " Plugin status
:messages                  " View messages
```

---

## Custom Commands

### File Operations

```vim
:W                         " Save with sudo (if needed)
```

### Window Management

```vim
:only                      " Close all other windows
```

### Terminal

```vim
:TerminalNew <name>        " Create terminal
:TerminalToggle [name]     " Toggle terminal
```

### Git

```vim
:LazyGit                   " Open lazygit
```

---

## Tips & Tricks

### Macros

```vim
qq                         " Start recording to register q
" ... do actions ...
q                          " Stop recording
@q                         " Replay macro
@@                         " Replay last macro
```

### Marks

```vim
m<letter>                  " Set mark
'<letter>                  " Jump to mark
:marks                     " List marks
```

### Registers

```vim
"<letter>y                 " Yank to register
"<letter>p                 " Paste from register
:registers                 " List registers
"+y                        " Yank to system clipboard
"+p                        " Paste from system clipboard
```

### Fold

```vim
zo                         " Open fold
zc                         " Close fold
za                         " Toggle fold
zR                         " Open all folds
zM                         " Close all folds
```

### Jump List

```vim
Ctrl+o                     " Jump to previous location
Ctrl+i                     " Jump to next location
:jumps                     " Show jump list
```

---

## Muscle Memory Helpers

### "I want to..."

| Want to... | Use... |
|-----------|--------|
| Find a file | `<leader>ff` |
| Search for text | `<leader>fg` |
| See recent files | `<leader>s.` |
| Open terminal | `<leader>tw` (tmux window picker) |
| Get help | `<leader>c` (Claude Code) |
| Find a command | `<leader>p` |
| Format code | `<leader>lf` |
| Rename variable | `<leader>rn` |
| Commit code | `<leader>gg` |
| See errors | `<leader>xx` |

### "I'm in..." and want to...

| Context | Want to... | Use... |
|---------|-----------|--------|
| Editing | Save | `<leader>w` |
| Editing | Comment line | `gcc` |
| Visual mode | Comment | `gc` |
| Terminal | Exit to normal | `<Esc><Esc>` |
| Terminal | Hide | `<C-\><C-h>` |
| Code | See definition | `gd` |
| Code | See docs | `K` |
| Code | Rename | `<leader>rn` |

---

## Emergency Commands

### "Something's broken!"

```vim
:Lazy sync                 " Reinstall/update plugins
:LspRestart                " Restart LSP
:checkhealth               " Diagnose issues
:messages                  " See error messages
```

### "Start over!"

```bash
# From terminal (outside Neovim)
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
# Restart Neovim - will reinstall
```

---

## Printing This Reference

This reference is designed for quick lookup. Consider:
1. Keeping this file open in a split
2. Using `<leader>sh` to search help
3. Using `<leader>p` to discover commands on the fly

**Remember:** You don't need to memorize everything. The command palette (`<leader>p`) is your friend!

---

## Next Steps

1. **Start with essentials:** `<leader>ff`, `<leader>p`, `<leader>t`
2. **Learn one section per week:** File nav → LSP → Git → Advanced
3. **Use the command palette:** Type what you want to do
4. **Build muscle memory:** Repetition over memorization

**Happy coding!** 🚀
