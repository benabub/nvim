-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Configure diff mode to maintain vertical sync but disable horizontal sync
vim.api.nvim_create_autocmd('OptionSet', {
  pattern = 'diff',
  callback = function()
    vim.opt.scrollbind = true -- Enable window synchronization
    vim.opt.cursorbind = true -- Synchronize cursor movements
    vim.opt.scrollopt = 'ver,jump' -- Sync only vertical scrolling and jump movements
  end,
})

-- Apply consistent window settings for all diff mode windows
vim.api.nvim_create_autocmd({ 'OptionSet', 'WinEnter' }, {
  pattern = '*',
  callback = function()
    if vim.wo.diff then -- Check if window is in diff mode
      vim.wo.number = false -- Disable absolute line numbers
      vim.wo.relativenumber = false -- Disable relative line numbers
      vim.wo.foldcolumn = '0' -- Hide fold column
      -- vim.wo.signcolumn = 'no'  -- Hide sign column (optional)
    end
  end,
})
