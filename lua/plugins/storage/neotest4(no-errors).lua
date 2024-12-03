return {
  'nvim-neotest/neotest',
  event = 'VeryLazy',
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          -- jestCommand = 'npm test --',
          -- jestConfigFile = 'custom.jest.config.ts',
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
    -- 'haydenmeade/neotest-jest',
    'neotest-python',
  },
}
