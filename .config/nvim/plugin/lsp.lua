--[[
Uses mason to install requested language server binaries and
makes them available using nvim-lspconfig (managed through vim.lsp as of 0.11).
Provides data for code completion, diagnostics, and formatting.
--]]

--[[ INSTALL --]]

vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' }, { confirm = false })
vim.pack.add({ 'https://github.com/mason-org/mason.nvim' }, { confirm = false })
vim.pack.add({ 'https://github.com/mason-org/mason-lspconfig.nvim' }, { confirm = false })
vim.pack.add({ 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' }, { confirm = false })

--[[ SETUP --]]

require('mason').setup()
require('mason-lspconfig').setup()
require('mason-tool-installer').setup({
  ensure_installed = {
    -- 'cssls',
    -- 'docker_language_server',
    -- 'jsonls',
    -- 'yamlls',
    -- 'html',
    -- 'sqlls'
    -- 'tailwindcss',
    'vtsls',
    'vue-language-server'
  }
})

vim.lsp.config('vue_ls', {})
vim.lsp.config('vtsls', {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = '@vue/typescript-plugin',
            location = vim.fn.stdpath('data') .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
            languages = { 'vue' },
            configNamespace = 'typescript',
          }
        },
      },
    },
  },
  filetypes = {
    'typescript',
    'javascript',
    'javascriptreact',
    'typescriptreact',
    'vue'
  },
  on_attach = function(client)
    local existing_capabilities = client.server_capabilities
    if vim.bo.filetype == 'vue' then
      existing_capabilities.semanticTokensProvider.full = false
    else
      existing_capabilities.semanticTokensProvider.full = true
    end
  end
})

vim.lsp.enable({'vtsls', 'vue_ls'})
