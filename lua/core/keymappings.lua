-----------------------------------
-- General keymaps
-----------------------------------
vim.keymap.set('n', '<leader>wq', ':wq<CR>') -- save and quit
vim.keymap.set('n', '<leader>`', ':q!<CR>') -- quit without saving
vim.keymap.set('n', '<leader>ww', ':w<CR>') -- save
vim.keymap.set('n', 'gx', ':!open <c-r><c-a><CR>') -- open URL under cursor
vim.keymap.set('n', '<CR>', 'o<Esc>') -- new underline

-----------------------------------
-- Default commenting remapping
-----------------------------------

-- Unmap default commenting keymaps
vim.keymap.del({ 'n', 'x' }, 'gc')
vim.keymap.del('n', 'gcc')
vim.keymap.del('o', 'gc')

-- Your custom commenting keymaps
local operator_rhs = function()
  return require('vim._comment').operator()
end
vim.keymap.set({ 'n', 'x' }, 'ff', operator_rhs, { expr = true, desc = 'Toggle comment' })

local line_rhs = function()
  return require('vim._comment').operator() .. '_'
end
vim.keymap.set('n', 'fa', line_rhs, { expr = true, desc = 'Toggle comment line' })

local textobject_rhs = function()
  require('vim._comment').textobject()
end
vim.keymap.set({ 'o' }, 'ff', textobject_rhs, { desc = 'Comment textobject' })

-----------------------------------
-- Custom commenting
-----------------------------------

--
-- Toggle comment inner paragraph
--

vim.keymap.set('n', 'fd', function()
  vim.cmd 'normal Vip'
  vim.cmd 'normal ff'
end, { desc = 'Toggle comment inner paragraph' })

--
-- Toggle comment code until `# ---` above
--

-- In normal mode, <leader>a executes the function
vim.keymap.set('n', 'fs', function()
  -- Get the current line number
  local cur = vim.fn.line '.'
  -- Initialize start_line with the current line
  local start_line = cur
  local end_line = cur
  local original = cur

  -- Search up to the start_line
  while cur > 1 do
    -- Get the text of the previous line
    local prev_line = vim.fn.getline(cur - 1)
    -- If the previous line is empty
    if prev_line == '' then
      start_line = cur
      break
    else
      cur = cur - 1
    end
  end

  -- reset cur to original line for downward search
  cur = original

  -- Search down to the end_line
  while cur < vim.fn.line '$' do
    -- Get the text of the next line
    local next_line = vim.fn.getline(cur + 1)
    -- If the next line starts with "# --":
    if next_line:match '^# %-%-' then
      end_line = cur - 1
      break
    else
      cur = cur + 1
    end
  end

  -- Move the cursor to the found upper boundary
  vim.api.nvim_win_set_cursor(0, { start_line, 0 })
  -- Visually select the range from start_line to end_line
  vim.cmd('normal! V' .. (end_line - start_line) .. 'j')
  -- Toggle comment on the selected lines
  vim.cmd 'normal ff'
  -- Return the cursor to the original line
  vim.fn.cursor(start_line, 1)
  -- Description for help
end, { desc = 'Toggle comment until # -- above' })

-----------------------------------
-- Line surrounding
-----------------------------------
vim.keymap.set('n', '<leader>9', 'i(<Esc>A)<Esc>', { desc = 'Surround to the end' })
vim.keymap.set('n', '<leader>0', 'i(<Esc>$i)<Esc>', { desc = 'Surround to :' })

-----------------------------------
-- toggle nvim autopairs
-----------------------------------
vim.keymap.set('n', '<leader>z', "<cmd>lua require('nvim-autopairs').toggle()<cr>")

-----------------------------------
-- Select to the end of the line
-----------------------------------
vim.keymap.set('n', '<leader>vv', 'v$h', { desc = 'Select to the end of the line' })

-----------------------------------
-- Move cursor in Insert mode
-----------------------------------

vim.keymap.set('i', '<C-l>', '<Right>', { desc = 'Cursor step right in Insert mode' })
vim.keymap.set('i', '<C-л>', '<Right>', { desc = 'Cursor step right in Insert mode' })

vim.keymap.set('i', '<C-h>', '<Left>', { desc = 'Cursor step left in Insert mode' })
vim.keymap.set('i', '<C-ь>', '<Left>', { desc = 'Cursor step left in Insert mode' })

