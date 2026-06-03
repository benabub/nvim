-- File Explorer / Tree
return {
  -- https://github.com/nvim-tree/nvim-tree.lua
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    -- https://github.com/nvim-tree/nvim-web-devicons
    'nvim-tree/nvim-web-devicons', -- Fancy icon support
  },
  opts = {
    sort = {
      sorter = function(nodes)
        table.sort(nodes, function(a, b)
          if a.type ~= b.type then
            return a.type == 'directory'
          end
          local a_under = a.name:sub(1, 1) == '_'
          local b_under = b.name:sub(1, 1) == '_'
          if a_under ~= b_under then
            return a_under
          end
          local a_num = tonumber(a.name:match '^%d+')
          local b_num = tonumber(b.name:match '^%d+')
          if a_num and b_num then
            if a_num ~= b_num then
              return a_num < b_num
            end
          end
          return a.name:lower() < b.name:lower()
        end)
      end,
    },
    actions = {
      open_file = {
        window_picker = {
          enable = false,
        },
      },
    },
    view = {
      width = 38,
    },
  },
  config = function(_, opts)
    -- Recommended settings to disable default netrw file explorer
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    require('nvim-tree').setup(opts)
  end,
}
