-- indent-blankline.lua

-- Configuration for 'lukas-reineke/indent-blankline.nvim'.
-- See :help indent-blankline for details.

-- Should be enabled by default, but just in case...
vim.g.indentLine_enabled = 1

-- Specifies a list of |filetype| values for which this plugin is not enabled.
-- Ignored if the value is an empty list.
vim.g.indent_blankline_filetype_exclude = {
  'help', 'terminal', 'dashboard', 'startify', 'git', 'markdown', 'txt'
}

-- Specifies a list of |buftype| values for which this plugin is not enabled.
-- Ignored if the value is an empty list.
vim.g.indent_blankline_buftype_exclude = {
  'terminal'
}

-- Specifies the character to be used as indent line.
vim.g.indent_blankline_char = '▏'

-- Displays indentation in the first column.
vim.g.indent_blankline_show_first_indent_level = true

-- Displays a trailing indentation guide on blank lines, to match the
-- indentation of surrounding code. Turn this off if you want to use background
-- highlighting instead of chars.
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Specifies the maximum indent level to display.
vim.g.indent_blankline_indent_level = 15

-- Displays the full fold text instead of the indent guide on folded lines.
-- Note: There is no autocommand to subscribe to changes in folding. This
--       might lead to unexpected results. A possible solution for this is to
--       remap folding bindings to also call |IndentBlanklineRefresh|
vim.g.indent_blankline_show_foldtext = true

-- Sets the buffer of extra lines before and after the current viewport that
-- are considered when generating indentation and the context.
vim.g.indent_blankline_viewport_buffer = 50

