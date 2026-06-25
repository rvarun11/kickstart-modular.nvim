local function gh(repo) return 'https://github.com/' .. repo end

-- Catppuccin colorscheme. Loaded after the kickstart default theme so it wins.
vim.pack.add { { src = gh 'catppuccin/nvim', name = 'catppuccin' } }

require('catppuccin').setup {
  flavour = 'macchiato', -- You can change this to "latte", "frappe", "macchiato", or "mocha"
  background = { light = 'latte', dark = 'mocha' },
  transparent_background = false,
  term_colors = true,
  integrations = {
    nvimtree = true,
    -- Add other integrations here
  },
}
vim.cmd.colorscheme 'catppuccin'
