-- Configuration for 'famiu/feline.nvim'

local present, feline = pcall(require, 'feline')
if (not present) then
  return
end

local colors = require('colors')

local provider_mode = require('providers.vi_mode')
local provider_fileinfo = require('providers.fileinfo')
local provider_devicons = require('providers.devicons')
local provider_lsp = require('providers.lsp')
local provider_git = require('providers.git')

-- TODO: Use feline's builtin separator definition?
local separator_left = ''
local separator_right = ' '
-- This won't actually be seen since the fg and bg are intended to be set the
-- same but this glyph provides a particular amount of spacing
local separator_spacer = '▋'

-- TODO: Use feline's builtin icon definition?
local icon_vim = ''
local icon_dir = ''
local icon_modified = ''
local icon_readonly = ''
local icon_position = ''
local icon_lsp = ''
local icon_error = ''
local icon_warning = ''

-- TODO: Use feline's builtin colorscheme definition?
local colorscheme = {
  base_bg = colors.black2,
  base_fg = colors.gray5,
  weak_fg = colors.gray4,
  primary_bg = colors.black0,
  secondary_bg = colors.gray1,
}

-- Initialize the components table
local components = {
  active = {},
  inactive = {},
}

-- Insert sections for the active statusline
local ACTIVE_LEFT_INDEX = 1
local ACTIVE_CENTER_INDEX = 2
local ACTIVE_RIGHT_INDEX = 3

table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})

