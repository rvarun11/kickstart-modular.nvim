local function gh(repo) return 'https://github.com/' .. repo end

-- Auto close/rename HTML/JSX tags. Depends on treesitter (loaded before custom plugins).
vim.pack.add { gh 'windwp/nvim-ts-autotag' }
require('nvim-ts-autotag').setup {}
