vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Open netrw' })
-- open mini files
--[[vim.keymap.set('n', '<leader>_', function()
  require('mini.files').open(vim.loop.cwd(), true)
end, { desc = 'Open mini' })

vim.keymap.set('n', '<leader>-', function()
  require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
end, { desc = 'Open mini' })
]]
--
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move the selected lines down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move the selected lines up' })

vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Move to next search match' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Move to previous search match' })

-- greatest remap ever
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste over the selected text' })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Copy to nvim clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Copy to system clipboard' })

vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete without yanking' })

-- This is going to get me cancelled
vim.keymap.set('i', '<C-c>', '<cmd>w<CR><Esc>', { desc = 'Exit insert mode' })

vim.keymap.set('n', 'Q', '<nop>', { desc = 'Disable Ex mode' })
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>', { desc = 'Open tmux-sessionizer' })
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'Format the current buffer' })

vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz', { desc = 'Move to the next quickfix item' })
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz', { desc = 'Move to the previous quickfix item' })
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz', { desc = 'Move to the next location list item' })
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz', { desc = 'Move to the previous location list item' })

vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace the word under the cursor all over the document' })
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'Make the current file executable' })

vim.keymap.set('n', '<leader><leader>', function()
  vim.cmd 'so'
end, { desc = 'Source the current file' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the upper window' })
