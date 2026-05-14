--[[
Provides data for code completion, diagnostics, and formatting.
--]]

--[[ INSTALL --]]

vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' }, { confirm = false })

--[[ SETUP --]]

vim.lsp.config('vue_ls', {
  init_options = {
    languageFeatures = {
      defaultTagNameCase = 'pascalCase',
      defaultAttrNameCase = 'kebabCase',
    },
    vue = {
      hybridMode = true
    }
  }
})

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
    typescript = {
      updateImportsOnFileMove = { enabled = 'always' },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = 'literals' },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
      preferences = {
        importModuleSpecifier = 'shortest',
        importModuleSpecifierEnding = 'minimal',
        jsxAttributeCompletionStyle = 'auto',
        quoteStyle = 'single',
        useAliasesForRenames = false,
        autoImportFileExcludePatterns = {
          'node_modules/*',
        },
      },
    },
    javascript = {
      updateImportsOnFileMove = { enabled = 'always' },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = 'literals' },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
      preferences = {
        importModuleSpecifier = 'shortest',
        importModuleSpecifierEnding = 'minimal',
        jsxAttributeCompletionStyle = 'auto',
        quoteStyle = 'single',
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