-----------------------------------
-- Code run
-----------------------------------
vim.keymap.set('n', '<leader>rr', ':!python %<CR>')

-----------------------------------
-- Mason & Lazy fast
-----------------------------------
vim.keymap.set('n', '<leader>l', ':Lazy<CR>') -- toggle git blame
vim.keymap.set('n', '<leader>m', ':Mason<CR>') -- toggle git blame

-----------------------------------
-- Bookmarks
-----------------------------------
vim.keymap.set({ 'n', 'v' }, 'mm', '<cmd>BookmarksMark<cr>', { desc = 'Mark current line into active BookmarkList.' })
vim.keymap.set({ 'n', 'v' }, 'mo', '<cmd>BookmarksGoto<cr>', { desc = 'Go to bookmark at current active BookmarkList' })
vim.keymap.set({ 'n', 'v' }, 'm1', '<cmd>BookmarksGotoPrev<cr>', { desc = 'Go to next bookmark in line number order' })
vim.keymap.set({ 'n', 'v' }, 'm2', '<cmd>BookmarksGotoNext<cr>', { desc = 'Go to previous bookmark in line number order' })

-----------------------------------
-- Copilot
-----------------------------------
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.keymap.set('i', '<M-CR>', function()
  vim.fn.feedkeys(vim.fn['copilot#Accept'](), 'n')
end, { expr = true, silent = true })
vim.keymap.set('i', '<M-]>', '<Plug>(copilot-next)')
vim.keymap.set('i', '<M-[>', '<Plug>(copilot-previous)')
vim.keymap.set('n', '<leader>cc', ':CopilotChat<CR>', { desc = 'CopilotChat' })
vim.keymap.set('n', '<leader>cd', ':Copilot disable<CR>', { desc = 'Copilot disable' })
vim.keymap.set('n', '<leader>ce', ':Copilot enable<CR>', { desc = 'Copilot enable' })

-----------------------------------
-- Clear highlights on search when pressing <Esc> in normal mode
-----------------------------------
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-----------------------------------
-- Diagnostic keymaps
-----------------------------------
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<C-PageDown>', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<C-PageUp>', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })

-----------------------------------
-- Terminal
-----------------------------------
-- vim.keymap.set('n', '<F5>', ':ToggleTerm size=40 dir=~/Desktop direction=float name=desktop<CR>') -- toggle

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-----------------------------------
-- Keybinds to make split navigation easier.
-----------------------------------
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-----------------------------------
-- Nvim-tree
-----------------------------------
vim.keymap.set('n', '<leader>ee', ':NvimTreeToggle<CR>') -- toggle file explorer
vim.keymap.set('n', '<leader>er', ':NvimTreeFocus<CR>') -- toggle focus to file explorer
vim.keymap.set('n', '<leader>ef', ':NvimTreeFindFile<CR>') -- find file in file explorer

-----------------------------------
-- Git-blame
-----------------------------------
vim.keymap.set('n', '<leader>gb', ':GitBlameToggle<CR>') -- toggle git blame

