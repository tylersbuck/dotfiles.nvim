-- Neovim configuration

require('plugins')

local cmd = vim.cmd
local g = vim.g
local opt = vim.opt

---------------------------------------------------------------------------------
-- Features {{{1

-- Don't create backup files or write to these files on save
opt.backup = false
opt.writebackup = false

-- Filetype associations
-- cmd [[
--   if has('autocmd')
--     au BufReadPost *.rkt,*.rktl set filetype=scheme
--     au BufReadPost *.ino set filetype=cpp
--     au BufNewFile *.ino set filetype=cpp
--     au BufRead *.php set ft=php.html
--     au BufNewFile *.php set ft=php.html
--   endif
-- ]]

-- Automatically reloads neovim configuration file on write
-- cmd [[ autocmd! bufwritepost init.vim source % ]]

--}}}
---------------------------------------------------------------------------------
-- Interface {{{1

-- Try to use guicolors and a dark background
opt.termguicolors = true
opt.background = 'dark'

-- Set after background=.. to avoid having highlights overridden
cmd [[ colorscheme tbck ]]

-- Display relative line numbers on the left
opt.number = true
opt.relativenumber = true

-- Remove terminal line numbers
cmd [[ autocmd TermOpen * setlocal nonumber norelativenumber ]]

-- Highlight current line
opt.cursorline = true

---- Always show the sign column
-- set signcolumn=auto:1-5 -- Breaks telescope borders
-- set signcolumn=yes
opt.signcolumn = 'yes'

-- Remove end of buffer tildes and fold chars
-- set fillchars=eob:\ ,fold:\ ,
opt.fillchars = { eob = ' ', fold = ' ', }

-- Left margin of numbers (relative number is still aligned to the left)
-- opt.numberwidth = 16

-- Set undercurl
--[[
vim.cmd [[
  let &t_Cs="\e[4:3m"
  let &t_Ce="\e[4:0m"
]]
--]]

--}}}
---------------------------------------------------------------------------------
-- Mappings {{{1

-- TODO

-- Toggle between 'paste' and 'nopaste', which turns off formatting
opt.pastetoggle = '<F2>'

-- Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
-- which is the default
cmd [[ map Y y$ ]]

-- Map <C-L> (redraw screen) to also turn off search highlighting until the
-- next search
cmd [[ nnoremap <silent> <C-L> :nohl<CR><C-L> ]]

-- :let maplocalleader = '\\'

cmd [[
  nnoremap <C-p> <cmd>Telescope find_files<cr>
  nnoremap <C-g> <cmd>Telescope live_grep<cr>
  nnoremap <C-h> <cmd>Telescope help_tags<cr>
  nnoremap <C-b> <cmd>Telescope buffers<cr>
]]

--}}}
---------------------------------------------------------------------------------
-- Formatting {{{1

-- Indentation settings for using 4 spaces instead of tabs.
-- Do not change 'tabstop' from its default value of 8 with this setup.
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

-- cmd [[ autocmd FileType css setlocal shiftwidth=2 softtabstop=2 ]]

-- Indentation settings for using hard tabs for indent. Display tabs as
-- four characters wide.
-- opt.shiftwidth = 4
-- opt.tabstop = 4

-- When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.
-- 'tabstop' is used in other places. A <BS> will delete a 'shiftwidth' worth of
-- space at the start of the line.
-- opt.smarttab = true

-- Maximum width of text that is being inserted.
-- opt.textwidth = 79

-- When opening a new line and no filetype-specific indenting is enabled, keep
-- the same indent as the line you're currently on. Useful for READMEs, etc.
opt.autoindent = true

-- This is a sequence of letters which describes how
-- automatic formatting is to be done.
--
-- letter    meaning when present in 'formatoptions'
-- ------    ---------------------------------------
-- c         Auto-wrap comments using textwidth, inserting
--           the current comment leader automatically.
-- q         Allow formatting of comments with 'gq'.
-- r         Automatically insert the current comment
--           leader after hitting <Enter> in Insert mode.
-- t         Auto-wrap text using textwidth (does not apply
--           to comments)
opt.formatoptions = 'c,q,r'

--}}}
---------------------------------------------------------------------------------
-- Usability options {{{1

-- Always display the status line, even if only one window is displayed
opt.laststatus = 2

-- Display the cursor position on the last line of the screen or in the status
-- line of a window
opt.ruler = true

-- Show partial commands in the last line of the screen
opt.showcmd = true

-- Better command-line completion
opt.wildmenu = true
opt.wildmode = 'longest,list,full'
opt.wildignore = '*.o,*~'

-- Use case insensitive search, except when using capital letters
opt.ignorecase = true
opt.smartcase = true

-- Highlight searches (use <C-L> to temporarily turn off highlighting; see the
-- mapping of <C-L> below)
-- opt.hlsearch = true

-- While typing a search command, show pattern matches.
-- opt.incsearch = true

-- Modelines have historically been a source of security vulnerabilities. As
-- such, it may be a good idea to disable them and use the securemodelines
-- script, <http://www.vim.org/scripts/script.php?script_id=1876>.
-- opt.modeline = false

-- Allow backspacing over autoindent, line breaks and start of insert action
opt.backspace= 'indent,eol,start'

-- Enable backspace wrapping.
-- opt.whichwrap= 'b,s,<,>,[,]'

-- Stop certain movements from always going to the first character of a line.
-- While this behaviour deviates from that of Vi, it does what most users
-- coming from other editors would expect.
opt.startofline = false

-- More natural split directions
opt.splitbelow = true
opt.splitright = true

-- Instead of failing a command because of unsaved changes, instead raise a
-- dialogue asking if you wish to save changed files.
opt.confirm = true

-- Use visual bell instead of beeping when doing something wrong
opt.visualbell = true

-- And reset the terminal code for the visual bell. If visualbell is set, and
-- this line is also included, vim will neither flash nor beep. If visualbell
-- is unset, this does nothing.
cmd [[ set t_vb= ]]

-- Enable use of the mouse for all modes
-- Hold shift to disable for copy/paste
cmd [[
  if has('mouse')
    set mouse=a
  endif
]]

-- Set the command window height to 2 lines, to avoid many cases of having to
-- 'press <Enter> to continue'
-- opt.cmdheight = 2

-- Quickly time out on keycodes, but never time out on mappings
-- set notimeout ttimeout ttimeoutlen=200
opt.timeout = false
opt.ttimeout = true
opt.ttimeoutlen = 200

-- Set timeout before CursorHold,CursorHoldI
-- Note: A very low value may slow Vim down, as some CursorHold commands may be
-- comparatively expensive. It's also used for writing the swap file.
opt.updatetime = 500

-- Vim with default settings does not allow easy switching between multiple files
-- in the same editor window. Users can use multiple split windows or multiple
-- tab pages to edit multiple files, but it is still best to enable an option to
-- allow easier switching between files.
--
-- One such option is the 'hidden' option, which allows you to re-use the same
-- window and switch from an unsaved buffer without saving it first. Also allows
-- you to keep an undo history for multiple files when re-using the same window
-- in this way. Note that using persistent undo also lets you undo in multiple
-- files even in the same window, but is less efficient and is actually designed
-- for keeping undo history after closing Vim entirely. Vim will complain if you
-- try to quit without saving, and swap files will keep you safe if your computer
-- crashes.
-- opt.hidden = true

-- Note that not everyone likes working this way (with the hidden option).
-- Alternatives include using tabs or split windows instead of re-using the same
-- window as mentioned above, and/or either of the following options:
-- opt.confirm = true
-- opt.autowriteall = true

--}}}
---------------------------------------------------------------------------------
-- vim:foldmethod=marker
