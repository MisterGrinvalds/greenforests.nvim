---
sidebar_position: 0
slug: /
title: Documentation Home
description: Welcome to the Neovim configuration documentation
---

# Neovim Configuration Documentation

Welcome to the comprehensive documentation for this Neovim setup!

## 📚 Documentation Structure

### [User Guide](./user-guide)
**Start here if you're new!**

Complete guide to understanding and using this Neovim configuration:
- Philosophy and core concepts
- Getting started (day-by-day learning path)
- Essential workflows
- Troubleshooting

**Perfect for:** Learning the system, understanding the "why" behind decisions

### [Plugin Guide](./plugin-guide)
**Deep dive into each plugin**

Detailed documentation for every plugin in this setup:
- Custom plugins (command-palette, terminal-manager, claude-code)
- Community plugins (telescope, LSP, treesitter, etc.)
- Configuration options
- Advanced usage

**Perfect for:** Understanding what each tool does, learning advanced features

### [Quick Reference](./quick-reference)
**Cheat sheet for daily use**

Concise reference for all keybindings and commands:
- Organized by category
- Quick lookup tables
- Common patterns
- Emergency commands

**Perfect for:** Quick lookups, learning keybindings, keeping as reference

---

## 🚀 Quick Start

### Absolute Beginner?

