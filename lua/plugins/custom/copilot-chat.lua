-- TODO: disable highlighting code of discusion

return {
  'CopilotC-Nvim/CopilotChat.nvim',
  opts = {
    mappings = {
      reset = {
        normal = '', -- disables <C-L> in normal mode for chat reset
        insert = '', -- disables <C-L> in insert mode for chat reset
      },
    },
  },
  build = function()
    vim.notify 'Update remote plugins for CopilotChat...'
    vim.cmd 'UpdateRemotePlugins'
  end,
  cmd = { 'CopilotChat' },
}
