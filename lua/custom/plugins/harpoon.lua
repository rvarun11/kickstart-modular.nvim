local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'nvim-lua/plenary.nvim',
  { src = gh 'ThePrimeagen/harpoon', version = 'harpoon2' },
}

local harpoon = require 'harpoon'

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end)
vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set('n', '<Tab>1', function() harpoon:list():select(1) end, { desc = 'Harpoon file 1' })
vim.keymap.set('n', '<Tab>2', function() harpoon:list():select(2) end, { desc = 'Harpoon file 2' })
vim.keymap.set('n', '<Tab>3', function() harpoon:list():select(3) end, { desc = 'Harpoon file 3' })
vim.keymap.set('n', '<Tab>4', function() harpoon:list():select(4) end, { desc = 'Harpoon file 4' })
vim.keymap.set('n', '<Tab>5', function() harpoon:list():select(5) end, { desc = 'Harpoon file 5' })

vim.keymap.set('n', '<leader>hj', function() harpoon:list():next() end, { desc = 'Harpoon next' })
vim.keymap.set('n', '<leader>hk', function() harpoon:list():prev() end, { desc = 'Harpoon previous' })