-----------------------------------
-- Debugging
-----------------------------------
vim.keymap.set('n', '<leader>bb', "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
vim.keymap.set('n', '<leader>bc', "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
vim.keymap.set('n', '<leader>bl', "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
vim.keymap.set('n', '<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>")
vim.keymap.set('n', '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>')
vim.keymap.set('n', '<leader>dc', "<cmd>lua require'dap'.continue()<cr>")
vim.keymap.set('n', '<leader>dj', "<cmd>lua require'dap'.step_over()<cr>")
vim.keymap.set('n', '<leader>dk', "<cmd>lua require'dap'.step_into()<cr>")
vim.keymap.set('n', '<leader>do', "<cmd>lua require'dap'.step_out()<cr>")
vim.keymap.set('n', '<A-Esc>', function()
  require('dap').disconnect()
  require('dapui').close()
end)
vim.keymap.set('n', '<leader>dt', function()
  require('dap').terminate()
  require('dapui').close()
end)
vim.keymap.set('n', '<leader>dr', "<cmd>lua require'dap'.repl.toggle()<cr>")
vim.keymap.set('n', '<leader>dl', "<cmd>lua require'dap'.run_last()<cr>")
vim.keymap.set('n', '<leader>di', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set('n', '<leader>d?', function()
  local widgets = require 'dap.ui.widgets'
  widgets.centered_float(widgets.scopes)
end)
vim.keymap.set('n', '<leader>df', '<cmd>Telescope dap frames<cr>')
vim.keymap.set('n', '<leader>dh', '<cmd>Telescope dap commands<cr>')
vim.keymap.set('n', '<leader>de', function()
  require('telescope.builtin').diagnostics { default_text = ':E:' }
end)

-----------------------------------
-- Harpoon
-----------------------------------
local harpoon = require 'harpoon'
harpoon:setup()

vim.keymap.set('n', '<leader>ha', function()
  harpoon:list():add()
end)
vim.keymap.set('n', '<leader>hh', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set('n', '<leader>1', function()
  harpoon:list():select(1)
end)
vim.keymap.set('n', '<leader>2', function()
  harpoon:list():select(2)
end)
vim.keymap.set('n', '<leader>3', function()
  harpoon:list():select(3)
end)
vim.keymap.set('n', '<leader>4', function()
  harpoon:list():select(4)
end)
vim.keymap.set('n', '<leader>5', function()
  harpoon:list():select(5)
end)
vim.keymap.set('n', '<leader>6', function()
  harpoon:list():select(6)
end)
vim.keymap.set('n', '<leader>7', function()
  harpoon:list():select(7)
end)
vim.keymap.set('n', '<leader>8', function()
  harpoon:list():select(8)
end)
vim.keymap.set('n', '<leader>9', function()
  harpoon:list():select(9)
end)
-- -- replace
-- vim.keymap.set('n', '<leader>H1', function()
--   harpoon:list():replace_at(1)
-- end)
-- vim.keymap.set('n', '<leader>H2', function()
--   harpoon:list():replace_at(2)
-- end)
-- vim.keymap.set('n', '<leader>H3', function()
--   harpoon:list():replace_at(3)
-- end)
-- vim.keymap.set('n', '<leader>H4', function()
--   harpoon:list():replace_at(4)
-- end)
-- vim.keymap.set('n', '<leader>H5', function()
--   harpoon:list():replace_at(5)
-- end)
-- vim.keymap.set('n', '<leader>H6', function()
--   harpoon:list():replace_at(6)
-- end)
-- vim.keymap.set('n', '<leader>H7', function()
--   harpoon:list():replace_at(7)
-- end)
-- vim.keymap.set('n', '<leader>H8', function()
--   harpoon:list():replace_at(8)
-- end)
-- vim.keymap.set('n', '<leader>H9', function()
--   harpoon:list():replace_at(9)
-- end)
-- -- toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set('n', '<leader>h.', function()
--   harpoon:list():prev()
-- end)
-- vim.keymap.set('n', '<leader>h/', function()
--   harpoon:list():next()
-- end)

-----------------------------------
-- Vim-maximizer
-----------------------------------
vim.keymap.set('n', '<leader>wm', ':MaximizerToggle<CR>') -- toggle maximize tab

-----------------------------------
-- zen-mode.nvim
-----------------------------------
vim.keymap.set('n', '<leader>wz', ':ZenMode<CR>:wincmd |<CR>')

-----------------------------------
-- Neotest
-----------------------------------
vim.keymap.set('n', '<leader>tn', function()
  require('neotest').run.run()
end, { desc = 'Run nearest test in the file' })

vim.keymap.set('n', '<leader>tt', function()
  require('neotest').run.run(vim.fn.expand '%')
end, { desc = 'Run all the tests in the file' })

vim.keymap.set('n', '<leader>to', function()
  require('neotest').output.open { enter = true }
end, { desc = 'output.open' })

vim.keymap.set('n', '<leader>ts', function()
  require('neotest').summary.toggle()
end, { desc = 'summary_toggle' })

vim.keymap.set('n', '<leader>tw', function()
  require('neotest').watch.watch()
end, { desc = 'watch current test for changes' })

-----------------------------------
-- Templates for this file
-----------------------------------

-- vim.keymap.set('n', '<leader>h', "<cmd>lua <cr>")

-- vim.keymap.set('n', '<leader>to', ':lua require("neotest").output.open({enter = true})<CR>', { noremap = true, silent = true })

-- vim.keymap.set('n', '<leader>to', function()
--   require('neotest').output.open { enter = true }
-- end, { desc = 'output.open' })
