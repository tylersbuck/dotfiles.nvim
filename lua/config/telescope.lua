-- telescope.lua

-- Configuration for 'nvim-telescope/telescope.nvim'.

local present, telescope = pcall(require, 'telescope')
if not present then
  return
end

local vimgrep_command = 'rg'

if (vim.env.HOSTNAME == 'FDVMPRDLIN1') then
  -- Use local rg
  local vimgrep_command = vim.env.HOME .. '/.local/bin/rg'

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
      '--smart-case'
    },
    --prompt_prefix = "> ",
    --selection_caret = "> ",
    --entry_prefix = "  ",
    --initial_mode = "insert",
    --selection_strategy = "reset",
    --sorting_strategy = "descending",
    layout_strategy = "flex",
    layout_config = {
      vertical = {
        preview_cutoff = 24,
      },
      flex = {
        -- Number of columns required to move to horizontal mode
        flip_columns = 180,
      },
    },
    --border = {},
    --borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    --use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
  },
  pickers = {
    find_files = {
      -- Need to hide .git etc,...
      -- hidden = true,
    },
    --[[
    buffers = {
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = {
          ["<c-d>"] = require("telescope.actions").delete_buffer,
          -- Right hand side can also be the name of the action as a string
          ["<c-d>"] = "delete_buffer",
        },
        n = {
          ["<c-d>"] = require("telescope.actions").delete_buffer,
        }
      }
    },
    --]]
  },
  --[[
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
  },
  --]]
})

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
--telescope.load_extension('fzf')

