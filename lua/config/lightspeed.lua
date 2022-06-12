-- lightspeed.lua

-- Configuration for 'ggandor/lightspeed.nvim'.
-- See help for more details and default mappings.

local present, lightspeed = pcall(require, 'lightspeed')
if not present then
  return
end

-- This flag has been removed. To turn the 'greywash' feature off, just set all
-- attributes of the corresponding highlight group to 'none':
-- :hi LightspeedGreywash guifg=none guibg=none ...
lightspeed.setup {
  -- grey_out_search_area = false,
}

