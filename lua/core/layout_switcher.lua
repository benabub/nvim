-- In/Out visual mode: Auto keyboard layout switch

local switch_layout_script = '$HOME/.config/hypr/scripts/switch-keyboard-layout.sh'

--------------------------------------------------
-- Auto keyboard layout switch helpers
--------------------------------------------------
local function map_insert_with_switch(mode, key, insert_cmd)
  vim.keymap.set(mode, key, function()
    vim.api.nvim_feedkeys(insert_cmd, 'n', false)
    vim.fn.system(switch_layout_script)
  end)
end

-- Insert mode mappings with layout switch
map_insert_with_switch('n', '<A-i>', 'i')
map_insert_with_switch('n', '<A-I>', 'I')
map_insert_with_switch('n', '<A-a>', 'a')
map_insert_with_switch('n', '<A-A>', 'A')
map_insert_with_switch('n', '<A-o>', 'o')
map_insert_with_switch('n', '<A-O>', 'O')

--------------------------------------------------
-- <Esc> handler for keyboard layout
--------------------------------------------------
local is_us_layout = function()
  local handle = io.popen "hyprctl devices | grep -A 10 'keyboard' | grep 'active keymap' | awk 'NR==1{print $3}'"
  if not handle then
    return true
  end
  local result = handle:read('*l'):gsub('%s+', '')
  handle:close()
  return result == 'English'
end

vim.keymap.set('i', '<Esc>', function()
  if not is_us_layout() then
    vim.fn.system(switch_layout_script)
  end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
end)
--------------------------------------------------
