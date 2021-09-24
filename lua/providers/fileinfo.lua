-- Provider for various file information

-- TODO: Get winid as arg and use vim.api.nvim_buf_get_option ?

local M = {}

-- Utilities

local function count(base, pattern)
  return select(2, string.gsub(base, pattern, ''))
end

local function shorten_path(path, sep)
  -- ('([^/])[^/]+%/', '%1/', 1)
  return path:gsub(
    string.format('([^%s])[^%s]+%%%s', sep, sep, sep),
    '%1' .. sep,
    1
  )
end

-- Public

function M.name()
  return vim.fn.expand('%:t')
end

function M.cwd()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
end

function M.type()
  return vim.bo.filetype
end

function M.extension()
  return vim.fn.expand('%:e')
end

function M.format()
  return vim.bo.fileformat
end

function M.encoding()
  return vim.bo.fenc ~= '' and vim.bo.fenc or vim.o.enc
end

function M.readonly()
  return not vim.bo.modifiable or vim.bo.readonly
end

function M.modified()
  return vim.bo.modifiable and vim.bo.modified
end

-- Returns file path relative to cwd
-- Shortened according to the current window's available space
function M.location()
  -- just filename
  -- vim.fn.expand('%:t')
  -- absolute path
  -- vim.fn.expand('%:p')
  -- relative path
  -- vim.fn.expand('%:~:.')
  local file = vim.fn.expand('%:~:.')
  if (vim.fn.empty(file) == 1) then
    return '[No Name]'
  end

  local winwidth = vim.fn.winwidth(0)
  local estimated_space_available = winwidth / 4
  local path_separator = package.config:sub(1, 1)
  for _ = 0, count(file, path_separator) do
    if (winwidth <= 100 or #file > estimated_space_available) then
      file = shorten_path(file, path_separator)
    end
  end

  return file
end

-- Returns easy to read file size as a string
function M.size()
  local file = vim.fn.expand('%:p')
  if (vim.fn.empty(file)) then
    return ''
  end
  local size = vim.fn.getfsize(file)
  if (size == 0 or size == -1 or size == -2) then
    return ''
  end
  if (size < 1024) then
    size = size .. 'b'
  elseif (size < 1024 * 1024) then
    size = string.format('%.1f', size/1024) .. 'k'
  elseif (size < 1024 * 1024 * 1024) then
    size = string.format('%.1f', size/1024/1024) .. 'm'
  else
    size = string.format('%.1f', size/1024/1024/1024) .. 'g'
  end
  return size
end

function M.total_lines()
  return vim.fn.line('$')
end

function M.column()
  return vim.fn.col('.')
end

function M.line()
  return vim.fn.line('.')
end

function M.line_percent()
  if (M.cursor_line() == 1) then
    return 'Top'
  elseif (M.cursor_line() == M.total_lines()) then
    return 'Bot'
  end
  local result, _ = math.modf((M.cursor_line()/M.total_lines()) * 100)
  return result .. '%'
end

-- Returns column:line with some padding/truncation
function M.position()
  return string.format('  %3d:%-2d ', M.cursor_line(), M.cursor_column())
end

return M

