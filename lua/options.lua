-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
--  See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Indentation settings
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Make line numbers default
vim.o.relativenumber = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Enable break indent
vim.o.breakindent = true

-- Enable undo/redo changes even after closing and reopening a file
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-guide-options`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- NOTE: (varun): Adding this to prevent duplicate errors from showing up.
-- This won't be needed if the linters are configured properly. Currently happening with python setup only,
-- haven't tested with others.
vim.diagnostic.config {
  -- This will deduplicate diagnostics with the same message
  duplicates = {
    severity = vim.diagnostic.severity.ERROR,
    max_displayed = 1, -- Only show one instance of duplicate diagnostics
  },
}

-- Auto-reload files changed on disk
vim.o.autoread = true

local reload_group = vim.api.nvim_create_augroup('auto-reload', { clear = true })

-- Guard against focus steal: the real hazard is running reload work while a
-- floating window (Telescope's prompt is a float, buftype 'prompt') or the
-- cmdline window is focused — that knocks the prompt out of insert mode. A normal
-- file buffer OR fugitive's status buffer (buftype 'nowrite') is safe to run
-- under, so exclude only floats, the cmdline window, and prompt buffers. Excluding
-- 'nowrite' here is what previously stopped ':0G' from refreshing in a bg pane.
local function safe_to_refresh()
  return vim.fn.getcmdwintype() == '' -- not in the cmdline window
    and vim.api.nvim_win_get_config(0).relative == '' -- not a floating window (Telescope, etc.)
    and vim.bo.buftype ~= 'prompt' -- not a prompt buffer (would lose insert mode)
end

-- Interactive path: reload changed files + refresh fugitive on focus/enter/idle.
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  group = reload_group,
  callback = function()
    if safe_to_refresh() then vim.cmd 'silent! checktime' end
  end,
})
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  group = reload_group,
  callback = function()
    if safe_to_refresh() then pcall(vim.fn['fugitive#DidChange']) end
  end,
})

-- Background poll for UNFOCUSED split panes (focus/buffer autocmds never fire for
-- them). This is what lets an unfocused nvim pane track edits a tool makes in
-- another tmux pane: checktime reloads changed file buffers, and fugitive#DidChange
-- re-renders any open ':0G' status buffer so its tree stays live (no-op if none).
local reload_timer = assert((vim.uv or vim.loop).new_timer())
reload_timer:start(
  1000,
  1000,
  vim.schedule_wrap(function()
    if not safe_to_refresh() then return end
    vim.cmd 'silent! checktime'
    pcall(vim.fn['fugitive#DidChange'])
  end)
)

-- vim: ts=2 sts=2 sw=2 et
