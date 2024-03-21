return {
  {
    'nvim-lua/plenary.nvim',
    name = 'plenary',
  },
  'github/copilot.vim',
  { 'eandrju/cellular-automaton.nvim', lazy = true },
  'gpanders/editorconfig.nvim',
  {
    'echasnovski/mini.nvim',
    version = false,
    lazy = true,
    config = function()
      require('mini.files').setup()
    end,
  },
}
