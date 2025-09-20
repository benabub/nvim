return {
  {
    dir = '~/.config/nvim/lua/custom-plugins', -- path to dir
    name = 'shiftwidth', -- name for lazy manager only
    config = function()
      require('custom-plugins.shiftwidth').setup() -- start plugin
    end,
    event = 'BufEnter', -- inition
  },
}
