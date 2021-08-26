-- dashboard.lua

-- Configuration for 'glepnir/dashboard-nvim'.

-- Select which fuzzy finder plugin to apply
-- 'clap', 'fzf', or 'telescope'.
vim.g.dashboard_default_executive = 'telescope'

-- vim.g.mapleader = '\<Space>'

vim.g.dashboard_custom_header = {
  '',
  ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
  ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
  ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
  ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
  ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
  ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
  '',
}

vim.g.dashboard_custom_footer = {''}

-- eg : "SPC mean the leaderkey
-- vim.g.dashboard_custom_shortcut = {
--   'last_session' = 'SPC s l',
--   'find_history' = 'SPC f h',
--   'find_file' = 'SPC f f',
--   'new_file' = 'SPC c n',
--   'change_colorscheme' = 'SPC t c',
--   'find_word' = 'SPC f a',
--   'book_marks' = 'SPC f b',
-- }

-- vim.g.dashboard_custom_shortcut_icon['last_session'] = ' '

-- Session keymaps
vim.api.nvim_set_keymap('n', '<Leader>ss', ':<C-u>SessionSave<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>sl', ':<C-u>SessionLoad<CR>', {})

-- Dashboard commands
vim.api.nvim_set_keymap(
  'n', '<Leader>fh', ':DashboardFindHistory<CR>',
  {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
  'n', '<Leader>ff', ':DashboardFindFile<CR>',
  {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
  'n', '<Leader>tc', ':DashboardChangeColorscheme<CR>',
  {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
  'n', '<Leader>fa', ':DashboardFindWord<CR>',
  {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
  'n', '<Leader>fb', ':DashboardJumpMark<CR>',
  {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
  'n', '<Leader>cn', ':DashboardNewFile<CR>',
  {noremap = true, silent = true}
)

