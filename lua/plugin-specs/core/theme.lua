-- choose only one block (comment others):

-- return {
--   { -- You can easily change to a different colorscheme.
--     -- Change the name of the colorscheme plugin below, and then
--     -- change the command in the config to whatever the name of that colorscheme is.
--     --
--     -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
--     'folke/tokyonight.nvim',
--     priority = 1000, -- Make sure to load this before all the other start plugins.
--     init = function()
--       -- Load the colorscheme here.
--       -- Like many other themes, this one has different styles, and you could load
--       -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
--       vim.cmd.colorscheme 'tokyonight-night'
--       --
--       -- You can configure highlights by doing something like:
--       vim.cmd.hi 'Comment gui=none'
--     end,
--   },
-- }

-- return {
--   { -- Catppuccin theme
--     'catppuccin/nvim',
--     name = 'catppuccin',
--     priority = 1000, -- Make sure to load this before all the other start plugins.
--     init = function()
--       -- Load the colorscheme here.
--       -- Catppuccin has different flavors: latte, frappe, macchiato, mocha
--       --
--       vim.cmd.colorscheme 'catppuccin-mocha' -- Change to your preferred flavor
--       -- vim.cmd.colorscheme 'catppuccin-macchiato' -- Change to your preferred flavor
--       -- vim.cmd.colorscheme 'catppuccin-frappe' -- Change to your preferred flavor
--       --
--       -- You can configure highlights by doing something like:
--       vim.cmd.hi 'Comment gui=none'
--     end,
--     config = function()
--       require('catppuccin').setup {
--         -- Add any custom configurations for catppuccin here
--         -- For example:
--         transparent_background = false,
--         term_colors = true,
--         styles = {
--           comments = { 'italic' },
--           conditionals = { 'italic' },
--         },
--         integrations = {
--           telescope = true,
--           neotree = true,
--           cmp = true,
--           lsp_trouble = true,
--           which_key = true,
--         },
--       }
--     end,
--   },
-- }

return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'EdenEast/nightfox.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      --
      -- vim.cmd.colorscheme 'duskfox'
      vim.cmd.colorscheme 'nordfox'
      -- vim.cmd.colorscheme 'terafox'
      -- vim.cmd.colorscheme 'carbonfox'
      --
      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
