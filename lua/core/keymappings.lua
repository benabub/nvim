-----------------------------------
-- Modifiers map (case ignore)
-----------------------------------

-- <cmd> = nvim terminal command start
--`<CR>` = Enter
--`<C->` = Ctrl
--`<A->` = Alt
--`<S->` = Shift
--`<Leader>` = user prefix
--`<LocalLeader>` = local prefix
--`<Esc>` = Escape
--`<Tab>` = Tab
--`<BS>` = Backspace
--`<Space>` = space

-- All combinations are surrouded by <> together

-------------------------------------------------
-- Default mapping: finding, deleting, remapping
-------------------------------------------------

-- simple way to check if mapping exists: `:verbose map key-word`,
-- key-word examples: <c-w> (case ignore)

-- coolest way to find mapping is to jump into nvim guts with live_grep:
-- `:Telescope live_grep search_dirs={"$VIMRUNTIME"}` (there is such bind already in this config)
-- Search by the desc phraze, which you see in which-key.
-- NB: the guts are intouchable! - don't change anything!

-- So, You find original defaut mapping: what's next?
-- To clear mapping (here, in section below) you need to take mode + keys args
-- To remap you need to take a command arg

-----------------------------------
-- locals
-----------------------------------
local telescope = require 'telescope.builtin'
local dap = require 'dap'
local dapui = require 'dapui'
local harpoon = require 'harpoon'
harpoon:setup()
local gitsigns = require 'gitsigns'

-----------------------------------
-- clearing annoying defaults
-----------------------------------

vim.keymap.del('n', '<C-w><C-D>')
vim.keymap.del('n', '<C-W>d')

-----------------------------------
-- URL
-----------------------------------
vim.keymap.set('n', 'gx', '<plug>(openbrowser-smart-search)', { noremap = true, silent = true, desc = 'Open URL under cursor' })

-----------------------------------------------------------
-- Buffers (Tabs): Write | Close | Format (+ Barbar plugin)
-----------------------------------------------------------
-- Close
vim.keymap.set('n', '<leader>wq', ':w<CR>:bd<CR>', { noremap = true, silent = true, desc = 'Save and Close Buffer' })
vim.keymap.set('n', '<leader>`', ':silent! bd!<CR>', { noremap = true, silent = true, desc = 'Close without Saving' })

-- Save
vim.keymap.set('n', '<leader><leader>', ':w<CR>', { noremap = true, silent = true, desc = 'Save Buffer' })
vim.keymap.set('n', '<leader>ww', ':w<CR>', { noremap = true, silent = true, desc = 'Save Buffer' })

