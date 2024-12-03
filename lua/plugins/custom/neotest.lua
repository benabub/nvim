return {
  'nvim-neotest/neotest',
  event = 'VeryLazy',
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        },
      },
    }
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'antoinemadec/FixCursorHold.nvim',
    'neotest-python',
  },
}
