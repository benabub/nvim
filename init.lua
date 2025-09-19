-- First, load the core configuration
require 'core.config'
require 'core.autocommands'
require 'core.health'

-- Second, load the plugins
require 'core.lazy'

-- Third, load the keymappings
require 'core.keymappings'
require 'core.layout_switcher'

-- Snippets
require('luasnip.loaders.from_lua').load { paths = '~/.config/nvim/lua/snippets/' }

-- Custom plugins
