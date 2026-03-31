--[[
Uses mason to install requested lsp, linters, and daps are installed
--]]

--[[ INSTALL --]]

vim.pack.add({ 'https://github.com/mason-org/mason.nvim' }, { confirm = false })
vim.pack.add({ 'https://github.com/mason-org/mason-lspconfig.nvim' }, { confirm = false })
vim.pack.add({ 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' }, { confirm = false })

--[[ SETUP --]]

require('mason').setup()
require('mason-lspconfig').setup()
require('mason-tool-installer').setup({
  ensure_installed = {
    -- Language Servers
    -- 'ansible-language-server',
    -- 'cssls',
    -- 'docker_language_server',
    -- 'jsonls',
    -- 'yamlls',
    -- 'html',
    -- 'sqlls'
    -- 'tailwindcss',
    -- 'terraform-ls',
    'vtsls',
    'vue-language-server',

    -- Debug Adapters
    'js-debug-adapter',

    -- Linters
  }
})