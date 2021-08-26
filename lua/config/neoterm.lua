-- neoterm.lua

-- Configuration for 'neoterm/neoterm'.

vim.api.nvim_set_keymap(
  'n', ' r', ':Tkill <bar> :Texec tail<CR>', {noremap = true, silent = true}
)

