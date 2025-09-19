-- Status line
return {
  -- https://github.com/nvim-lualine/lualine.nvim
  'nvim-lualine/lualine.nvim',
  dependencies = {
    -- https://github.com/nvim-tree/nvim-web-devicons
    'nvim-tree/nvim-web-devicons', -- fancy icons
    -- https://github.com/linrongbin16/lsp-progress.nvim
    'linrongbin16/lsp-progress.nvim', -- LSP loading progress
  },
  opts = {
    options = {
      -- For more themes, see https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
      theme = 'codedark', -- "auto, tokyonight, catppuccin, codedark, nord"
    },
    sections = {
      -- There are 6 sections: left: a,b,c; right: x,y,z
      -- It possible to put in it any modules you wish
      -- If there are no settings -> default settings
      -- If there is an empty set -> hide section (ex: lualine_y = {},)
      -- The list of modules: (ex: lualine_b = { 'module1', 'module2' },)
      -- -- branch (git branch)
      -- -- buffers (shows currently available buffers)
      -- -- diagnostics (diagnostics count from your preferred source)
      -- -- diff (git diff status)
      -- -- encoding (file encoding)
      -- -- fileformat (file format)
      -- -- filename
      -- -- filesize
      -- -- filetype
      -- -- hostname
      -- -- location (location in file in line:column format)
      -- -- mode (vim mode)
      -- -- progress (%progress in file)
      -- -- searchcount (number of search matches when hlsearch is active)
      -- -- selectioncount (number of selected characters or lines)
      -- -- tabs (shows currently available tabs)
      -- -- windows (shows currently available windows)
      -- -- lsp_status (shows active LSPs in the current buffer and a progress spinner)
      lualine_b = { 'diagnostics' },
      lualine_c = {
        {
          -- Customize the filename part of lualine to be parent/filename
          'filename',
          file_status = true, -- Displays file status (readonly status, modified status)
          newfile_status = false, -- Display new file status (new file means no write after created)
          path = 1, -- 0: Just the filename
          -- 1: Relative path
          -- 2: Absolute path
          -- 3: Absolute path, with tilde as the home directory
          -- 4: Filename and parent dir, with tilde as the home directory
          symbols = {
            modified = '[+]', -- Text to show when the file is modified.
            readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
          },
        },
      },
      lualine_x = { 'filetype' }, -- Hide: right: all but [%][lines]
      -- lualine_y = {}, -- Hide: right: [%]
      -- lualine_z = {}, -- Hide: right: [lines]
    },
  },
}
