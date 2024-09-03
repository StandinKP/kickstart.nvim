require 'standinkp.set'
require 'standinkp.remap'

require 'standinkp.lazy_init'

local augroup = vim.api.nvim_create_augroup
local TheStandinKPGroup = augroup('standinkp', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
  require('plenary.reload').reload_module(name)
end

autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank {
      higroup = 'IncSearch',
      timeout = 40,
    }
  end,
})

autocmd({ 'BufWritePre' }, {
  group = TheStandinKPGroup,
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

autocmd('LspAttach', {
  group = TheStandinKPGroup,
  callback = function(e)
    vim.keymap.set('n', 'gd', function()
      vim.lsp.buf.definition()
    end, { buffer = e.buf, desc = '[G]oto [D]efinition' })
    vim.keymap.set('n', 'K', function()
      vim.lsp.buf.hover()
    end, { buffer = e.buf, desc = 'Hover' })
    vim.keymap.set('n', '<leader>vws', function()
      vim.lsp.buf.workspace_symbol()
    end, { buffer = e.buf, desc = '[V]iew [W]orkspace [S]ymbol' })
    vim.keymap.set('n', '<leader>vd', function()
      require('trouble').toggle { mode = 'document_diagnostics' }
    end, { buffer = e.buf, desc = '[V]iew [D]iagnostics' })
    vim.keymap.set('n', '<leader>vca', function()
      vim.lsp.buf.code_action()
    end, { buffer = e.buf, desc = '[V]iew [C]ode [A]ction' })
    vim.keymap.set('n', '<leader>vrr', function()
      vim.lsp.buf.references()
    end, { buffer = e.buf, desc = '[V]iew [R]eferences' })
    vim.keymap.set('n', '<leader>vrn', function()
      vim.lsp.buf.rename()
    end, { buffer = e.buf, desc = '[V]iew [R]ename' })
    vim.keymap.set('i', '<C-h>', function()
      vim.lsp.buf.signature_help()
    end, { buffer = e.buf, desc = 'Signature [H]elp' })
    vim.keymap.set('n', '[d', function()
      require('trouble').next { jump = true, skip_groups = true }
    end, { buffer = e.buf, desc = '[D]iagnostic [N]ext' })
    vim.keymap.set('n', ']d', function()
      require('trouble').previous { jump = true, skip_groups = true }
    end, { buffer = e.buf, desc = '[D]iagnostic [P]revious' })
  end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
