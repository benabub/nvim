return {
  'SmiteshP/nvim-navbuddy',
  dependencies = {
    'SmiteshP/nvim-navic',
    'MunifTanjim/nui.nvim',
  },
  opts = {
    lsp = {
      auto_attach = true,
    },
    window = {
      border = 'single',
      size = '60%',
      position = '50%',
    },
  },
  config = function(_, opts)
    require('nvim-navbuddy').setup(opts)
  end,
}
