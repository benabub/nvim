return {
  'neysanfoo/coderunner.nvim',
  config = function()
    require('coderunner').setup {
      filetype_commands = {
        python = 'python3 -u "$fullFilePath"',
        lua = 'lua',
        c = { 'gcc "$fullFilePath" -o "$dir/out"', '"$dir/./out"' },
        cpp = { 'g++ "$fullFilePath" -o "$dir/out"', '"$dir/./out"' },
        java = { 'javac "$fullFilePath"', 'java -cp ".:$dir" "$fileNameWithoutExt"' },
        javascript = 'node "$fullFilePath"',
        -- add other filetypes and their corresponding run commands here
      },
      buffer_height = 10, -- height in lines
      focus_back = false, -- whether to set the cursor back to the original window after running the code
    }
    -- Optional: Add a keybinding
    vim.keymap.set('n', '<Leader>rf', '<cmd>Run<cr>', { noremap = true, silent = true })
  end,
}
