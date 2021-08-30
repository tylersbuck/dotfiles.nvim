-- galaxyline.lua
--

-- Configuration for 'glepnir/galaxyline.nvim'.

local present1, gl = pcall(require, 'galaxyline')
local present2, condition = pcall(require, 'galaxyline.condition')
if not (present1 or present2) then
  return
end

local colors = require('colors')

local gls = gl.section

gl.short_line_list = {' '}

local left_separator = ''
local right_separator = ' '

local colorscheme = {
  base_bg = colors.black1,
  base_fg = colors.gray5,
  weak_fg = colors.gray4,
  primary_bg = colors.black0,
  secondary_bg = colors.gray1,
}

local mode_colors = {
  ['n'] = { 'NORMAL', colors.green },
  ['no'] = { 'N-PENDING', colors.green },
  ['i'] = { 'INSERT', colors.yellow },
  ['ic'] = { 'INSERT', colors.yellow },
  ['t'] = { 'TERMINAL', colors.cyan },
  ['v'] = { 'VISUAL', colors.magenta },
  ['V'] = { 'V-LINE', colors.magenta },
  [''] = { 'V-BLOCK', colors.magenta },
  ['R'] = { 'REPLACE', colors.red },
  ['Rv'] = { 'V-REPLACE', colors.red },
  ['s'] = { 'SELECT', colors.blue },
  ['S'] = { 'S-LINE', colors.blue },
  [''] = { 'S-BLOCK', colors.blue },
  ['c'] = { 'COMMAND', colors.cyan },
  ['cv'] = { 'COMMAND', colors.cyan },
  ['ce'] = { 'COMMAND', colors.cyan },
  ['r'] = { 'PROMPT', colors.cyan },
  ['rm'] = { 'MORE', colors.blue },
  ['r?'] = { 'CONFIRM', colors.blue },
  ['!'] = { 'SHELL', colors.cyan },
}