--------------------------------------------------------------------------------
-- Functions {{{1

local function has_space_for_minor_component(winid)
  winid = winid or 0
  local winwidth = vim.fn.winwidth(winid)
  local squeeze_width = winwidth / 4
  if (winwidth <= 80 or squeeze_width < 30) then
    return false
  end
  return true
end

--}}}
--------------------------------------------------------------------------------
-- Left {{{1

-- Mode indicator
table.insert(components.active[ACTIVE_LEFT_INDEX], {
  provider = function()
    return icon_vim .. ' ' .. provider_mode.alias() .. ' '
  end,
  hl = function()
    return {
      name = 'FelineComponentMode' .. provider_mode.alias(),
      fg = colors.black2,
      bg = provider_mode.color(),
    }
  end,
  left_sep = {
    str = separator_spacer,
    hl = function()
      return {
        name = 'FelineComponentModeSpacer' .. provider_mode.alias(),
        fg = provider_mode.color(),
        bg = provider_mode.color(),
      }
    end,
  },
  right_sep = {
    str = separator_right,
    hl = function()
      return {
        name = 'FelineComponentModeRight' .. provider_mode.alias() .. (vim.fn.winwidth(0) <= 80 and 'Small' or ''),
        fg = provider_mode.color(),
        bg = (vim.fn.winwidth(0) <= 80 and colorscheme.primary_bg) or colorscheme.secondary_bg,
      }
    end,
  },
})

-- Working directory
-- Hidden on smaller windows
table.insert(components.active[ACTIVE_LEFT_INDEX], {
  provider = function()
    return icon_dir .. ' ' .. provider_fileinfo.cwd() .. ' '
  end,
  enabled = function(winid)
    return vim.fn.winwidth(winid) > 80
  end,
  hl = {
    name = 'FelineComponentCwd',
    fg = colorscheme.base_fg,
    bg = colorscheme.secondary_bg,
  },
  right_sep = {
    str = separator_right,
    hl = {
      name = 'FelineComponentCwdRight',
      fg = colorscheme.secondary_bg,
      bg = colorscheme.primary_bg,
    },
  },
})

-- Current file info
table.insert(components.active[ACTIVE_LEFT_INDEX], {
  provider = function()
    local ftypeicon = provider_devicons.icon()
    local flocation = provider_fileinfo.location()
    local fmodified = provider_fileinfo.modified()
    local freadonly = provider_fileinfo.readonly()
    local ficon = (fmodified and icon_modified .. ' ') or (freadonly and icon_readonly .. ' ') or ''
    return ftypeicon .. ' ' .. flocation .. ' ' .. ficon
  end,
  hl = {
    name = 'FelineComponentFile',
    fg = colorscheme.base_fg,
    bg = colorscheme.primary_bg,
  },
  right_sep = {
    {
      str = separator_right,
      hl = {
        name = 'FelineComponentFileRight',
        fg = colorscheme.primary_bg,
        bg = colorscheme.base_bg,
      },
    },
  },
})

--}}}
--------------------------------------------------------------------------------
-- Right {{{1

-- LSP status
table.insert(components.active[ACTIVE_RIGHT_INDEX], {
  provider = function(_, winid)
    local has_client = provider_lsp.has_active_client_for_filetype(winid)
    if (not has_client) then
      return ''
    end
    local error_count = provider_lsp.diagnostic_error_count(winid)
    local warn_count = provider_lsp.diagnostic_warning_count(winid)
    if (error_count > 0 or warn_count > 0) then
      local count_string = ''
      if (error_count > 0) then
        count_string = count_string .. '  ' .. error_count
      end
      if (warn_count > 0) then
        count_string = count_string .. '  ' .. warn_count
      end
      return count_string .. ' '
    end
    -- TODO: display this in red if server has errors
    return '  LSP '
  end,
  enabled = function(winid)
    return vim.fn.winwidth(winid) > 80 and provider_lsp.has_active_client_for_filetype(winid)
  end,
  hl = {
    name = 'FelineComponentLSP',
    fg = colorscheme.weak_fg,
    bg = colorscheme.base_bg,
  },
})

-- Diff added
table.insert(components.active[ACTIVE_RIGHT_INDEX], {
  provider = function(_, winid)
    local added_count = provider_git.diff_added(winid)
    if (added_count > 0) then
      return '  ' .. added_count .. ' '
    end
    return ''
  end,
  enabled = function(winid)
    return has_space_for_minor_component(winid)
  end,
  hl = {
    name = 'FelineComponentGitAdded',
    fg = colorscheme.weak_fg,
    bg = colorscheme.base_bg,
  },
})

-- Diff changed
table.insert(components.active[ACTIVE_RIGHT_INDEX], {
  provider = function(_, winid)
    local changed_count = provider_git.diff_changed(winid)
    if (changed_count > 0) then
      return '  ' .. changed_count .. ' '
    end
    return ''
  end,
  enabled = function(winid)
    return has_space_for_minor_component(winid)
  end,
  hl = {
    name = 'FelineComponentGitChanged',
    fg = colorscheme.weak_fg,
    bg = colorscheme.base_bg,
  },
})

-- Diff removed
table.insert(components.active[ACTIVE_RIGHT_INDEX], {
  provider = function(_, winid)
    local removed_count = provider_git.diff_removed(winid)
    if (removed_count > 0) then
      return '  ' .. removed_count .. ' '
    end
    return ''
  end,
  enabled = function(winid)
    return has_space_for_minor_component(winid)
  end,
  hl = {
    name = 'FelineComponentGitRemoved',
    fg = colorscheme.weak_fg,
    bg = colorscheme.base_bg,
  },
})

-- Git branch name
table.insert(components.active[ACTIVE_RIGHT_INDEX], {
  provider = function(_, winid)
    return '  ' .. provider_git.branch_name(winid) .. ' '
  end,
  enabled = function(winid)
    return vim.fn.winwidth(winid) > 80 and provider_git.has_git(winid)
  end,
  hl = {
    name = 'FelineComponentGitBranch',
    fg = colorscheme.weak_fg,
    bg = colorscheme.base_bg,
  },
})

-- Cursor position
table.insert(components.active[ACTIVE_RIGHT_INDEX], {
  provider = function()
    local line = provider_fileinfo.line()
    local column = provider_fileinfo.column()
    return string.format('  %3d:%-2d ', line, column)
  end,
  hl = {
    name = 'FelineComponentPosition',
    fg = colorscheme.base_fg,
    bg = colorscheme.primary_bg,
  },
  left_sep = {
    {
      str = ' ' .. separator_left,
      hl = {
        name = 'FelineComponentPositionSeparator',
        fg = colorscheme.secondary_bg,
        bg = colorscheme.base_bg,
      },
    },
    {
      str = icon_position .. ' ',
      hl = {
        name = 'FelineComponentPositionIcon',
        fg = colorscheme.base_fg,
        bg = colorscheme.secondary_bg,
      },
    }
  },
})

--}}}
--------------------------------------------------------------------------------
-- Inactive {{{1

-- Get highlight of inactive statusline by parsing the style, fg and bg of
-- VertSplit
local InactiveStatusHL = {
  fg = vim.api.nvim_exec("highlight VertSplit", true):match("guifg=(#[0-9A-Fa-f]+)") or "#131313",
  bg = vim.api.nvim_exec("highlight VertSplit", true):match("guibg=(#[0-9A-Fa-f]+)") or "#222222",
  style = vim.api.nvim_exec("highlight VertSplit", true):match("gui=(#[0-9A-Fa-f]+)") or "",
}

-- Add underline to inactive statusline highlight style in order to have a thin
-- line instead of the statusline
if (InactiveStatusHL.style == '') then
  InactiveStatusHL.style = 'strikethrough'
else
  InactiveStatusHL.style = InactiveStatusHL.style .. ',strikethrough'
end

-- Apply the highlight to the statusline by having an empty provider with the
-- highlight
components.inactive = {
  {
    {
      provider = '',
      hl = InactiveStatusHL,
    },
  },
}

--}}}
--------------------------------------------------------------------------------
-- Setup feline {{{1

feline.setup({
  components = components,
  theme = {
    fg = colorscheme.base_fg,
    bg = colorscheme.base_bg,
  },
  force_inactive = {
    filetypes = {
        '^NvimTree$',
        '^packer$',
        '^startify$',
        '^fugitive$',
        '^fugitiveblame$',
        '^qf$',
        '^help$'
    },
    buftypes = {
        '^terminal$'
    },
    bufnames = {},
  },
})

--}}}
--------------------------------------------------------------------------------
-- vim:foldmethod=marker
