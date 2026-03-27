--[[
Adds (fuzzy) search functionality for various providers (buffers, lsp, git)
--]]

--[[ INSTALL --]]

vim.pack.add({ 'https://github.com/nvim-lua/plenary.nvim' }, { confirm = false })
vim.pack.add({ 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' }, { confirm = false })
vim.pack.add({ 'https://github.com/nvim-telescope/telescope.nvim' }, { confirm = false })
vim.pack.add({ 'https://github.com/folke/which-key.nvim' }, { confirm = false })

--[[ SETUP --]]

require('telescope').setup()
local builtin = require('telescope.builtin')

vim.api.nvim_create_autocmd('User', {
  pattern = 'TelescopePreviewerLoaded',
  callback = function(args)
    if args.data.filetype ~= 'help' then
      vim.wo.number = true
    elseif args.data.bufname:match('*.csv') then
      vim.wo.wrap = false
    end
  end,
})

--[[ KEY BINDINGS --]]

-- Global search (find) key binds
vim.keymap.set('n', '<leader>fac', builtin.autocommands, { desc = 'Telescope auto commands' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope keymaps' })
vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = 'Telescope registers' })
vim.keymap.set('n', '<leader>fsp', builtin.spell_suggest, { desc = 'Telescope spelling suggestions' })
vim.keymap.set('n', '<leader>fS', builtin.lsp_workspace_symbols, { desc = 'Telescope workspace symbols' })
require('which-key').add({
  { '<leader>f', group = '[f]ind' }
})

-- Local search (find) key finds
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Telescope diagnostics' })
vim.keymap.set('n', '<leader>sf', builtin.current_buffer_fuzzy_find, { desc = 'Telescope search buffer' })
vim.keymap.set('n', '<leader>ss', builtin.lsp_document_symbols, { desc = 'Telescope document symbols' })
vim.keymap.set('n', '<leader>sq', builtin.quickfix, { desc = 'Telescope quick fix' })
vim.keymap.set('n', '<leader>st', builtin.treesitter, { desc = 'Telescope treesitter' })
vim.keymap.set('n', '<leader>sT', builtin.current_buffer_tags, { desc = 'Telescope search buffer tags' })
require('which-key').add({
  { '<leader>s', group = '[s]earch' }
})

-- Git key binds
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Telescope git branches' })
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Telescope commits' })
vim.keymap.set('n', '<leader>gC', builtin.git_bcommits, { desc = 'Telescope buffer commits' })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Telescope git status' })
vim.keymap.set('n', '<leader>gS', builtin.git_stash, { desc = 'Telescope git stash' })
require('which-key').add({
  { '<leader>g', group = '[g]it' }
})

-- LSP key binds
vim.keymap.set('n', 'gai', builtin.lsp_incoming_calls, { desc = 'Telescope incoming calls' })
vim.keymap.set('n', 'gao', builtin.lsp_outgoing_calls, { desc = 'Telescope outgoing calls' })
vim.keymap.set('n', 'gd', builtin.lsp_definitions, { desc = 'Telescope definition' })
vim.keymap.set('n', 'gI', builtin.lsp_implementations, { desc = 'Telescope implementation' })
vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = 'Telescope references' })
vim.keymap.set('n', 'gy', builtin.lsp_type_definitions, { desc = 'Telescope type definition' })
