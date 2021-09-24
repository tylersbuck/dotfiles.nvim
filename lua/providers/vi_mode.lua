-- Provider functions related to Vi modes

local M = {}

local colors = require('colors')

-- Table of mode information indexed by the mode identifier
local modes = {
    ['n'] = { alias = 'NORMAL', color = colors.green },
    ['no'] = { alias = 'NPENDING', color = colors.green },
    ['nov'] = { alias = 'NPENDING', color = colors.green },
    ['noV'] = { alias = 'NPENDING', color = colors.green },
    ['no'] = { alias = 'NPENDING', color = colors.green },
    ['niI'] = { alias = 'NORMAL', color = colors.green },
    ['niR'] = { alias = 'NORMAL', color = colors.green },
    ['niV'] = { alias = 'NORMAL', color = colors.green },
    ['v'] = { alias = 'VISUAL', color = colors.magenta },
    ['V'] = { alias = 'VLINE', color = colors.magenta },
    [''] = { alias = 'VBLOCK', color = colors.magenta },
    ['s'] = { alias = 'SELECT', color = colors.blue },
    ['S'] = { alias = 'SLINE', color = colors.blue },
    [''] = { alias = 'SBLOCK', color = colors.blue },
    ['i'] = { alias = 'INSERT', color = colors.yellow },
    ['ic'] = { alias = 'INSERT', color = colors.yellow },
    ['ix'] = { alias = 'INSERT', color = colors.yellow },
    ['R'] = { alias = 'REPLACE', color = colors.red },
    ['Rc'] = { alias = 'REPLACE', color = colors.red },
    ['Rv'] = { alias = 'VREPLACE', color = colors.red },
    ['Rx'] = { alias = 'REPLACE', color = colors.red },
    ['c'] = { alias = 'COMMAND', color = colors.cyan },
    ['cv'] = { alias = 'COMMAND', color = colors.cyan },
    ['ce'] = { alias = 'COMMAND', color = colors.cyan },
    ['r'] = { alias = 'PROMPT', color = colors.cyan },
    ['rm'] = { alias = 'MORE', color = colors.blue },
    ['r?'] = { alias = 'CONFIRM', color = colors.blue },
    ['!'] = { alias = 'SHELL', color = colors.cyan },
    ['t'] = { alias = 'TERMINAL', color = colors.cyan },
    ['null'] = { alias = 'NONE', color = colors.white1 },
}

-- Get the current mode identifier as defined by vim
-- This is used to index the mode information table
function M.id()
  -- return vim.fn.mode()
  return vim.api.nvim_get_mode().mode
end

-- Get the information for the current mode
function M.mode()
    return modes[M.id()]
end

-- Get the aliased name of the current mode
-- This is usually something easier to understand than the mode id
function M.alias()
    return M.mode().alias
end

-- Get the color associated with the current mode
function M.color()
    return M.mode().color
end

return M

