# claude-code.nvim - Neovim Plugin

A native Neovim integration for Claude Code with a toggleable window and context injection commands.

Inspired by the [VS Code Claude Code extension](https://marketplace.visualstudio.com/items?itemName=anthropic.claude-code).

## Features

- **Toggle Window**: Floating or split window running Claude Code
- **Context Injection**: Send files, selections, and diagnostics to Claude
- **Command Palette**: Telescope picker with common actions
- **Native Commands**: User commands available in command mode

## Keybindings

| Key | Action |
|-----|--------|
| `<Space>cc` | Toggle Claude Code window |
| `<Space>cf` | Send current file to Claude |
| `<Space>cs` | Send visual selection to Claude |
| `<Space>cd` | Send LSP diagnostics to Claude |
| `<Space>cb` | Send buffer with full context |
| `<Space>cp` | Open command palette |
| `<Space>ca` | Ask Claude (prompt input) |

## Commands

All commands are available via `:Claude*`:

```vim
:ClaudeToggle          " Toggle the Claude Code window
:ClaudeOpen            " Open the Claude Code window
:ClaudeClose           " Close the Claude Code window
:ClaudeSendFile        " Send current file to Claude
:ClaudeSendDiagnostics " Send LSP diagnostics to Claude
:ClaudeSendBuffer      " Send buffer with full context
:ClaudeCommands        " Open command palette
:ClaudeAsk [prompt]    " Ask Claude a question
```

## Command Palette Actions

The command palette (`<Space>cp`) includes:

- Toggle Claude Code
- Send Current File
- Send Selection
- Send Diagnostics
- Send Buffer with Context
- Ask: Explain this code
- Ask: Find bugs
- Ask: Optimize
- Ask: Add tests
- Ask: Refactor
- Ask: Add documentation

## Configuration

The plugin is configured in `lua/custom/plugins/claude-code.lua`:

```lua
require('custom.plugins.claude-code').setup({
  window = {
    position = 'float', -- 'float', 'right', 'left', 'bottom'
    width = 0.4,        -- 40% of screen width
    height = 0.8,       -- 80% of screen height
    border = 'rounded',
  },
  keymaps = {
    toggle = '<leader>cc',
    send_file = '<leader>cf',
    send_selection = '<leader>cs',
    send_diagnostics = '<leader>cd',
    send_buffer = '<leader>cb',
    command_palette = '<leader>cp',
  },
  auto_scroll = true,
  close_on_exit = true,
})
```

## Window Positions

### Float (default)
Opens a floating window on the right side of the screen.

### Right/Left Split
Opens a vertical split on the right or left side.

### Bottom Split
Opens a horizontal split at the bottom.

## Usage Tips

1. **Quick Toggle**: Use `<Space>cc` to show/hide Claude Code
2. **Send Context**: Select code visually, then `<Space>cs` to ask about it
3. **Fix Errors**: When you have LSP errors, use `<Space>cd` to ask Claude to fix them
4. **Full Context**: Use `<Space>cb` to send the entire file plus diagnostics

## Integration with Ghostty

When using the Ghostty workflow (left: Claude CLI, right: Neovim), you can use this plugin in addition:

- The floating window provides quick access without leaving Neovim
- Use `Ctrl+hjkl` to switch to the Ghostty Claude pane for longer sessions
- Use the floating window for quick questions and context injection

## Troubleshooting

### Window doesn't open
Make sure `claude` CLI is installed and in your PATH.

### Terminal doesn't start
Check that you have a working terminal setup in Neovim.

### Keybindings conflict
Modify the keymaps in the configuration to use different keys.
