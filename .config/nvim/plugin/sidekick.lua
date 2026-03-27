vim.pack.add({ 'https://github.com/folke/sidekick.nvim' }, { confirm = false })

require('sidekick').setup({
  nes = {
    enabled = false
  }
})