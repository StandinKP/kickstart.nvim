return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup {
      ---@diagnostic disable-next-line: missing-fields
      ensure_installed = {
        'vimdoc',
        'javascript',
        'lua',
        'go',
        'python',
        'typescript',
        'rust',
        'jsdoc',
        'bash',
      },
      sync_install = false,
      auto_install = true,
      indent = {
        enable = true,
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'markdown' },
      },
    }
  end,
}