1. Read the [Philosophy section](./user-guide#philosophy)
2. Follow the [Getting Started guide](./user-guide#getting-started)
3. Practice Day 1-5 exercises
4. Keep [Quick Reference](./quick-reference) open while working

### Intermediate User?

1. Skim [Core Concepts](./user-guide#core-concepts)
2. Browse [Essential Workflows](./user-guide#essential-workflows)
3. Explore [Plugin Guide](./plugin-guide) for features you want to use
4. Customize configs in `lua/custom/plugins/`

### Advanced User?

1. Check [Advanced Topics](./user-guide#advanced-topics)
2. Read plugin source code in `lua/custom/plugins/`
3. Contribute improvements!
4. Share your custom plugins

---

## 🎯 The Three Essential Keybindings

:::tip Remember These Three

**1. `<leader>p` - Command Palette**
- Can't remember a command? Press this and search
- Fuzzy find any command across all plugins
- Context-aware (shows relevant commands)

**2. `<leader>t` - Terminal Picker**
- Manage multiple terminal sessions
- Quick toggle between terminals
- Perfect for dev servers, git, tests

**3. `<leader>cc` - Claude Code**
- AI assistance for coding
- Ask questions, get help, review code
- Integrated right into Neovim
:::

Everything else is discoverable through these three!

---

## 📖 Learning Path

### Week 1: Foundations
- **Goal:** Navigate without mouse
- **Focus:** File finding, buffers, basic editing
- **Resources:** [User Guide - Day 1 & 2](./user-guide#day-1-basic-navigation)

### Week 2: Discovery
- **Goal:** Use command palette naturally
- **Focus:** Finding features, understanding categories
- **Resources:** [User Guide - Day 3](./user-guide#day-3-command-palette--discovery)

### Week 3: Terminals
- **Goal:** Multi-terminal workflow
- **Focus:** Named sessions, quick toggle
- **Resources:** [User Guide - Day 4](./user-guide#day-4-terminal-workflow)

### Week 4: Code Intelligence
- **Goal:** IDE-level productivity
- **Focus:** LSP, refactoring, diagnostics
- **Resources:** [User Guide - Day 5](./user-guide#day-5-lsp--code-intelligence)

---

## 🔧 Configuration

### File Structure

```
kickstart.nvim/
├── init.lua                      # Main configuration
├── lua/
│   └── custom/
│       └── plugins/              # Plugin configurations
│           ├── command-palette.lua
│           ├── terminal-manager.lua
│           ├── claude-code.lua
│           └── ... (community plugins)
└── .claude/
    └── docs/                     # Documentation
        ├── README.md             # This file
        ├── user-guide.md
        ├── plugin-guide.md
        └── quick-reference.md
```

### Customizing

**Add a Plugin:**
1. Create `lua/custom/plugins/myplugin.lua`
2. Return plugin spec (see examples)
3. Restart Neovim
4. `:Lazy sync`

**Modify Keybinding:**
1. Edit `init.lua` or plugin config
2. Run `:source %` to reload
3. Test the new binding

**Change LSP Settings:**
1. Edit LSP section in `init.lua`
2. Restart Neovim or `:LspRestart`

---

## 🎨 Philosophy Recap

This configuration is built around:

### 1. Discoverability Over Memorization
You don't need to memorize hundreds of shortcuts. The command palette, which-key, and Telescope help you discover features as you need them.

### 2. Keyboard-First Workflow
Everything is accessible via keyboard. The goal is to keep your hands on the home row and maintain flow state.

### 3. Context-Aware Intelligence
The setup adapts to what you're doing. LSP actions appear when editing code, git commands in git repos, project-specific tools auto-detect.

---

## 🛟 Getting Help

### In Neovim

```vim
<leader>p               # Command palette - search for what you need
<leader>cc              # Ask Claude Code for help
:help <topic>           # Built-in help system
:checkhealth            # Diagnose issues
```

### Documentation

- **Can't remember a command?** → [Quick Reference](./quick-reference)
- **Want to learn a plugin?** → [Plugin Guide](./plugin-guide)
- **Getting started?** → [User Guide](./user-guide)
- **Something broken?** → [Troubleshooting](./user-guide#troubleshooting)

### External Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Vim Tutor](https://github.com/vim/vim/blob/master/runtime/tutor/tutor) - Run `:Tutor`
- [Learn Vim Progressively](http://yannesposito.com/Scratch/en/blog/Learn-Vim-Progressively/)

---

## 🌟 Key Features

### Custom Plugins

**Command Palette**
- VS Code-style command palette
- Context-aware command suggestions
- Frecency-based ranking (learns your patterns)
- Multi-source aggregation

**Terminal Manager**
- Multiple named terminal sessions
- Persistent buffers (survive hide/show)
- Quick picker interface
- Integrates with command palette

**Claude Code**
- AI assistance integrated in Neovim
- Context injection (files, selections, diagnostics)
- Toggle-able window
- Command palette integration

### Community Plugins

- **Telescope** - Fuzzy finder for everything
- **LSP** - IDE-like code intelligence
- **Treesitter** - Better syntax highlighting
- **Lazygit** - Git TUI
- **Harpoon** - Quick file marks
- **And many more!** See [Plugin Guide](./plugin-guide)

---

## 📊 Keybinding Categories

Quick overview of keybinding organization:

| Prefix | Category | Examples |
|--------|----------|----------|
| `<leader>f` | Find/File | `ff` (files), `fg` (grep) |
| `<leader>s` | Search | `sc` (commands), `sh` (help) |
| `<leader>g` | Git | `gg` (lazygit), `gd` (diff) |
| `<leader>t` | Terminal | `t` (picker), `tt` (toggle) |
| `<leader>b` | Buffer | `bd` (delete), `bj` (jump) |
| `<leader>c` | Claude | `cc` (toggle), `cf` (file) |
| `<leader>x` | Diagnostics | `xx` (all), `xX` (buffer) |
| `<leader>w` | Window/Write | `w` (save), `wh/j/k/l` (swap) |
| `g` | Go to | `gd` (definition), `gr` (references) |

---

## 🎓 From Good to Great

### Beginner → Intermediate
- ✅ Use `<leader>p` when stuck
- ✅ Navigate with `hjkl` instead of arrows
- ✅ Use Telescope instead of file tree
- ✅ Learn one new motion per day

### Intermediate → Advanced
- ✅ Use LSP for all code navigation
- ✅ Master terminal workflow
- ✅ Learn text objects (`ciw`, `dap`, etc.)
- ✅ Create custom keybindings

### Advanced → Expert
- ✅ Write custom plugins
- ✅ Optimize workflow with macros
- ✅ Contribute to community plugins
- ✅ Share knowledge with others

---

## 💡 Pro Tips

1. **Don't Memorize Everything** - Use `<leader>p` to discover
2. **Build Muscle Memory Gradually** - Focus on one category per week
3. **Customize for Your Workflow** - The config is yours to modify
4. **Use Claude Code** - When stuck, ask for help!
5. **Keep Quick Reference Open** - In a split window while learning
6. **Practice in Real Projects** - The best way to learn
7. **Join the Community** - Share tips, learn from others

---

## 🚦 Status & Updates

This documentation is actively maintained and updated as the configuration evolves.

**Last Updated:** 2025-12-31

**Version:** 1.0.0

**Neovim Version:** 0.9+

---

## 🤝 Contributing

Found an issue? Have a suggestion? Want to add a plugin?

1. Document your changes
2. Update relevant guides
3. Test thoroughly
4. Share with others!

---

## 📝 License

This configuration and documentation are open source. Use, modify, and share freely!

---

## 🎉 Final Words

This Neovim setup is designed to be:
- **Powerful** - IDE-level features with Vim efficiency
- **Learnable** - Discoverability over memorization
- **Extensible** - Easy to customize and extend
- **Enjoyable** - Makes coding fun!

**Remember:** You don't need to learn everything at once. Start with the essentials, use the command palette when stuck, and gradually build your muscle memory.

**Happy coding!** 🚀

---

**Next Steps:**
1. Read the [User Guide](./user-guide) to get started
2. Explore the [Plugin Guide](./plugin-guide) for deep dives
3. Keep the [Quick Reference](./quick-reference) handy
4. Most importantly: **Start coding!**
