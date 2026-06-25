local function gh(repo) return 'https://github.com/' .. repo end

-- none-ls exposes external tools (e.g. stylua) as an LSP source.
vim.pack.add {
  gh 'nvim-lua/plenary.nvim',
  gh 'nvimtools/none-ls.nvim',
}

local null_ls = require 'null-ls'
null_ls.setup {
  sources = {
    null_ls.builtins.formatting.stylua,
  },
}
