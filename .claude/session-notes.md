# Session Notes

---

## Session: 2026-01-04 - LSP Enhancement

### Status: COMPLETE (needs verification)

### What We Built
Extended LSP support for Bash, YAML, JSON with schema validation, plus a comprehensive `/lsp` management agent.

### Files Modified
| File | Changes |
|------|---------|
| `lua/plugins/lsp.lua` | Added schemastore.nvim dep, bashls, yamlls, jsonls servers, shfmt tool |
| `lua/plugins/formatting.lua` | Added sh, bash, yaml formatters |
| `lua/plugins/treesitter.lua` | Added yaml parser |

### Files Created
| File | Purpose |
|------|---------|
| `.claude/commands/lsp.md` | `/lsp` agent for full LSP management |

### Fork Created
- `MisterGrinvalds/b0o.schemastore.nvim` - JSON/YAML schema catalog

### New Language Support
| Language | LSP | Formatter | Schemas |
|----------|-----|-----------|---------|
| Bash | bashls | shfmt | - |
| YAML | yamlls | prettier | Kubernetes, Docker Compose, GitHub Actions |
| JSON | jsonls | prettier | package.json, tsconfig.json, 300+ more |

### LSP Agent Commands
- `/lsp status` - View all servers and tools
- `/lsp add {lang}` - Add new language server
- `/lsp diagnose [server]` - Troubleshoot issues
- `/lsp optimize {server}` - Performance tuning
- `/lsp mason` - Package management
- `/lsp health` - Full health check
- `/lsp research {lang}` - Research best setup
- `/lsp remove {server}` - Remove a server

### Verification Needed
1. Run `:Lazy sync` to install schemastore.nvim
2. Mason will auto-install: bashls, yamlls, jsonls, shfmt
3. Test:
   - `.sh` file → bashls attached
   - `.yaml` file → yamlls with schema support
   - `package.json` → jsonls with schema completions
4. Run `:LspInfo` on each filetype to confirm

### Note
The `/lsp` skill was created but may need Claude Code restart to register.

---

## Session: 2026-01-02 - Plugin Forking System

## What We Built: Plugin Forking System

A system to fork Neovim plugins to your GitHub account (`MisterGrinvalds/<owner>.<repo>`) and manage them via Claude Code commands.

## Files Created

### Core Function
- `lua/lib/forks.lua` - Lua module with `fork()` and `is_fork()` functions

### Claude Code Commands
- `.claude/commands/review-plugins.md` - `/review-plugins`
- `.claude/commands/fork-plugin.md` - `/fork-plugin owner/repo`
- `.claude/commands/replace-with-fork.md` - `/replace-with-fork owner/repo`
- `.claude/commands/update-forks.md` - `/update-forks`

## Testing

### 1. Test the Lua function in Neovim

```vim
:lua print(require('lib.forks').fork('nvim-telescope/telescope.nvim'))
" Expected: MisterGrinvalds/nvim-telescope.telescope.nvim

:lua print(require('lib.forks').is_fork('MisterGrinvalds/nvim-telescope.telescope.nvim'))
" Expected: true

:lua print(require('lib.forks').get_original('MisterGrinvalds/ThePrimeagen.harpoon'))
" Expected: ThePrimeagen/harpoon
```

### 2. Test Claude Code Commands

```bash
# List all plugins
claude /review-plugins

# Fork a plugin (creates GitHub fork + updates config)
claude /fork-plugin ThePrimeagen/harpoon

# Just update config to use existing fork
claude /replace-with-fork ThePrimeagen/harpoon

# Sync all forks with upstream
claude /update-forks
```

### 3. Manual Usage in Plugin Spec

Edit any plugin file, e.g., `lua/custom/plugins/harpoon.lua`:

```lua
local fork = require('lib.forks').fork

return {
  fork('ThePrimeagen/harpoon'),  -- resolves to MisterGrinvalds/ThePrimeagen.harpoon
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  ...
}
```

## Fork Naming Convention

| Original | Fork |
|----------|------|
| `owner/repo` | `MisterGrinvalds/owner.repo` |
| `ThePrimeagen/harpoon` | `MisterGrinvalds/ThePrimeagen.harpoon` |
| `nvim-telescope/telescope.nvim` | `MisterGrinvalds/nvim-telescope.telescope.nvim` |

## Commits

- `f02fcc1` - feat: update config and add setup Makefile
- `69abcbb` - feat: add plugin forking system

## Next Steps

1. Test `/review-plugins` to see current plugin inventory
2. Pick a plugin to fork as a test (e.g., `ThePrimeagen/harpoon`)
3. Run `/fork-plugin ThePrimeagen/harpoon` to test full automation
4. Verify with `:Lazy sync` in Neovim
