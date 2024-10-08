return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require 'null-ls'
    null_ls.setup {
      source = {
        null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.formatting.isort,
        -- null_ls.builtins.formatting.black,
        null_ls.builtins.diagnostics.mypy,
        -- null_ls.builtins.formatting.prettier,
      },
    }
  end,
}
