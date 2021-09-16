-- bufferline.lua

-- Configuration for 'akinsho/nvim-bufferline.lua'.

local present, bufferline = pcall(require, 'bufferline')
if not present then
  return
end

-- These commands will navigate through buffers in order regardless of which
-- mode you are using
-- e.g. if you change the order of buffers :bnext and :bprevious will not
-- respect the custom ordering
vim.api.nvim_set_keymap(
  'n', ']b', ':BufferLineCycleNext<CR>', {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
  'n', '[b', ':BufferLineCyclePrev<CR>', {noremap = true, silent = true}
)

vim.api.nvim_set_keymap(
  'n', ']t', ':tabnext<CR>', {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
  'n', '[t', ':tabprevious<CR>', {noremap = true, silent = true}
)

-- These commands will move the current buffer backwards or forwards in the bufferline
-- nnoremap <silent><mymap> :BufferLineMoveNext<CR>
-- nnoremap <silent><mymap> :BufferLineMovePrev<CR>

-- These commands will sort buffers by directory, language, or a custom criteria
-- nnoremap <silent>be :BufferLineSortByExtension<CR>
-- nnoremap <silent>bd :BufferLineSortByDirectory<CR>
-- nnoremap <silent><mymap> :lua
--   require'bufferline'.sort_buffers_by(function (buf_a, buf_b)
--     return buf_a.id < buf_b.id
--   end)<CR>

local colorscheme = {
  base_bg = { attribute = 'bg', highlight = 'StatusLine', },
  base_fg = { attribute = 'fg', highlight = 'MsgArea', },
  weak_fg = { attribute = 'fg', highlight = 'Comment', },
  item_bg = { attribute = 'bg', highlight = 'Pmenu', },
  item_visible_fg = { attribute = 'fg', highlight = 'Conceal', },
  item_selected_bg = { attribute = 'bg', highlight = 'PmenuSel', },
  item_selected_fg = { attribute = 'fg', highlight = 'PmenuSel', },
}

bufferline.setup {
  options = {
    always_show_bufferline = vim.env.HOSTNAME == 'FDVMPRDLIN1',
    -- 'slant' | 'thick' | 'thin' | { 'any', 'any' },
    separator_style = 'thin',
    diagnostics = 'nvim_lsp',
    -- count is an integer representing total count of errors
    -- level is a string 'error' | 'warning'
    -- diagnostics_dict is a dictionary from error level ('error', 'warning' or
    -- 'info') to number of errors for each level. This should return a string.
    -- Don't get too fancy as this function will be executed a lot.
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return ' ' .. count
      -- Don't show indicators for current buffer
      -- if context.buffer:current() then
      --   return ''
      -- end
      -- local icon = level:match('error') and ' ' or ' '
      -- return ' ' .. icon .. count
    end,


    --[[
    number = 'none' | 'ordinal' | 'buffer_id' | 'both'
    number_style = 'superscript' | '' | { 'none', 'subscript' } -- buffer_id at index 1, ordinal at index 2
    close_command = 'bdelete! %d',       -- can be a string | function, see 'Mouse actions'
    right_mouse_command = 'bdelete! %d', -- can be a string | function, see 'Mouse actions'
    left_mouse_command = 'buffer %d',    -- can be a string | function, see 'Mouse actions'
    middle_mouse_command = nil,          -- can be a string | function, see 'Mouse actions'
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    indicator_icon = '▎',
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    name_formatter = function(buf)  -- buf contains a 'name', 'path' and 'bufnr'
      -- remove extension from markdown files for example
      if buf.name:match('%.md') then
        return vim.fn.fnamemodify(buf.name, ':t:r')
      end
    end,
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics = false | 'nvim_lsp',
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return '('..count..')'
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number)
      -- filter out filetypes you don't want to see
      if vim.bo[buf_number].filetype ~= '<i-dont-want-to-see-this>' then
        return true
      end
      -- filter out by buffer name
      if vim.fn.bufname(buf_number) ~= '<buffer-name-I-dont-want>' then
        return true
      end
      -- filter out based on arbitrary rules
      -- e.g. filter out vim wiki buffer from tabline in your work repo
      if vim.fn.getcwd() == '<work-repo>' and vim.bo[buf_number].filetype ~= 'wiki' then
        return true
      end
    end,
    offsets = {{filetype = 'NvimTree', text = 'File Explorer' | function , text_align = 'left' | 'center' | 'right'}},
    show_buffer_icons = true | false, -- disable filetype icons for buffers
    show_buffer_close_icons = true | false,
    show_close_icon = true | false,
    show_tab_indicators = true | false,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = 'slant' | 'thick' | 'thin' | { 'any', 'any' },
    enforce_regular_tabs = false | true,
    always_show_bufferline = true | false,
    sort_by = 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
      -- add custom logic
      return buffer_a.modified > buffer_b.modified
    end
    --]]
  },
  highlights = {
    fill = {
      -- bufferline background
      guibg = colorscheme.base_bg,
      -- highlights trunc markers
      guifg = colorscheme.weak_fg,
      gui = 'none',
    },
    tab = {
      guibg = colorscheme.item_bg,
      guifg = colorscheme.base_fg,
      gui = 'none',
    },
    tab_selected = {
      guibg = colorscheme.item_selected_bg,
      guifg = colorscheme.item_selected_fg,
      gui = 'none',
    },
    tab_close = {
      guibg = colorscheme.base_bg,
      guifg = colorscheme.base_fg,
      gui = 'none',
    },
    -- buffer
    background = {
      guibg = colorscheme.item_bg,
      guifg = colorscheme.base_fg,
      gui = 'none',
    },
    buffer_visible = {
      guibg = colorscheme.item_bg,
      guifg = colorscheme.item_visible_fg,
      gui = 'none',
    },
    buffer_selected = {
      guibg = colorscheme.item_selected_bg,
      guifg = colorscheme.item_selected_fg,
      gui = 'none',
    },
    indicator_selected = {
      guibg = colorscheme.item_selected_bg,
      guifg = colorscheme.item_selected_fg,
      gui = 'none',
    },
    separator = {
      guibg = colorscheme.item_bg,
      guifg = colorscheme.base_bg,
      gui = 'none',
    },
    separator_selected = {
      guibg = colorscheme.item_selected_bg,
      guifg = colorscheme.base_bg,
      gui = 'none',
    },
    separator_visible = {
      guibg = colorscheme.item_bg,
      guifg = colorscheme.base_bg,
      gui = 'none',
    },
    close_button = {
      guibg = colorscheme.item_bg,
      guifg = colorscheme.base_fg,
      gui = 'none',
    },
    close_button_visible = {
      guibg = colorscheme.item_bg,
      guifg = colorscheme.item_visible_fg,
      gui = 'none',
    },
    close_button_selected = {
      guibg = colorscheme.item_selected_bg,
      guifg = colorscheme.item_selected_fg,
      gui = 'none',
    },
    modified = {
      guibg = colorscheme.item_bg,
      guifg = colorscheme.base_fg,
      gui = 'none',
    },
    modified_visible = {
      guibg = colorscheme.item_bg,
      guifg = colorscheme.item_visible_fg,
      gui = 'none',
    },
    modified_selected = {
      guibg = colorscheme.item_selected_bg,
      guifg = colorscheme.item_selected_fg,
      gui = 'none',
    },
    diagnostic = {
      guibg = colorscheme.item_bg,
      guifg = colorscheme.base_fg,
      gui = 'none',
    },
    diagnostic_visible = {
      guibg = colorscheme.item_bg,
      guifg = colorscheme.item_visible_fg,
      gui = 'none',
    },
    diagnostic_selected = {
      guibg = colorscheme.item_selected_bg,
      guifg = colorscheme.item_selected_fg,
      gui = 'none',
      guisp = colorscheme.item_selected_fg,
    },
    info = {
      guibg = colorscheme.item_bg,
      guifg = { attribute = 'fg', highlight = 'Special', },
      gui = 'none',
    },
    info_visible = {
      guibg = colorscheme.item_bg,
      guifg = { attribute = 'fg', highlight = 'Special', },
      gui = 'none',
    },
    info_selected = {
      guibg = colorscheme.item_selected_bg,
      guifg = { attribute = 'fg', highlight = 'Special', },
      gui = 'none',
    },
    info_diagnostic = {
      guibg = colorscheme.item_bg,
      guifg = { attribute = 'fg', highlight = 'Special', },
      gui = 'none',
    },
    info_diagnostic_visible = {
      guibg = colorscheme.item_bg,
      guifg = { attribute = 'fg', highlight = 'Special', },
      gui = 'none',
    },
    info_diagnostic_selected = {
      guibg = colorscheme.item_selected_bg,
      guifg = { attribute = 'fg', highlight = 'Special', },
      gui = 'none',
      guisp = { attribute = 'fg', highlight = 'Special', },
    },
    warning = {
      guibg = colorscheme.item_bg,
      guifg = { attribute = 'fg', highlight = 'Label', },
      gui = 'none',
    },
    warning_visible = {
      guibg = colorscheme.item_bg,
      guifg = { attribute = 'fg', highlight = 'Label', },
      gui = 'none',
    },
    warning_selected = {
      guibg = colorscheme.item_selected_bg,
      guifg = { attribute = 'fg', highlight = 'Label', },
      gui = 'none',
    },
    warning_diagnostic = {
      guibg = colorscheme.item_bg,
      guifg = { attribute = 'fg', highlight = 'Label', },
      gui = 'none',
    },
    warning_diagnostic_visible = {
      guibg = colorscheme.item_bg,
      guifg = { attribute = 'fg', highlight = 'Label', },
      gui = 'none',
    },
    warning_diagnostic_selected = {
      guibg = colorscheme.item_selected_bg,
      guifg = { attribute = 'fg', highlight = 'Label', },
      gui = 'none',
      guisp = { attribute = 'fg', highlight = 'Label', },
    },
    error = {
      guibg = colorscheme.item_bg,
      guifg = { attribute = 'fg', highlight = 'Error', },
      gui = 'none',
    },
    error_visible = {
      guibg = colorscheme.item_bg,
      guifg = { attribute = 'fg', highlight = 'Error', },
      gui = 'none',
    },
    error_selected = {
      guibg = colorscheme.item_selected_bg,
      guifg = { attribute = 'fg', highlight = 'Error', },
      gui = 'none',
    },
    error_diagnostic = {
      guibg = colorscheme.item_bg,
      guifg = { attribute = 'fg', highlight = 'Error', },
      gui = 'none',
    },
    error_diagnostic_visible = {
      guibg = colorscheme.item_bg,
      guifg = { attribute = 'fg', highlight = 'Error', },
      gui = 'none',
    },
    error_diagnostic_selected = {
      guibg = colorscheme.item_selected_bg,
      guifg = { attribute = 'fg', highlight = 'Error', },
      gui = 'none',
      guisp = { attribute = 'fg', highlight = 'Error', },
    },
    --[[
    duplicate = {},
    duplicate_selected = {},
    duplicate_visible = {},
    pick = {},
    pick_selected = {},
    pick_visible = {},
    --]]
  },
}

