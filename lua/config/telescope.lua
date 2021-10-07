-- telescope.lua

-- Configuration for 'nvim-telescope/telescope.nvim'.

local present, telescope = pcall(require, 'telescope')
if not present then
  return
end

local vimgrep_command = 'rg'

if (vim.env.HOSTNAME == 'FDVMPRDLIN1') then
  -- Use local rg
  vimgrep_command = vim.env.HOME .. '/.local/bin/rg'

  -- View source
  vim.api.nvim_set_keymap(
    'n', ' p',
    [[ <cmd>lua require('telescope.builtin').find_files { search_dirs = { vim.loop.cwd(), '/data/source/' .. vim.env.BRANCH } }<CR> ]],
    {noremap = true}
  )

  -- Ubergrep
  vim.api.nvim_set_keymap(
    'n', ' g',
    [[ <cmd>lua require('telescope.builtin').live_grep { search_dirs = { vim.loop.cwd(), '/data/source/' .. vim.env.BRANCH } }<CR> ]],
    {noremap = true}
  )
end

telescope.setup({
  defaults = {
    vimgrep_arguments = {
      vimgrep_command,
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      '--glob=!.git/',
      '--glob=!node_modules/',
      '--glob=!xcf/',
      '--glob=!fourjs/',
      '--glob=!javalib/',
    },
    file_ignore_patterns = {
      '.git/',
      'node_modules/',
      'xcf/',
      'fourjs/',
      'javalib/',
    },
    color_devicons = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    layout_strategy = 'flex',
    layout_config = {
      vertical = {
        preview_cutoff = 24,
      },
      flex = {
        -- Number of columns required to move to horizontal mode
        flip_columns = 180,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    file_browser = {
      hidden = true,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension('fzf')

