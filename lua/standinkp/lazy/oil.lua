return {
  'stevearc/oil.nvim',
  opts = {
    keymaps = {
      ['<C-s>'] = false,
      ['<C-h>'] = false,
      ['<C-t>'] = false,
      ['<C-l>'] = false,
      ['<C-q>'] = 'actions.refresh',
    },
  },
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
