return {
  'CopilotC-Nvim/CopilotChat.nvim',
  opts = {},
  build = function()
    vim.notify 'Update remote plugins for CopilotChat...'
    vim.cmd 'UpdateRemotePlugins'
  end,
  cmd = { 'CopilotChat' },
}
