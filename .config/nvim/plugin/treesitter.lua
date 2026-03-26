--[[ PRE-INSTALL --]]

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end
})

--[[ INSTALL --]]

vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' }, { confirm = false })

--[[ SETUP --]]

local nts = require('nvim-treesitter')
nts.install({
  -- 'bash',
  -- 'css',
  -- 'dockerfile',
  -- 'git_config',
  -- 'git_rebase',
  -- 'gitattributes',
  -- 'gitcommit',
  -- 'gitignore',
  -- 'html',
  -- 'javascript',
  -- 'json',
  -- 'robots_txt',
  -- 'scss',
  -- 'sql',
  -- 'tsx',
  'typescript',
  -- 'vim',
  'vue',
  -- 'xml',
  -- 'yaml'
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local filetype = args.match
    local lang = vim.treesitter.language.get_lang(filetype)
    if vim.treesitter.language.add(lang) then
      vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo[0][0].foldmethod = 'expr'
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.treesitter.start()
    end
  end
})
