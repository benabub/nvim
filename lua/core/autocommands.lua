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

--------------------------------------------------------------------
-- Tabs (Buffers)
--------------------------------------------------------------------

-- nvim start empty buffer handler
vim.api.nvim_create_autocmd('VimEnter', { -- init: nvim start
  once = true, -- execute once only
  callback = function()
    -- get data about current buffer
    local bufname = vim.fn.bufname()
    local line_count = vim.fn.line '$' -- count of lines
    local first_line = vim.fn.getline(1)
    -- Check buffer is empty: empty name, 1 empty line
    if bufname == '' and line_count == 1 and first_line == '' then
      vim.cmd 'BufferClose!'
    end
  end,
})

-- close nvim after last buffer was closed
vim.api.nvim_create_autocmd('BufDelete', { -- init: buffer deletion
  pattern = '*', -- for every buffer type
  callback = function()
    -- func for delay
    vim.defer_fn(function()
      -- get list of all buffers
      local buffers = vim.fn.getbufinfo { buflisted = 1 }
      -- check count of buffers
      if #buffers == 1 then
        local buf = buffers[1] -- assign a buffer to val
        -- Check buffer is empty: empty name, 1 empty line
        if buf.name == '' and buf.linecount == 1 then
          local first_line = vim.api.nvim_buf_get_lines(buf.bufnr, 0, 1, false)[1]
          if first_line == '' then
            vim.cmd 'q'
          end
        end
      end
    end, 10) -- delay
  end,
})
