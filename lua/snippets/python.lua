local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s('main', {
    t 'if __name__ == "__main__":',
    -- 2 text nodes: '' - newline, '    ' - 4 spaces
    t { '', '    ' },
    -- '1' - necessary arg: int of focus position, moved from one to another with Tab
    -- thirst: stays automatically
    -- last: go out from snippet
    i(1, 'main()'),
  }),
}
