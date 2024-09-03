return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VimEnter',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'tokyonight',
          globalstatus = true,
          component_separators = { left = '', right = '' },
          section_separators = { left = '█', right = '█' },
          disabled_filetypes = {},
          always_divide_middle = true,
        },
        sections = {
          lualine_c = {
            { 'filename', path = 1 },
          },
          lualine_z = {
            {
              function()
                return vim.api.nvim_call_function('codeium#GetStatusString', {})
              end,
            },
            {
              function()
                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                  if vim.api.nvim_buf_get_option(buf, 'modified') then
                    return 'Unsaved buffers' -- any message or icon
                  end
                end
                return ''
              end,
            },
          },
        },
      }
    end,
  },
}
