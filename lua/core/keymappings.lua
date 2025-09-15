-----------------------------------
-- locals
-----------------------------------
local telescope = require 'telescope.builtin'
local dap = require 'dap'
local dapui = require 'dapui'

-----------------------------------
-- General keymaps
-----------------------------------
vim.keymap.set('n', 'gx', ':!open <c-r><c-a><CR>', { desc = 'Open URL under cursor' })

-----------------------------------
-- File: Write | Close | Format
-----------------------------------
vim.keymap.set('n', '<leader>wq', ':wq<CR>', { desc = 'Save and quit' })
vim.keymap.set('n', '<leader>`', ':q!<CR>', { desc = 'Quit without saving' })
vim.keymap.set('n', '<leader><leader>', ':w<CR>', { desc = 'Save File' })
vim.keymap.set('n', '<leader>ww', ':w<CR>', { desc = 'Save File' })

-----------------------------------
-- Autotyping
-----------------------------------
vim.keymap.set('n', '<CR>', 'o<Esc>', { desc = 'New underline' })

-----------------------------------
-- Manipulations
-----------------------------------
-- Line surrounding
vim.keymap.set('n', '<leader>me', 'i(<Esc>A)<Esc>', { desc = 'Surround with () to the end' })
vim.keymap.set('n', '<leader>mc', 'i(<Esc>$i)<Esc>', { desc = 'Surround with () to < : >' })

