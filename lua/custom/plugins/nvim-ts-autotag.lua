---@module 'lazy'
---@type LazySpec
return {
  'windwp/nvim-ts-autotag',
  event = { 'BufReadPre', 'BufNewFile' },
  ft = { 'html', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'xml' },
  opts = {},
}
-- vim: ts=2 sts=2 sw=2 et
