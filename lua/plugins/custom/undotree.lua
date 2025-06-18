return {
  'mbbill/undotree',

  config = function()
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_SplitWidth = 30
    vim.g.undotree_DiffAutoOpen = 0
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
  end,
}
