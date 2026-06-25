local function gh(repo) return 'https://github.com/' .. repo end

-- Git wrapper (`:Git`, `:G`). Status buffers are live-refreshed by the poll timer in options.lua.
vim.pack.add { gh 'tpope/vim-fugitive' }
