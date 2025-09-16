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

-- remap <C-L> for copilot-chat to move focus left. Again.
-- (after copilot-chat pluggin has successfully broke it)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'copilot-chat',
  callback = function()
    vim.keymap.set('n', '<C-L>', '<C-W><C-L>', { noremap = true, silent = true, buffer = true })
  end,
})

-- -- close start empty buffer
-- vim.api.nvim_create_autocmd('VimEnter', {
--   callback = function()
--     vim.defer_fn(function()
--       if vim.fn.bufname '%' == '' and vim.fn.bufnr '$' == 1 then
--         vim.cmd 'bd'
--       end
--     end, 10)
--   end,
-- })