-- Tabs
vim.keymap.set('n', '<S-h>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true, desc = 'Previous Buffer' })
vim.keymap.set('n', '<S-l>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true, desc = 'Next Buffer' })
-- Generate map for buffers 1-9 with loop
for i = 1, 9 do
  vim.keymap.set('n', '<A-' .. i .. '>', function()
    vim.cmd('BufferGoto ' .. i)
  end, { noremap = true, silent = true, desc = 'Tabs: buffer ' .. i })
end

-----------------------------------
-- Navigation
-----------------------------------

vim.keymap.set('n', '<leader>nn', '<Cmd>Navbuddy<CR>', { noremap = true, silent = true, desc = 'NavBuddy' })

-----------------------------------
-- Manipulations
-----------------------------------
-- Line surrounding
vim.keymap.set('n', '<leader>me', 'i(<Esc>A)<Esc>', { noremap = true, silent = true, desc = 'Surround with () to the end' })
vim.keymap.set('n', '<leader>mc', 'i(<Esc>$i)<Esc>', { noremap = true, silent = true, desc = 'Surround with () to < : >' })

vim.keymap.set('n', '<leader>mp', 'Iprint(<Esc>$A)<Esc>', { noremap = true, silent = true, desc = 'Move Line Into < print(*) >' })
vim.keymap.set('n', '<leader>mm', '@1', { noremap = true, silent = true, desc = 'Macros 1 Exec' })

-- Case under cursor Up | Down
vim.keymap.set('n', '<leader>mj', 'vgu', { noremap = true, silent = true, desc = 'Letter Case Down' })
vim.keymap.set('n', '<leader>mk', 'vgU', { noremap = true, silent = true, desc = 'Letter Case Up' })
vim.keymap.set('n', '<leader>mJ', 'viwgu', { noremap = true, silent = true, desc = 'Word Case Down' })
vim.keymap.set('n', '<leader>mK', 'viwgU', { noremap = true, silent = true, desc = 'Word Case Up' })

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

    map('<leader>ll', function()
      vim.cmd 'LspRestart'
    end, 'Restart LSP')

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
vim.keymap.set('n', '<leader>sh', telescope.help_tags, { noremap = true, silent = true, desc = 'Search Help' })
vim.keymap.set('n', '<leader>sk', telescope.keymaps, { noremap = true, silent = true, desc = 'Search Keymaps' })
vim.keymap.set('n', '<leader>sf', telescope.find_files, { noremap = true, silent = true, desc = 'Search Files' })
vim.keymap.set('n', '<leader>ss', telescope.builtin, { noremap = true, silent = true, desc = 'Search Telescope Function' })
vim.keymap.set('n', '<leader>sw', telescope.grep_string, { noremap = true, silent = true, desc = 'Search current Word' })
vim.keymap.set('n', '<leader>sr', telescope.resume, { noremap = true, silent = true, desc = 'Search Resume' })
vim.keymap.set('n', '<leader>s.', telescope.oldfiles, { noremap = true, silent = true, desc = 'Search Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>sb', telescope.buffers, { noremap = true, silent = true, desc = 'Find existing buffers' })
vim.keymap.set('n', '<leader>sg', telescope.live_grep, { noremap = true, silent = true, desc = 'Live Grep in project' })

vim.keymap.set(
  'n',
  '<leader>sx',
  "<cmd>Telescope live_grep search_dirs={'$VIMRUNTIME'}<cr>",
  { noremap = true, silent = true, desc = 'Live Grep in Nvim Defaults' }
)

vim.keymap.set('n', '<leader>sd', function()
  telescope.diagnostics { path_display = { 'hidden' } }
end, { noremap = true, silent = true, desc = 'Search Diagnostics' })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  telescope.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { noremap = true, silent = true, desc = 'Fuzzily search in current buffer' })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set('n', '<leader>s/', function()
  telescope.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { noremap = true, silent = true, desc = 'Search in Open Files' })

-- Shortcut for searching your Neovim configuration files
vim.keymap.set('n', '<leader>sn', function()
  telescope.find_files { cwd = vim.fn.stdpath 'config' }
end, { noremap = true, silent = true, desc = 'Search Neovim files' })

-----------------------------------
-- Diagnostics | Trouble
-----------------------------------
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle focus=true<cr>', { noremap = true, silent = true, desc = 'Trouble: Diagnostics' })
vim.keymap.set('n', '<leader>xv', '<cmd>Trouble symbols toggle focus=false<cr>', { noremap = true, silent = true, desc = 'Trouble: Variables' })
vim.keymap.set(
  'n',
  '<leader>xc',
  '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
  { noremap = true, silent = true, desc = 'Trouble: Full Symbol Context  ' }
)
-- vim.keymap.set('n', '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', { noremap = true, silent = true, desc = 'Trouble: Quickfix List' })

vim.keymap.set('n', '<leader>xc', function()
  vim.diagnostic.open_float()
end, { desc = 'Show diagnostics under the cursor' })

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
vim.keymap.set({ 'n', 'x' }, 'ff', operator_rhs, { noremap = true, silent = true, expr = true, desc = 'Toggle comment' })

local line_rhs = function()
  return require('vim._comment').operator() .. '_'
end
vim.keymap.set('n', 'fa', line_rhs, { noremap = true, silent = true, expr = true, desc = 'Toggle comment line' })

local textobject_rhs = function()
  require('vim._comment').textobject()
end
vim.keymap.set({ 'o' }, 'ff', textobject_rhs, { noremap = true, silent = true, desc = 'Comment textobject' })

-----------------------------------
-- Custom commenting
-----------------------------------

--
-- Toggle comment inner paragraph
--

vim.keymap.set('n', 'fd', function()
  vim.cmd 'normal Vip'
  vim.cmd 'normal ff'
end, { noremap = true, silent = true, desc = 'Toggle comment inner paragraph' })

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
end, { noremap = true, silent = true, desc = 'Toggle comment until # -- above' })

-----------------------------------
-- Visual Selection
-----------------------------------
vim.keymap.set('n', '<leader>vv', 'v$h', { noremap = true, silent = true, desc = 'Select to the end of the line' })

-----------------------------------
-- Move cursor in Insert mode
-----------------------------------

vim.keymap.set('i', '<C-l>', '<Right>', { noremap = true, silent = true, desc = 'Cursor step right in Insert mode' })
vim.keymap.set('i', '<C-л>', '<Right>', { noremap = true, silent = true, desc = 'Cursor step right in Insert mode' })

vim.keymap.set('i', '<C-h>', '<Left>', { noremap = true, silent = true, desc = 'Cursor step left in Insert mode' })
vim.keymap.set('i', '<C-ь>', '<Left>', { noremap = true, silent = true, desc = 'Cursor step left in Insert mode' })

-----------------------------------
-- gitsigns
-----------------------------------

-- Jump to change
vim.keymap.set('n', ']c', function()
  if vim.wo.diff then
    vim.cmd.normal { ']c', bang = true }
  else
    gitsigns.nav_hunk 'next'
  end
end, { noremap = true, silent = true, desc = 'Jump to Next Git Change' })

vim.keymap.set('n', '[c', function()
  if vim.wo.diff then
    vim.cmd.normal { '[c', bang = true }
  else
    gitsigns.nav_hunk 'prev'
  end
end, { noremap = true, silent = true, desc = 'Jump to Previous Git Change' })

-- Add / Remove from stage
vim.keymap.set('v', '<leader>ga', function()
  gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
end, { noremap = true, silent = true, desc = 'Toggle Stage Git Hunk' })

-- vim.keymap.set('v', '<leader>gr', function()
--   gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
-- end, { noremap = true, silent = true, desc = 'Reset Git Hunk' })

vim.keymap.set('n', '<leader>ga', gitsigns.stage_hunk, { noremap = true, silent = true, desc = 'Toggle Stage Git Hunk' })
-- vim.keymap.set('n', '<leader>gr', gitsigns.reset_hunk, { noremap = true, silent = true, desc = 'Reset Git Hunk' })

vim.keymap.set('n', '<leader>gA', gitsigns.stage_buffer, { noremap = true, silent = true, desc = 'Git Stage Buffer' })
vim.keymap.set('n', '<leader>gR', gitsigns.reset_buffer, { noremap = true, silent = true, desc = 'Git Reset Buffer (DontWork)' })

-- Blame line
vim.keymap.set('n', '<leader>gb', gitsigns.blame_line, { noremap = true, silent = true, desc = 'Git Blame Line' })
vim.keymap.set('n', '<leader>gB', ':GitBlameToggle<CR>', { noremap = true, silent = true, desc = 'Toggle Git Show Blame Line' })
-- vim.keymap.set('n', '<leader>gB', gitsigns.toggle_current_line_blame, { noremap = true, silent = true, desc = 'Toggle Git Show Blame Line' })

-- Preview
vim.keymap.set('n', '<leader>gp', gitsigns.preview_hunk, { noremap = true, silent = true, desc = 'Git Preview Hunk' })

-- Show Deleted
vim.keymap.set('n', '<leader>gx', gitsigns.toggle_deleted, { noremap = true, silent = true, desc = 'Toggle Git Show Deleted' })

-- Diff mode
vim.keymap.set('n', '<leader>gd', gitsigns.diffthis, { noremap = true, silent = true, desc = 'Git Diff Against Index' })

vim.keymap.set('n', '<leader>gD', function()
  gitsigns.diffthis '@'
end, { noremap = true, silent = true, desc = 'Git Diff Against Last Commit' })

-----------------------------------
-- Code run
-----------------------------------
vim.keymap.set('n', '<leader>rr', ':!python %<CR>', { noremap = true, silent = true, desc = 'Run Current Python file' })
vim.keymap.set('n', '<Leader>rc', '<cmd>Run<cr>', { noremap = true, silent = true, desc = 'Run with CodeRunner (Console stays)' })

-----------------------------------
-- Mason & Lazy fast
-----------------------------------
vim.keymap.set('n', '<leader>L', ':Lazy<CR>', { noremap = true, silent = true, desc = 'Lazy' })
vim.keymap.set('n', '<leader>M', ':Mason<CR>', { noremap = true, silent = true, desc = 'Mason' })

-----------------------------------
-- Bookmarks
-----------------------------------
vim.keymap.set({ 'n', 'v' }, 'mm', '<cmd>BookmarksMark<cr>', { noremap = true, silent = true, desc = 'Mark current line into active BookmarkList.' })
vim.keymap.set({ 'n', 'v' }, 'mo', '<cmd>BookmarksGoto<cr>', { noremap = true, silent = true, desc = 'Go to bookmark at current active BookmarkList' })
vim.keymap.set({ 'n', 'v' }, 'm1', '<cmd>BookmarksGotoPrev<cr>', { noremap = true, silent = true, desc = 'Go to next bookmark in line number order' })
vim.keymap.set({ 'n', 'v' }, 'm2', '<cmd>BookmarksGotoNext<cr>', { noremap = true, silent = true, desc = 'Go to previous bookmark in line number order' })

vim.keymap.set({ 'n', 'v' }, 'md', function()
  require('bookmarks.commands').delete_mark_of_current_file()
end, { noremap = true, silent = true, desc = 'Clear All Bookmark in File' })

-----------------------------------
-- Copilot
-----------------------------------
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.keymap.set('i', '<M-CR>', function()
  vim.fn.feedkeys(vim.fn['copilot#Accept'](), 'n')
end, { expr = true, silent = true })
vim.keymap.set('i', '<M-]>', '<Plug>(copilot-next)', { noremap = true, silent = true })
vim.keymap.set('i', '<M-[>', '<Plug>(copilot-previous)', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>cc', ':CopilotChat<CR>', { noremap = true, silent = true, desc = 'CopilotChat' })
vim.keymap.set('n', '<leader>cd', ':Copilot disable<CR>', { noremap = true, silent = true, desc = 'Copilot disable' })
vim.keymap.set('n', '<leader>ce', ':Copilot enable<CR>', { noremap = true, silent = true, desc = 'Copilot enable' })

-----------------------------------
-- Clear highlights on search when pressing <Esc> in normal mode
-----------------------------------
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-----------------------------------
-- Terminal
-----------------------------------
vim.keymap.set('n', '<leader>tt', "<cmd>lua require('FTerm').open()<cr>", { noremap = true, silent = true, desc = 'Terminal Open' })
vim.keymap.set('t', '<esc>', "<cmd>lua require('FTerm').exit()<cr>", { noremap = true, silent = true, desc = 'Terminal Exit' })

-----------------------------------
-- Keybinds to make split navigation easier.
-----------------------------------
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { noremap = true, silent = true, desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { noremap = true, silent = true, desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { noremap = true, silent = true, desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { noremap = true, silent = true, desc = 'Move focus to the upper window' })

-----------------------------------
-- Nvim-tree
-----------------------------------
vim.keymap.set('n', '<leader>ee', ':NvimTreeToggle<CR>', { noremap = true, silent = true, desc = 'Toggle File Tree' })
vim.keymap.set('n', '<leader>er', ':NvimTreeFocus<CR>', { noremap = true, silent = true, desc = 'Focus to File Tree' })

-----------------------------------
-- Breakpoints
-----------------------------------
-- vim.keymap.set('n', '<leader>bb', "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
vim.keymap.set('n', '<leader>bb', dap.toggle_breakpoint, { noremap = true, silent = true, desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>br', dap.clear_breakpoints, { noremap = true, silent = true, desc = 'Debug: Clear All Breakpoints' })

vim.keymap.set('n', '<leader>bB', function()
  dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { noremap = true, silent = true, desc = 'Debug: Set Named Breakpoint' })

-----------------------------------
-- Debugging
-----------------------------------
vim.keymap.set('n', '<leader>dd', dap.continue, { noremap = true, silent = true, desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<leader>di', dap.step_into, { noremap = true, silent = true, desc = 'Debug: Step Into Function' })
vim.keymap.set('n', '<leader>do', dap.step_out, { noremap = true, silent = true, desc = 'Debug: Step Out Function' })
vim.keymap.set('n', '<leader>dj', dap.step_over, { noremap = true, silent = true, desc = 'Debug: Jump Over Function' })

vim.keymap.set('n', '<leader>dt', function()
  dap.terminate()
  dapui.close()
end, { noremap = true, silent = true, desc = 'Debug: Terminate' })

vim.keymap.set('n', '<leader>dc', dap.repl.toggle, { noremap = true, silent = true, desc = 'Debug: toggle console' })

vim.keymap.set('n', '<leader>dv', function()
  require('dap.ui.widgets').hover()
end, { noremap = true, silent = true, desc = 'Debug: Show Value of Variable under cursor' })

vim.keymap.set('n', '<leader>d?', function()
  local widgets = require 'dap.ui.widgets'
  widgets.centered_float(widgets.scopes)
end, { noremap = true, silent = true, desc = 'Debug: Show All Variables of Scope' })

-----------------------------------
-- Harpoon
-----------------------------------

vim.keymap.set('n', '<leader>ha', function()
  harpoon:list():add()
end, { noremap = true, silent = true, desc = 'Harpoon add' })
vim.keymap.set('n', '<leader>hh', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { noremap = true, silent = true, desc = 'Harpoon list' })

-- Generate map for buffers 1-9 with loop
for i = 1, 9 do
  vim.keymap.set('n', '<leader>' .. i, function()
    harpoon:list():select(i)
  end, { noremap = true, silent = true, desc = 'Harpoon: buffer ' .. i })
end

-----------------------------------
-- zen-mode.nvim
-----------------------------------
vim.keymap.set('n', '<leader>z', ':ZenMode<CR>:wincmd |<CR>', { noremap = true, silent = true, desc = 'Zen Mode' })

-----------------------------------
-- Neotest
-----------------------------------
-- vim.keymap.set('n', '<leader>tn', function()
--   require('neotest').run.run()
-- end, { noremap = true, silent = true, desc = 'Run nearest test in the file' })
--
-- vim.keymap.set('n', '<leader>tt', function()
--   require('neotest').run.run(vim.fn.expand '%')
-- end, { noremap = true, silent = true, desc = 'Run all the tests in the file' })
--
-- vim.keymap.set('n', '<leader>to', function()
--   require('neotest').output.open { enter = true }
-- end, { noremap = true, silent = true, desc = 'output.open' })
--
-- vim.keymap.set('n', '<leader>ts', function()
--   require('neotest').summary.toggle()
-- end, { noremap = true, silent = true, desc = 'summary_toggle' })
--
-- vim.keymap.set('n', '<leader>tw', function()
--   require('neotest').watch.watch()
-- end, { noremap = true, silent = true, desc = 'watch current test for changes' })

-----------------------------------
-- Other plugins
-----------------------------------
vim.keymap.set('n', '<leader>ou', vim.cmd.UndotreeToggle, { noremap = true, silent = true, desc = 'UndoTree' })
vim.keymap.set('n', '<leader>oa', "<cmd>lua require('nvim-autopairs').toggle()<cr>", { noremap = true, silent = true, desc = 'Toggle Autopairs' })

-----------------------------------
-- AutoTyping
-----------------------------------
-- New Line
vim.keymap.set('n', '<CR>', 'o<Esc>', { noremap = true, silent = true, desc = 'New underline' })

-- Code Blocks
vim.keymap.set('n', '<leader>acb', 'i```bash<cr><cr>```<cr><esc>kk', { noremap = true, silent = true, desc = 'Code Block: bash' })
vim.keymap.set('n', '<leader>acp', 'i```python<cr><cr>```<cr><esc>kk', { noremap = true, silent = true, desc = 'Code Block: python' })
vim.keymap.set('n', '<leader>acl', 'i```lua<cr><cr>```<cr><esc>kk', { noremap = true, silent = true, desc = 'Code Block: lua' })
vim.keymap.set('n', '<leader>ach', 'i```hyprlang<cr><cr>```<cr><esc>kk', { noremap = true, silent = true, desc = 'Code Block: hyprlang' })

-- Special
vim.keymap.set('n', '<leader>a>', 'i><cr><esc>', { noremap = true, silent = true, desc = '> Sign' })
vim.keymap.set('n', '<leader>al', 'i<cr>---<cr><cr><esc>', { noremap = true, silent = true, desc = 'Line' })

-- Callouts
vim.keymap.set('n', '<leader>aw', 'i>[!warning] ', { noremap = true, silent = true, desc = 'Warning' })
vim.keymap.set('n', '<leader>at', 'i>[!tip] ', { noremap = true, silent = true, desc = 'Tip' })
vim.keymap.set('n', '<leader>ad', 'i>[!danger] ', { noremap = true, silent = true, desc = 'Danger' })
vim.keymap.set('n', '<leader>aC', 'i>[!caution] ', { noremap = true, silent = true, desc = 'Caution' })
vim.keymap.set('n', '<leader>ae', 'i>[!example] ', { noremap = true, silent = true, desc = 'Example' })
vim.keymap.set('n', '<leader>ab', 'i>[!bug] ', { noremap = true, silent = true, desc = 'Bug' })
vim.keymap.set('n', '<leader>ac', 'i>[!caution] ', { noremap = true, silent = true, desc = 'Caution' })
