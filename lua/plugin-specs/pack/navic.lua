return {
  'SmiteshP/nvim-navic',
  dependencies = { 'neovim/nvim-lspconfig' },
  opts = {
    lsp = {
      auto_attach = true,
    },
    separator = ' > ',
    -- highlight = true,
  },
  config = function(_, opts)
    require('nvim-navic').setup(opts)
  end,
}
