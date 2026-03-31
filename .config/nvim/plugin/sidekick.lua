--[[
Installs AI agent cli integration tool
--]]

--[[ INSTALL --]]

vim.pack.add({ 'https://github.com/folke/sidekick.nvim' }, { confirm = false })

--[[ SETUP --]]

require('sidekick').setup({
  nes = {
    enabled = false
  }
})