local M = {}

local filetype_settings = {
  python = {
    shiftwidth = 4,
    tabstop = 4,
    expandtab = true,
    softtabstop = 4,
  },
  rust = {
    shiftwidth = 4,
    tabstop = 4,
    expandtab = true,
    softtabstop = 4,
  },
  javascript = {
    shiftwidth = 2,
    tabstop = 2,
    expandtab = true,
    softtabstop = 2,
  },
  typescript = {
    shiftwidth = 2,
    tabstop = 2,
    expandtab = true,
    softtabstop = 2,
  },
  html = {
    shiftwidth = 2,
    tabstop = 2,
    expandtab = true,
    softtabstop = 2,
  },
  css = {
    shiftwidth = 2,
    tabstop = 2,
    expandtab = true,
    softtabstop = 2,
  },
  lua = {
    shiftwidth = 2,
    tabstop = 2,
    expandtab = true,
    softtabstop = 2,
  },
  c = {
    shiftwidth = 4,
    tabstop = 4,
    expandtab = false,
    softtabstop = 0,
  },
  cpp = {
    shiftwidth = 4,
    tabstop = 4,
    expandtab = false,
    softtabstop = 0,
  },
  go = {
    shiftwidth = 4,
    tabstop = 4,
    expandtab = false,
    softtabstop = 0,
  },
  sh = {
    shiftwidth = 4,
    tabstop = 4,
    expandtab = false,
    softtabstop = 0,
  },
  bash = {
    shiftwidth = 4,
    tabstop = 4,
    expandtab = false,
    softtabstop = 0,
  },
  zsh = {
    shiftwidth = 4,
    tabstop = 4,
    expandtab = false,
    softtabstop = 0,
  },
}

function M.setup()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    callback = function()
      local ft = vim.bo.filetype
      local settings = filetype_settings[ft]

      if settings then
        for option, value in pairs(settings) do
          vim.bo[option] = value
        end
      end
    end,
  })
end

return M