--------------------------------------------------------------------------------
-- Functions {{{1

local mode = function(n)
  return mode_colors[vim.fn.mode()][n]
end

local checkwidth = function()
  local winwidth = vim.fn.winwidth(0)
  local squeeze_width = winwidth / 4
  if winwidth <= 80 or squeeze_width < 30 then
    return false
  end
  return true
end

local count = function(base, pattern)
  return select(2, string.gsub(base, pattern, ''))
end

local shorten_path = function(path, sep)
  -- ('([^/])[^/]+%/', '%1/', 1)
  return path:gsub(
      string.format('([^%s])[^%s]+%%%s', sep, sep, sep), '%1' .. sep, 1)
end

--}}}
--------------------------------------------------------------------------------
-- Left {{{1

table.insert(gls.left, {
  FirstElement = {
    provider = function()
      vim.cmd('hi GalaxyFirstElement guibg='..mode(2)..' guifg='..mode(2))
      return '▋'
    end,
    highlight = { colorscheme.base_bg, colorscheme.base_fg },
  }
})

table.insert(gls.left, {
  ViModeIndicatorLeft = {
    provider = function()
      vim.cmd('hi GalaxyViModeIndicatorLeft guibg='..mode(2)..' guifg='..colors.black2)
      vim.cmd('hi ViModeIndicatorLeftSeparator guifg='..mode(2))
      return ' '
    end,
    highlight = { colorscheme.base_bg, colorscheme.base_fg },
  },
})

table.insert(gls.left, {
  ViMode = {
    provider = function()
      vim.cmd('hi GalaxyViMode guibg='..mode(2)..' guifg='..colors.black2)
      local sepbg = colorscheme.secondary_bg
      if vim.fn.winwidth(0) <= 80 then
        sepbg = colorscheme.primary_bg
      end
      vim.cmd('hi ViModeSeparator guifg='..mode(2)..' guibg='..sepbg)
      return mode(1)..' '
    end,
    highlight = { colorscheme.base_bg, colorscheme.base_fg },
    separator = right_separator,
    separator_highlight = { colorscheme.base_fg, colorscheme.secondary_bg },
  },
})

table.insert(gls.left, {
  Cwd = {
    provider = function()
      local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
      -- return ' ' .. dir_name .. ' '
      return ' ' .. dir_name .. ' '
    end,
    condition = function()
      if vim.fn.winwidth(0) > 80 then
        return true
      end
      return false
    end,
    highlight = { colorscheme.base_fg, colorscheme.secondary_bg },
    separator = right_separator,
    separator_highlight = { colorscheme.secondary_bg, colorscheme.primary_bg },
  },
})

table.insert(gls.left, {
  FileTypeIcon = {
    provider = function()
      local fileinfo = require('galaxyline.provider_fileinfo')
      -- vim.cmd('hi GalaxyFileTypeIcon guifg='..fileinfo.get_file_icon_color())
      return fileinfo.get_file_icon()
    end,
    highlight = { colorscheme.base_fg, colorscheme.primary_bg },
  },
})

table.insert(gls.left, {
  FileName = {
    provider = function()
      -- relative path
      -- vim.fn.expand('%:~:.')
      -- absolute path
      -- vim.fn.expand('%:p')
      -- just filename
      -- vim.fn.expand('%:t')
      local filestring = vim.fn.expand('%:~:.')

      if filestring == '' then filestring = '[No Name]' end

      local winwidth = vim.fn.winwidth(0)
      local estimated_space_available = winwidth / 4
      local path_separator = package.config:sub(1, 1)
      for _ = 0, count(filestring, path_separator) do
        if winwidth <= 100 or #filestring > estimated_space_available then
          filestring = shorten_path(filestring, path_separator)
        end
      end

      if vim.bo.modified then
        return filestring .. '  '
      elseif vim.bo.modifiable == false or vim.bo.readonly == true then
        return filestring .. '  '
      else
        return filestring .. ' '
      end
    end,
    highlight = { colorscheme.base_fg, colorscheme.primary_bg },
    separator = right_separator,
    separator_highlight = { colorscheme.primary_bg, colorscheme.base_bg },
  },
})

--}}}
--------------------------------------------------------------------------------
-- Right {{{1

table.insert(gls.right, {
  LspStatus = {
    -- Display diagnostic error/warn counts if available, otherwise dark gray
    -- LSP if up, red LSP if error, nothing if no LSP.
    provider = function()
      local clients = vim.lsp.get_active_clients()
      if next(clients) ~= nil then
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            local diagnostic = require('galaxyline.provider_diagnostic')
            local error_count = diagnostic.get_diagnostic_error()
            local warn_count = diagnostic.get_diagnostic_warn()
            if (error_count or warn_count) then
              local count_string = ''
              if (error_count) then
                count_string = count_string..' '..error_count
              end
              if (warn_count) then
                count_string = count_string..' '..warn_count
              end
              return count_string
            else
              -- return '  LSP '
              -- return '  LSP '
              -- return '  LSP '
              -- return '  LSP '
              -- return '  LSP '
              return '  LSP '
            end
          end
        end
        return ''
      else
        return ''
      end
    end,
    condition = function()
      -- if require('galaxyline.condition').check_active_lsp() and vim.fn.winwidth(0) > 80 then
      if vim.fn.winwidth(0) > 80 then
        return true
      end
      return false
    end,
    highlight = { colorscheme.weak_fg, colorscheme.base_bg },
  },
})

table.insert(gls.right, {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = checkwidth,
    icon = '  ',
    highlight = { colorscheme.weak_fg, colorscheme.base_bg },
    separator = ' ',
    separator_highlight = { colorscheme.base_bg, colorscheme.base_bg },
  },
})

table.insert(gls.right, {
  DiffModified = {
    provider = 'DiffModified',
    condition = checkwidth,
    -- icon = '  ',
    icon = '  ',
    highlight = { colorscheme.weak_fg, colorscheme.base_bg },
  },
})

table.insert(gls.right, {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = checkwidth,
    icon = '  ',
    highlight = { colorscheme.weak_fg, colorscheme.base_bg },
  },
})

table.insert(gls.right, {
  GitIcon = {
    provider = function()
      return '  '
      -- return ' '
      -- return ' '
    end,
    condition = function()
      if require('galaxyline.condition').check_git_workspace() and vim.fn.winwidth(0) > 80 then
        return true
      end
      return false
    end,
    highlight = { colorscheme.weak_fg, colorscheme.base_bg },
    separator = ' ',
    separator_highlight = { colorscheme.base_bg, colorscheme.base_bg },
  },
})

table.insert(gls.right, {
  GitBranch = {
    provider = 'GitBranch',
    condition = function()
      if require('galaxyline.condition').check_git_workspace() and vim.fn.winwidth(0) > 80 then
        return true
      end
      return false
    end,
    highlight = { colorscheme.weak_fg, colorscheme.base_bg },
  },
})

table.insert(gls.right, {
  CapSeparator2 = {
    provider = function()
      return '   '..left_separator
    end,
    condition = require('galaxyline.condition').check_git_workspace,
    highlight = { colorscheme.secondary_bg, colorscheme.base_bg },
  }
})

table.insert(gls.right, {
  LineColumnIcon = {
    provider = function()
      return ' '
    end,
    highlight = { colorscheme.base_fg, colorscheme.secondary_bg },
  },
})

table.insert(gls.right, {
  LineColumn = {
    provider = function()
      local line = vim.fn.line('.')
      local column = vim.fn.col('.')
      return string.format('  %3d:%-2d ', line, column)
    end,
    highlight = { colorscheme.base_fg, colorscheme.primary_bg },
  },
})

--[[
table.insert(gls.right, {
  ViModeIndicatorRight = {
    provider = function()
      vim.cmd('hi GalaxyViModeIndicatorRight guifg='..mode(2)..' guibg='..mode(2))
      return ' '
    end,
    highlight = { colorscheme.base_bg, colorscheme.base_fg },
  },
})
--]]

--}}}
--------------------------------------------------------------------------------
-- vim:foldmethod=marker
