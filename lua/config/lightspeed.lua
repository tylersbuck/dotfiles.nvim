-- lightspeed.lua

-- Configuration for 'ggandor/lightspeed.nvim'.
-- See help for more details and default mappings.

local present, lightspeed = pcall(require, 'lightspeed')
if not present then
  return
end

lightspeed.setup {
  grey_out_search_area = false,
}

