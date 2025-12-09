return {
  'ThePrimeagen/git-worktree.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('git-worktree').setup()
    require('telescope').load_extension 'git_worktree'
  end,
}

-- return {
--   'ThePrimeagen/git-worktree.nvim',
-- }
--
