return {
  {
    dir = '~/.config/nvim/lua/custom-plugins', -- путь к папке
    name = 'shiftwidth', -- любое имя
    config = function()
      require('custom-plugins.shiftwidth').setup() -- запускаем наш плагин
    end,
    event = 'BufEnter', -- когда грузить
  },
}
