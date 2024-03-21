function ColorMyPencils(color)
  color = color or 'tokyonight-night'
  vim.cmd.colorscheme(color)
  vim.api.nvim_set_hl(0, 'Normal', {})
  vim.api.nvim_set_hl(0, 'NormalFloat', {})
end

return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = 'night', -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = false },
          keywords = { italic = false },
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = 'dark', -- style for sidebars, see below
          floats = 'dark', -- style for floating windows
        },
      }
      ColorMyPencils()
    end,
  },
}
