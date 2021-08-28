
-- galaxyline.lua

-- Configuration for 'glepnir/galaxyline.nvim'.

local colors = require('colors')

local present1, gl = pcall(require, "galaxyline")
local present2, condition = pcall(require, "galaxyline.condition")
if not (present1 or present2) then
  return
end

local gls = gl.section

gl.short_line_list = {" "}

local icon_styles = {
  default = {
    left = "",
    -- left = " ",
    right = " ",
    main_icon = "",
    -- main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },
}

local mode_colors = {
  ['n'] = { "NORMAL", colors.gray3 },
  ['no'] = { "N-PENDING", colors.yellow },
  ['i'] = { "INSERT", colors.green },
  ['ic'] = { "INSERT", colors.green },
  ['t'] = { "TERMINAL", colors.cyan },
  ['v'] = { "VISUAL", colors.magenta },
  ['V'] = { "V-LINE", colors.magenta },
  [''] = { "V-BLOCK", colors.magenta },
  ['R'] = { "REPLACE", colors.red },
  ['Rv'] = { "V-REPLACE", colors.red },
  ['s'] = { "SELECT", colors.blue },
  ['S'] = { "S-LINE", colors.blue },
  [''] = { "S-BLOCK", colors.blue },
  ['c'] = { "COMMAND", colors.cyan },
  ['cv'] = { "COMMAND", colors.cyan },
  ['ce'] = { "COMMAND", colors.cyan },
  ['r'] = { "PROMPT", colors.green },
  ['rm'] = { "MORE", colors.yellow },
  ['r?'] = { "CONFIRM", colors.blue },
  ['!'] = { "SHELL", colors.cyan },
}

local mode = function(n)
  return mode_colors[vim.fn.mode()][n]
end

local statusline_style = icon_styles.default

local left_separator = statusline_style.left
local right_separator = statusline_style.right

gls.left[1] = {
   FirstElement = {
      provider = function()
        vim.cmd("hi GalaxyFirstElement guibg=" .. mode(2) .. " guifg=" .. mode(2) )
        return "▋"
      end,
      highlight = { colors.black2, colors.gray3 },
   },
}

gls.left[2] = {
  ViModeIndicatorLeft = {
    provider = function()
      vim.cmd("hi GalaxyViModeIndicatorLeft guibg=" .. mode(2))
      return statusline_style.main_icon .. " "
    end,
    highlight = { colors.black1, colors.gray3 },
  },
}

gls.left[3] = {
  ViMode = {
    provider = function()
      vim.cmd("hi GalaxyViMode guibg=" .. mode(2))
      vim.cmd("hi ViModeSeparator guifg=" .. mode(2))
      return mode(1) .. " "
    end,
    highlight = { colors.black1, colors.gray3 },
    separator = right_separator,
    separator_highlight = { colors.gray3, colors.gray0 },
  },
}

gls.left[4] = {
  Cwd = {
    provider = function()
      local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      return " " .. dir_name .. " "
    end,
    highlight = { colors.gray4, colors.gray0 },
    separator = right_separator,
    separator_highlight = { colors.gray0, colors.black0 },
  },
}

gls.left[5] = {
  FileTypeIcon = {
    provider = function()
      local fileinfo = require('galaxyline.provider_fileinfo')
      -- vim.cmd("hi GalaxyFileTypeIcon guifg=" .. fileinfo.get_file_icon_color())
      return fileinfo.get_file_icon()
    end,
    highlight = { colors.gray4, colors.black0 },
  },
}

gls.left[6] = {
  FileName = {
    provider = function()
      local fileinfo = require("galaxyline.provider_fileinfo")
      if vim.api.nvim_buf_get_name(0):len() == 0 then
        return "[No Name] "
      end
      return fileinfo.get_current_file_name(" ", " ")
    end,
    highlight = { colors.gray4, colors.black0 },
    separator = right_separator,
    separator_highlight = { colors.black0, colors.black1 },
  },
}

gls.right[1] = {
  LineColumnIcon = {
    provider = function()
      return statusline_style.position_icon
    end,
    highlight = { colors.gray4, colors.gray0 },
    separator = left_separator,
    separator_highlight = { colors.gray0, colors.black1 },
  },
}

gls.right[2] = {
  LineColumn = {
    provider = function()
      local line = vim.fn.line('.')
      local column = vim.fn.col('.')
      return string.format("  %3d:%-2d ", line, column)
    end,
    highlight = { colors.gray4, colors.black0 },
  },
}

gls.right[3] = {
  ViModeIndicatorRight = {
    provider = function()
      -- vim.cmd("hi GalaxyViModeIndicatorRight guifg=" .. mode(2))
      -- return "🮉"
      vim.cmd("hi GalaxyViModeIndicatorRight guifg=" .. mode(2) .. " guibg=" .. mode(2))
      return " "
    end,
    -- highlight = { colors.gray3, colors.black1 },
    highlight = { colors.gray3, colors.gray3 },
  },
}






--[[
local checkwidth = function()
  local squeeze_width = vim.fn.winwidth(0) / 2
  if squeeze_width > 30 then
    return true
  end
  return false
end

gls.left[7] = {
  DiffAdd = {
    provider = "DiffAdd",
    condition = checkwidth,
    icon = "  ",
    highlight = { colors.white, colors.statusline_bg },
  },
}

gls.left[8] = {
  DiffModified = {
    provider = "DiffModified",
    condition = checkwidth,
    icon = "   ",
    highlight = { colors.grey_fg2, colors.statusline_bg },
  },
}

gls.left[9] = {
  DiffRemove = {
    provider = "DiffRemove",
    condition = checkwidth,
    icon = "  ",
    highlight = { colors.grey_fg2, colors.statusline_bg },
  },
}
--]]

--[[
gls.left[10] = {
  DiagnosticError = {
    provider = "DiagnosticError",
    icon = "  ",
    highlight = { colors.red, colors.statusline_bg },
  },
}

gls.left[11] = {
  DiagnosticWarn = {
    provider = "DiagnosticWarn",
    icon = "  ",
    highlight = { colors.yellow, colors.statusline_bg },
  },
}

gls.right[1] = {
  lsp_status = {
    provider = function()
      local clients = vim.lsp.get_active_clients()
      if next(clients) ~= nil then
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return " " .. "  " .. " LSP"
          end
        end
        return ""
      else
        return ""
      end
    end,
    highlight = { colors.grey_fg2, colors.statusline_bg },
  },
}
--]]

--[[
gls.right[2] = {
  GitIcon = {
    provider = function()
      return " "
    end,
    condition = require("galaxyline.condition").check_git_workspace,
    highlight = { colors.grey_fg2, colors.statusline_bg },
    separator = " ",
    separator_highlight = { colors.statusline_bg, colors.statusline_bg },
  },
}

gls.right[3] = {
  GitBranch = {
    provider = "GitBranch",
    condition = require("galaxyline.condition").check_git_workspace,
    highlight = { colors.grey_fg2, colors.statusline_bg },
  },
}
--]]