-----------------------------------
-- LSP
-----------------------------------
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach-keymaps', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- def
    map('<leader>ld', telescope.lsp_definitions, 'Goto Definition')
    -- declaration: where var declarated, but not defined
    map('<leader>lD', vim.lsp.buf.declaration, 'Goto Declaration')
    -- interface realization
    map('<leader>li', telescope.lsp_implementations, 'Goto Implementation')

    -- type
    map('<leader>lt', telescope.lsp_type_definitions, 'Goto Type Definition')

    -- search in project
    map('<leader>lr', telescope.lsp_references, 'Show References in file')
    -- search in current file
    map('<leader>sv', telescope.lsp_document_symbols, 'Search Vars defs in file')

    -- rename variable
    map('<leader>lR', vim.lsp.buf.rename, 'Rename var (refactoring)')
    -- possible refactoring
    map('<leader>lc', vim.lsp.buf.code_action, 'Code Action')

    -- for LSP inlay hints only (doesn't work, if there is no such configuration)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

-----------------------------------
-- Telescope
-----------------------------------
vim.keymap.set('n', '<leader>sh', telescope.help_tags, { desc = 'Search Help' })
vim.keymap.set('n', '<leader>sk', telescope.keymaps, { desc = 'Search Keymaps' })
vim.keymap.set('n', '<leader>sf', telescope.find_files, { desc = 'Search Files' })
vim.keymap.set('n', '<leader>ss', telescope.builtin, { desc = 'Search Telescope Function' })
vim.keymap.set('n', '<leader>sw', telescope.grep_string, { desc = 'Search current Word' })
vim.keymap.set('n', '<leader>sr', telescope.resume, { desc = 'Search Resume' })
vim.keymap.set('n', '<leader>s.', telescope.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>sb', telescope.buffers, { desc = 'Find existing buffers' })
vim.keymap.set('n', '<leader>sg', telescope.live_grep, { desc = 'Search by Grep in project' })

vim.keymap.set('n', '<leader>sd', function()
  telescope.diagnostics { path_display = { 'hidden' } }
end, { desc = 'Search Diagnostics' })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  telescope.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set('n', '<leader>s/', function()
  telescope.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

-- Shortcut for searching your Neovim configuration files
vim.keymap.set('n', '<leader>sn', function()
  telescope.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

-----------------------------------
-- Diagnostics GoTo Commands
-----------------------------------
vim.keymap.set('n', '<C-PageDown>', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<C-PageUp>', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })

-----------------------------------
-- Trouble
-----------------------------------
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Trouble: Diagnostics' })
vim.keymap.set('n', '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Trouble: Variables' })
vim.keymap.set('n', '<leader>xl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { desc = 'Trouble: Full Symbol Context  ' })
-- vim.keymap.set('n', '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', { desc = 'Trouble: Quickfix List' })

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
    if next_line:match '^# %-%-' or next_line:match '^# ==' then
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
-- Visual Selection
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
vim.keymap.set('n', '<leader>rr', ':!python %<CR>', { desc = 'Run Current Python file' })
vim.keymap.set('n', '<Leader>rc', '<cmd>Run<cr>', { noremap = true, silent = true, desc = 'Run with CodeRunner + Console stays' })

-----------------------------------
-- Mason & Lazy fast
-----------------------------------
vim.keymap.set('n', '<leader>L', ':Lazy<CR>') -- toggle git blame
vim.keymap.set('n', '<leader>M', ':Mason<CR>') -- toggle git blame

-----------------------------------
-- Bookmarks
-----------------------------------
vim.keymap.set({ 'n', 'v' }, 'mm', '<cmd>BookmarksMark<cr>', { desc = 'Mark current line into active BookmarkList.' })
vim.keymap.set({ 'n', 'v' }, 'mo', '<cmd>BookmarksGoto<cr>', { desc = 'Go to bookmark at current active BookmarkList' })
vim.keymap.set({ 'n', 'v' }, 'm1', '<cmd>BookmarksGotoPrev<cr>', { desc = 'Go to next bookmark in line number order' })
vim.keymap.set({ 'n', 'v' }, 'm2', '<cmd>BookmarksGotoNext<cr>', { desc = 'Go to previous bookmark in line number order' })

vim.keymap.set({ 'n', 'v' }, 'md', function()
  require('bookmarks.commands').delete_mark_of_current_file()
end, { desc = 'Clear All Bookmark in File' })

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

-----------------------------------
-- Breakpoints
-----------------------------------
-- vim.keymap.set('n', '<leader>bb', "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
vim.keymap.set('n', '<leader>bb', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>br', dap.clear_breakpoints, { desc = 'Debug: Clear All Breakpoints' })

vim.keymap.set('n', '<leader>bB', function()
  dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Debug: Set Named Breakpoint' })

-----------------------------------
-- Debugging
-----------------------------------
vim.keymap.set('n', '<leader>dd', dap.continue, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: Step Into Function' })
vim.keymap.set('n', '<leader>do', dap.step_out, { desc = 'Debug: Step Out Function' })
vim.keymap.set('n', '<leader>dj', dap.step_over, { desc = 'Debug: Jump Over Function' })

vim.keymap.set('n', '<leader>dt', function()
  dap.terminate()
  dapui.close()
end, { desc = 'Debug: Terminate' })

vim.keymap.set('n', '<leader>dc', dap.repl.toggle, { desc = 'Debug: toggle console' })

vim.keymap.set('n', '<leader>dv', function()
  require('dap.ui.widgets').hover()
end, { desc = 'Debug: Show Value of Variable under cursor' })

vim.keymap.set('n', '<leader>d?', function()
  local widgets = require 'dap.ui.widgets'
  widgets.centered_float(widgets.scopes)
end, { desc = 'Debug: Show All Variables of Scope' })

-----------------------------------
-- Harpoon
-----------------------------------
local harpoon = require 'harpoon'
harpoon:setup()

vim.keymap.set('n', '<leader>ha', function()
  harpoon:list():add()
end, { desc = 'Harpoon add' })
vim.keymap.set('n', '<leader>hh', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = 'Harpoon list' })

vim.keymap.set('n', '<leader>1', function()
  harpoon:list():select(1)
end, { desc = 'Harpoon: buffer 1' })
vim.keymap.set('n', '<leader>2', function()
  harpoon:list():select(2)
end, { desc = 'Harpoon: buffer 2' })
vim.keymap.set('n', '<leader>3', function()
  harpoon:list():select(3)
end, { desc = 'Harpoon: buffer 3' })
vim.keymap.set('n', '<leader>4', function()
  harpoon:list():select(4)
end, { desc = 'Harpoon: buffer 4' })
vim.keymap.set('n', '<leader>5', function()
  harpoon:list():select(5)
end, { desc = 'Harpoon: buffer 5' })
vim.keymap.set('n', '<leader>6', function()
  harpoon:list():select(6)
end, { desc = 'Harpoon: buffer 6' })
vim.keymap.set('n', '<leader>7', function()
  harpoon:list():select(7)
end, { desc = 'Harpoon: buffer 7' })
vim.keymap.set('n', '<leader>8', function()
  harpoon:list():select(8)
end, { desc = 'Harpoon: buffer 8' })
vim.keymap.set('n', '<leader>9', function()
  harpoon:list():select(9)
end, { desc = 'Harpoon: buffer 9' })

-----------------------------------
-- zen-mode.nvim
-----------------------------------
vim.keymap.set('n', '<leader>z', ':ZenMode<CR>:wincmd |<CR>', { desc = 'Zen Mode' })

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
-- Other plugins
-----------------------------------
vim.keymap.set('n', '<leader>ou', vim.cmd.UndotreeToggle, { desc = 'UndoTree' })
vim.keymap.set('n', '<leader>oa', "<cmd>lua require('nvim-autopairs').toggle()<cr>", { desc = 'Toggle Autopairs' })
vim.keymap.set('n', '<leader>og', ':GitBlameToggle<CR>', { desc = 'Toggle Git Blame' })

-----------------------------------
-- Templates for this file
-----------------------------------

-- vim.keymap.set('n', '<leader>h', "<cmd>lua <cr>")

-- vim.keymap.set('n', '<leader>to', ':lua require("neotest").output.open({enter = true})<CR>', { noremap = true, silent = true })

-- vim.keymap.set('n', '<leader>to', function()
--   require('neotest').output.open { enter = true }
-- end, { desc = 'output.open' })
