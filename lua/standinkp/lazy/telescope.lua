return {
  'nvim-telescope/telescope.nvim',

  tag = '0.1.5',

  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
  },

  config = function()
    require('telescope').setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = '[P]roject [F]iles' })
    vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Git [F]iles' })
    vim.keymap.set('n', '<leader>pws', function()
      local word = vim.fn.expand '<cword>'
      builtin.grep_string { search = word }
    end, { desc = 'Grep [W]ord under cursor' })
    vim.keymap.set('n', '<leader>pWs', function()
      local word = vim.fn.expand '<cWORD>'
      builtin.grep_string { search = word }
    end, { desc = 'Grep [W]ord under cursor' })
    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string { search = vim.fn.input 'Grep > ' }
    end, { desc = '[G]rep' })
    vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = '[V]im [H]elp' })
    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })
    vim.keymap.set('n', '<leader>pg', function()
      builtin.live_grep(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = true,
      })
    end, { desc = '[P]roject [G]rep' })
  end,
}
