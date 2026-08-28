return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    -- any opts
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    {
      'rcarriga/nvim-notify',
      config = function()
        require('notify').setup {
          timeout = 0,
          merge_duplicates = true,
        }
      end,
    },
  },
}
