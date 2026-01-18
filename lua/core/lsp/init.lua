-- Core LSP configuration using Neovim 0.11+ native API
local M = {}

function M.setup()
  -- Load keymaps and handlers
  require('core.lsp.keymaps').setup()
  require('core.lsp.handlers').setup()

  -- Global LSP defaults for all servers
  vim.lsp.config('*', {
    capabilities = require('blink.cmp').get_lsp_capabilities(),
  })

  -- Diagnostic configuration
  vim.diagnostic.config({
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = vim.g.have_nerd_font and {
      text = {
        [vim.diagnostic.severity.ERROR] = '󰅚 ',
        [vim.diagnostic.severity.WARN] = '󰀪 ',
        [vim.diagnostic.severity.INFO] = '󰋽 ',
        [vim.diagnostic.severity.HINT] = '󰌶 ',
      },
    } or {},
    virtual_text = {
      source = 'if_many',
      spacing = 2,
      format = function(diagnostic)
        return diagnostic.message
      end,
    },
  })

  -- Enable servers (those without custom configs in after/lsp/)
  vim.lsp.enable({
    'pyright',
    'ts_ls',
    'html',
    'cssls',
    'marksman',
    -- Servers with custom configs in after/lsp/ are auto-enabled
    'gopls',
    'lua_ls',
    'bashls',
    'yamlls',
    'jsonls',
  })
end

return M
