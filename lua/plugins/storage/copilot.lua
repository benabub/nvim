return {
  'github/copilot.vim',
  lazy = false,
  config = function()
    -- Optional settings:
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept("<CR>")', { silent = true, expr = true })
  end,
}
