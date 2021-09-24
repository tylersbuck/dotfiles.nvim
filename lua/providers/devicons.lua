-- Providers for devicons

local M = {}

local fileinfo_provider = require('providers.fileinfo')

-- TODO: get file icon color

function M.icon()
  if (vim.fn.exists("*WebDevIconsGetFileTypeSymbol") == 1) then
    return vim.fn.WebDevIconsGetFileTypeSymbol()
  end
  local present, devicons = pcall(require, 'nvim-web-devicons')
  if (not present) then
    print('No icon plugin found. Please install \'kyazdani42/nvim-web-devicons\'')
    return ''
  end
  local fname  = fileinfo_provider.name()
  local fext = fileinfo_provider.extension()
  local ftype = fileinfo_provider.type()
  local icon = devicons.get_icon(fname, fext)
  if (icon == nil) then
    icon = ''
    -- if user_icons[ftype] ~= nil then
    --   icon = user_icons[ftype][2]
    -- elseif user_icons[fext] ~= nil then
    --   icon = user_icons[fext][2]
    -- else
    --   icon = ''
    -- end
  end
  return icon
end

return M
