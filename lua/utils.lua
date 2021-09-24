-- utils.lua

local M = {}

-- String to title case
function M.title_case(str)
    return string.gsub(string.lower(str), '%a', string.upper, 1)
end

return M

