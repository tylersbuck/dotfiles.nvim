-- Configuration for using indent-blankline with treesitter
-- TODO: set per-buffer, run everytime new treesitter filetype buffer is opened

vim.cmd [[
  augroup IndentBlanklineContextAutogroup
    autocmd!
    autocmd CursorMoved * IndentBlanklineRefresh
  augroup END
]]

-- Use treesitter to calculate indentation when possible.
vim.g.indent_blankline_use_treesitter = true

-- When on, use treesitter to determine the current context. Then show the
-- indent character in a different highlight.
-- NOTE: Breaks indent guide for filetypes that don't load treesitter
vim.g.indent_blankline_show_current_context = true

-- Specifies the list of character highlights for the current context at
-- each indentation level. Ignored if the value is an empty list.
-- Only used when |g:indent_blankline_show_current_context| is active.
vim.g.indent_blankline_context_highlight_list = {'Comment'}

-- Specifies a list of lua patterns that are used to match against the
-- treesitter |tsnode:type()| at the cursor position to find the current
-- context. Only used when |g:indent_blankline_show_current_context| is active.
-- To learn more about how lua patterns work, see here:
--   https://www.lua.org/manual/5.1/manual.html#5.4.1
vim.g.indent_blankline_context_patterns = {
  'class',
  'function',
  'method',
  'for',
  'while',
  'if',
  'switch',
  'case',
  'table'
}

