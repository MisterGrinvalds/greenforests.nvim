-- LSP - Language Server Protocol configuration
local fork = require('lib.forks').fork

-- Servers to install via mason
local servers = {
  'pyright',
  'ts_ls',
  'gopls',
  'lua_ls',
  'bashls',
  'yamlls',
  'jsonls',
  'html',
  'cssls',
  'marksman',
}

return {
  -- Lazydev - Lua LSP for Neovim config
  {
    fork('folke/lazydev.nvim'),
    name = 'lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  -- Main LSP Configuration
  {
    fork('neovim/nvim-lspconfig'),
    dependencies = {
      { fork('mason-org/mason.nvim'), name = 'mason.nvim', opts = {} },
      fork('mason-org/mason-lspconfig.nvim'),
      fork('WhoIsSethDaniel/mason-tool-installer.nvim'),
      { fork('j-hui/fidget.nvim'), name = 'fidget.nvim', opts = {} },
      fork('saghen/blink.cmp'),
      fork('b0o/schemastore.nvim'),
    },
    config = function()
      -- Setup core LSP (keymaps, handlers, diagnostics, capabilities)
      require('core.lsp').setup()

      -- Install tools (formatters, linters)
      require('mason-tool-installer').setup({
        ensure_installed = {
          'stylua',
          'black',
          'isort',
          'prettier',
          'goimports',
          'shfmt',
        },
      })

      -- Install LSP servers via mason
      require('mason-lspconfig').setup({
        ensure_installed = servers,
        automatic_installation = true,
      })
    end,
  },
}
