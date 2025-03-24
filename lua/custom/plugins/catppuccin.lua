return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  lazy = false,
  config = function()
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
  end,
}
