local function gh(repo) return 'https://github.com/' .. repo end

-- Seamless navigation between tmux panes and vim splits with <C-h/j/k/l>.
-- The plugin installs its default <C-hjkl> mappings on load, overriding the
-- plain window-navigation maps from keymaps.lua.
vim.pack.add { gh 'christoomey/vim-tmux-navigator' }
