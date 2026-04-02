--[[
Installs AI agent cli integration tool
--]]

--[[ INSTALL --]]

vim.pack.add({ "https://www.github.com/nvim-lua/plenary.nvim" }, { confirm = false })
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" }, { confirm = false })
vim.pack.add({ 'https://www.github.com/olimorris/codecompanion.nvim' }, { confirm = false })

--[[ SETUP --]]

require("codecompanion").setup({
  interactions = {
    chat = { adapter = "ollama" },
    inline = { adapter = "ollama" },
    cmd = { adapter = "ollama" },
  },
})
