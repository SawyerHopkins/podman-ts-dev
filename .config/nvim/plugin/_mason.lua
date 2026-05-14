--[[
Uses mason to install requested lsp, linters, and daps are installed
--]]

--[[ INSTALL --]]

vim.pack.add({ 'https://github.com/mason-org/mason.nvim' }, { confirm = false })
vim.pack.add({ 'https://github.com/mason-org/mason-lspconfig.nvim' }, { confirm = false })

--[[ SETUP --]]

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'vtsls', 'vue_ls' },
})

