return {

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>l', group = 'LSP commands' },
        { '<leader>s', group = 'Telescope Search' },
        { '<leader>b', group = 'Breakpoints' },
        { '<leader>d', group = 'Debug' },
        { '<leader>e', group = 'Tree' },
        { '<leader>w', group = 'File: Write | Close | Format' },
        { '<leader>r', group = 'Run Code' },
        { '<leader>o', group = 'Other Plugins' },
        { '<leader>m', group = 'Manipulations' },
        { '<leader>c', group = 'Copilot' },
        { '<leader>t', group = 'Terminal' },
        { '<leader>x', group = 'Diagnostics | Trouble' },
        { '<leader>h', group = 'Harpoon' },
        { '<leader>v', group = 'Visual Selection' },
        { '<leader>a', group = 'AutoType' },
        { '<leader>ac', group = 'Code Blocks' },
        { '<leader>g', group = 'Git' },
        { '<leader>n', group = 'Navigation' },
        -- free:
        -- q y u i p
        -- f g j k
        -- z x
      },
    },
  },
}
