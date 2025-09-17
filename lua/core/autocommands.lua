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
vim.api.nvim_create_autocmd('VimEnter', { -- Автокоманда при ЗАПУСКЕ NeoVim
  once = true, -- Выполнить ТОЛЬКО ОДИН РАЗ при старте
  callback = function()
    -- Получаем информацию о текущем буфере
    local bufname = vim.fn.bufname() -- Имя буфера (пустое если нет файла)
    local line_count = vim.fn.line '$' -- Количество строк в буфере
    local first_line = vim.fn.getline(1) -- Содержимое первой строки
    -- Проверяем что буфер ПУСТОЙ: нет имени, одна строка и строка пустая
    if bufname == '' and line_count == 1 and first_line == '' then
      -- Закрываем пустой буфер
      vim.cmd 'BufferClose!'
    end
  end,
})

-- close nvim after last buffer was closed
vim.api.nvim_create_autocmd('BufDelete', { -- Автокоманда на событие УДАЛЕНИЯ БУФЕРА
  pattern = '*', -- Срабатывает для ЛЮБОГО типа буфера
  callback = function()
    -- Откладываем выполнение на 10мс чтобы список буферов успел обновиться
    vim.defer_fn(function()
      -- Получаем список ВСЕХ буферов, которые отображаются в :ls
      local buffers = vim.fn.getbufinfo { buflisted = 1 }
      -- Проверяем: если остался РОВНО ОДИН буфер
      if #buffers == 1 then
        local buf = buffers[1] -- Берем первый (и единственный) буфер из списка
        -- Проверяем что буфер ПУСТОЙ: нет имени и всего одна строка
        if buf.name == '' and buf.linecount == 1 then
          -- Читаем первую строку буфера чтобы убедиться что она ПУСТАЯ
          local first_line = vim.api.nvim_buf_get_lines(buf.bufnr, 0, 1, false)[1]
          if first_line == '' then
            -- Если все условия выполнены - ВЫХОДИМ из NeoVim
            vim.cmd 'q'
          end
        end
      end
    end, 10) -- Задержка 10 миллисекунд
  end,
})
