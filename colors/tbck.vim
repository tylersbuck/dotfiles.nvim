" tbck.vim

" Vim colorscheme based on Monokai Pro (Spectrum filter)
"
" Requires a 256 color terminal and if using term colors, requires extended
" colors 16-20 defined to fill out a spectrum of shades similar to the base.
" See the color dictionaries defined in 'Setup & initializtion' for details
" on which color number each shade should be assigned.
"
" Use :highlight to see current highlights
" Use :help <group-name> for more info on a particular highlighting group

"===============================================================================
" Setup & initialization {{{1

" Colorscheme name
let g:colors_name = "tbck"

" Define color dictionaries for GUI and cterm
" Higher numbers = further from base, higher constrast.
" e.g. black2 is blackest black, white2 is whitest white, and gray5 is the gray
" with the highest contrast to base.
let s:gui = {
      \ "black2": "#131313",
      \ "black1": "#191919",
      \ "black0": "#1d1d1d",
      \ "base": "#222222",
      \ "gray0": "#2d2c2d",
      \ "gray1": "#363537",
      \ "gray2": "#4b494c",
      \ "gray3": "#525053",
      \ "gray4": "#69676c",
      \ "gray5": "#8b888f",
      \ "white2": "#f7f1ff",
      \ "white1": "#bab6c0",
      \ "red": "#fc618d",
      \ "green": "#7bd88f",
      \ "yellow": "#fce566",
      \ "orange": "#fd9353",
      \ "magenta": "#948ae3",
      \ "cyan": "#5ad4e6"}
let s:cterm = {
      \ "black2": "16",
      \ "black1": "17",
      \ "black0": "18",
      \ "base": "19",
      \ "gray0": "20",
      \ "gray1": "0",
      \ "gray2": "21",
      \ "gray3": "22",
      \ "gray4": "8",
      \ "gray5": "23",
      \ "white2": "15",
      \ "white1": "7",
      \ "red": "1",
      \ "green": "2",
      \ "yellow": "3",
      \ "orange": "4",
      \ "magenta": "5",
      \ "cyan": "6"}

" Highlighting function
" Allows for easier use of the color dictionaries when defining highlights.
function Hi(group, guifg, guibg, ctermfg, ctermbg, attr, guisp)
  if a:guifg != ""
    exec "highlight " . a:group . " guifg=" . a:guifg
  endif
  if a:guibg != ""
    exec "highlight " . a:group . " guibg=" . a:guibg
  endif
  if a:ctermfg != ""
    exec "highlight " . a:group . " ctermfg=" . a:ctermfg
  endif
  if a:ctermbg != ""
    exec "highlight " . a:group . " ctermbg=" . a:ctermbg
  endif
  if a:attr != ""
    exec "highlight " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif
  if a:guisp != ""
    exec "highlight " . a:group . " guisp=" . a:guisp
  endif
endfun

" Should be set before highlight statements
set background=dark

" Standard colorscheme init boilerplate
" Remove all existing highlighting and set the defaults
highlight clear
" Load the syntax highlighting defaults, if it's enabled
if exists("syntax_on")
  syntax reset
endif

"}}}
"===============================================================================
" Highlighting settings  {{{1

"-------------------------------------------------------------------------------
" Syntax highlighting {{{2

" Standard syntax {{{3

" String          Constant
" Character       Constant
" Number          Constant
" Boolean         Constant
" Float           Number
" Function        Identifier
" Conditional     Statement
" Repeat          Statement
" Label           Statement
" Operator        Statement
" Keyword         Statement
" Exception       Statement
" Include         PreProc
" Define          PreProc
" Macro           PreProc
" PreCondit       PreProc
" StorageClass    Type
" Structure       Type
" Typedef         Type
" Tag             Special
" SpecialChar     Special
" Delimiter       Special
" SpecialComment  Special
" Debug           Special

" Normal should be the first highlight defined and must not use reverse,
" fg, or bg.
call Hi("Normal", s:gui["white2"], "", s:cterm["white2"], "", "", "")

call Hi("Constant", s:gui["magenta"], "", s:cterm["magenta"], "", "none", "")
call Hi("Identifier", s:gui["orange"], "", s:cterm["orange"], "", "none", "")
call Hi("PreProc", s:gui["magenta"], "", s:cterm["magenta"], "", "none", "")
call Hi("Special", s:gui["magenta"], "", s:cterm["magenta"], "", "none", "")
call Hi("Statement", s:gui["red"], "", s:cterm["red"], "", "none", "")
call Hi("Type", s:gui["cyan"], "", s:cterm["cyan"], "", "none", "")

call Hi("Boolean", s:gui["magenta"], "", s:cterm["magenta"], "", "none", "")
call Hi("Character", s:gui["yellow"], "", s:cterm["yellow"], "", "none", "")
call Hi("Conditional", s:gui["red"], "", s:cterm["red"], "", "none", "")
call Hi("Debug", s:gui["yellow"], "", s:cterm["yellow"], "", "none", "")
call Hi("Define", s:gui["magenta"], "", s:cterm["magenta"], "", "none", "")
call Hi("Delimiter", s:gui["gray5"], "", s:cterm["gray5"], "", "none", "")
call Hi("Exception", s:gui["red"], "", s:cterm["red"], "", "none", "")
call Hi("Float", s:gui["magenta"], "", s:cterm["magenta"], "", "none", "")
call Hi("Function", s:gui["green"], "", s:cterm["green"], "", "none", "")
call Hi("Include", s:gui["magenta"], "", s:cterm["magenta"], "", "none", "")
call Hi("Keyword", s:gui["red"], "", s:cterm["red"], "", "none", "")
call Hi("Label", s:gui["orange"], "", s:cterm["orange"], "", "none", "")
call Hi("Macro", s:gui["cyan"], "", s:cterm["cyan"], "", "none", "")
call Hi("Number", s:gui["magenta"], "", s:cterm["magenta"], "", "none", "")
call Hi("Operator", s:gui["red"], "", s:cterm["red"], "", "none", "")
call Hi("PreCondit", s:gui["cyan"], "", s:cterm["cyan"], "", "none", "")
call Hi("Repeat", s:gui["red"], "", s:cterm["red"], "", "none", "")
call Hi("SpecialChar", s:gui["yellow"], "", s:cterm["yellow"], "", "none", "")
call Hi("SpecialComment", s:gui["yellow"], "", s:cterm["yellow"], "", "none", "")
call Hi("StorageClass", s:gui["cyan"], "", s:cterm["cyan"], "", "none", "")
call Hi("String", s:gui["yellow"], "", s:cterm["yellow"], "", "none", "")
call Hi("Structure", s:gui["red"], "", s:cterm["red"], "", "none", "")
call Hi("Tag", s:gui["green"], "", s:cterm["green"], "", "none", "")
call Hi("Typedef", s:gui["orange"], "", s:cterm["orange"], "", "none", "")

"}}}
" Treesitter {{{3

"call s:hi('TSInclude',          s:cyan,   '',       '',          '')
"call s:hi('TSPunctBracket',     s:cyan,   '',       '',          '')
"call s:hi('TSPunctDelimiter',   s:base07, '',       '',          '')
"call s:hi('TSParameter',        s:base07, '',       '',          '')
"call s:hi('TSType',             s:blue,   '',       '',          '')
"call s:hi('TSFunction',         s:cyan,   '',       '',          '')

"call s:hi('TSTagDelimiter',     s:cyan,   '',       '',          '')
"call s:hi('TSProperty',         s:yellow, '',       '',          '')
"call s:hi('TSMethod',           s:blue,   '',       '',          '')
"call s:hi('TSParameter',        s:yellow, '',       '',          '')
"call s:hi('TSConstructor',      s:base07, '',       '',          '')
"call s:hi('TSVariable',         s:base07, '',       '',          '')
"call s:hi('TSOperator',         s:base07, '',       '',          '')
"call s:hi('TSTag',              s:base07, '',       '',          '')
"call s:hi('TSKeyword',          s:purple, '',       '',          '')
"call s:hi('TSKeywordOperator',  s:purple, '',       '',          '')
"call s:hi('TSVariableBuiltin',  s:red,    '',       '',          '')
"call s:hi('TSLabel',            s:cyan,   '',       '',          '')

" nvim-treesitter
"   TSNone {},
"   TSError {base.Error},
"   TSTitle {base.Title},
"   TSLiteral {base.String},
"   TSURI {base.Underlined},
"   TSVariable {base.GruvboxFg1},
"   TSPunctDelimiter {base.Delimiter},
"   TSPunctBracket {base.Delimiter},
"   TSPunctSpecial {base.Delimiter},
"   TSConstant {base.Constant},
"   TSConstBuiltin {base.Special},
"   TSConstMacro {base.Define},
"   TSString {base.String},
"   TSStringRegex {base.String},
"   TSStringEscape {base.SpecialChar},
"   TSCharacter {base.Character},
"   TSNumber {base.Number},
"   TSBoolean {base.Boolean},
"   TSFloat {base.Float},
"   TSFunction {base.Function},
"   TSFuncBuiltin {base.Special},
"   TSFuncMacro {base.Macro},
"   TSParameter {base.Identifier},
"   TSParameterReference {TSParameter},
"   TSMethod {base.Function},
"   TSField {base.Identifier},
"   TSProperty {base.Identifier},
"   TSConstructor {base.Special},
"   TSAnnotation {base.PreProc},
"   TSAttribute {base.PreProc},
"   TSNamespace {base.Include},
"   TSConditional {base.Conditional},
"   TSRepeat {base.Repeat},
"   TSLabel {base.Label},
"   TSOperator {base.Operator},
"   TSKeyword {base.Keyword},
"   TSKeywordFunction {base.Keyword},
"   TSKeywordOperator {TSOperator},
"   TSException {base.Exception},
"   TSType {base.Type},
"   TSTypeBuiltin {base.Type},
"   TSInclude {base.Include},
"   TSVariableBuiltin {base.Special},
"   TSText {TSNone},
"   TSStrong {gui = styles.bold},
"   TSEmphasis {gui = styles.italic_strings},
"   TSUnderline {gui = styles.underline},
"   TSComment {base.Comment},
"   TSStructure {base.GruvboxOrange},
"   TSTag {base.GruvboxOrange},
"   TSTagDelimiter {base.GruvboxGreen},

highlight link TSFuncBuiltin Function

"}}}
" Vim syntax {{{3

" By default this is cleared and appears Normal
highlight link vimFunction Function

" Make comment 'titles' appear as normal comments
" Titles are uppercase letters with a colon at the start of a comment
" e.g. `TITLE:`
highlight link vimCommentTitle Comment

" Highlight 'clear' and 'link' keywords
" highlight link vimHiClear Function
" highlight link vimHiLink Function

" Highlight attributes
highlight link vimHiTerm Normal

" Highlight attribute values
highlight link vimHiAttrib Constant

"}}}
" Lua syntax {{{3

highlight link luaFunc Function
highlight link luaTable Delimiter
"highlight link luaBraceError Error
"highlight link luaParenError Error

" BetterLua
highlight link luaBuiltin Function
highlight link luaVarComma Delimiter
highlight link luaBrace Delimiter
highlight link luaBracket Delimiter
highlight link luaBrackets luaBracket
highlight link luaAttributeBrackets luaBracket
highlight link luaParen Delimiter
highlight link luaParens luaParen

" Treesitter lua
highlight link luaTSConstructor Delimiter
highlight link luaTSProperty Normal
highlight link luaTSField Normal

"}}}
" Yaml syntax {{{3

" Treesitter yaml
highlight link yamlTSField Structure

"}}}

"}}}
"-------------------------------------------------------------------------------
" Interface & other highlighting {{{2

" Other {{{3

call Hi("Comment", s:gui["gray4"], "", s:cterm["gray4"], "", "", "")
call Hi("Ignore", s:gui["black2"], "", s:cterm["black2"], "", "", "")
call Hi("Underlined", s:gui["cyan"], "", s:cterm["cyan"], "", "underline", "")
call Hi("Italic", "", "", "", "", "none", "")
call Hi("Todo", s:gui["gray4"], "none", s:cterm["gray4"], "none", "", "")
" highlight TooLong
" highlight Substitute

call Hi("Error", s:gui["red"], s:gui["black2"], s:cterm["red"], s:cterm["black2"], "reverse", "")
call Hi("QuickFixLine", "", s:gui["black2"], "", s:cterm["black2"], "none", "")

" Special characters
call Hi("SpecialKey", s:gui["gray5"], "", s:cterm["gray5"], "", "", "")
call Hi("NonText", s:gui["gray1"], "", s:cterm["gray1"], "", "", "")
call Hi("Conceal", s:gui["white1"], s:gui["gray4"], s:cterm["white1"], s:cterm["gray4"], "", "")
call Hi("MatchParen", "", s:gui["gray2"], "", s:cterm["gray2"], "", "")

" Spelling
call Hi("SpellBad", "", "", "", "", "undercurl", s:gui["red"])
call Hi("SpellCap", "", "", "", "", "undercurl", s:gui["orange"])
call Hi("SpellRare", "", "", "", "", "undercurl", s:gui["magenta"])
call Hi("SpellLocal", "", "", "", "", "undercurl", s:gui["cyan"])

" Search
call Hi("Search", s:gui["yellow"], s:gui["black2"], s:cterm["yellow"], s:cterm["black2"], "", "")
call Hi("IncSearch", s:gui["orange"], s:gui["black2"], s:cterm["orange"], s:cterm["black2"], "", "")

" Diffs
call Hi("DiffAdd", s:gui["green"], s:gui["gray1"], s:cterm["green"], s:cterm["gray1"], "", "")
call Hi("DiffChange", s:gui["yellow"], s:gui["gray1"], s:cterm["yellow"], s:cterm["gray1"], "", s:gui["yellow"])
call Hi("DiffDelete", s:gui["red"], s:gui["gray1"], s:cterm["red"], s:cterm["gray1"], "", "")
call Hi("DiffText", s:gui["orange"], s:gui["gray1"], s:cterm["orange"], s:cterm["gray1"], "", s:gui["orange"])

" Other
call Hi("RedrawDebugClear", "", s:gui["yellow"], "", s:cterm["yellow"], "", "")
call Hi("RedrawDebugComposed", "", s:gui["green"], "", s:cterm["green"], "", "")
call Hi("RedrawDebugRecompose", "", s:gui["red"], "", s:cterm["red"], "", "")

"}}}
" Interface {{{3

" Line numbers and cursor
call Hi("LineNr", s:gui["gray1"], "", s:cterm["gray1"], "", "none", "")
call Hi("CursorLineNr", s:gui["gray2"], "", s:cterm["gray2"], "", "none", "")
call Hi("CursorColumn", "", "none", "", "none", "none", "")
call Hi("CursorLine", "", s:gui["gray0"], "", s:cterm["gray0"], "none", "")
call Hi("Cursor", "", "", "", "", "reverse", "")
call Hi("TermCursor", "", "", "", "", "reverse", "")
highlight link TermCursor Cursor
highlight link lCursor Cursor

" Status line
call Hi("StatusLine", s:gui["gray4"], s:gui["black1"], s:cterm["gray4"], s:cterm["black1"], "none", "")
call Hi("StatusLineNC", s:gui["black1"], "", s:cterm["black1"], "", "strikethrough", "")
" call Hi("StatusLineNC", s:gui["black1"], "", s:cterm["black1"], "", "underline", "")
call Hi("StatusLineTerm", s:gui["gray4"], s:gui["black1"], s:cterm["gray4"], s:cterm["black1"], "none", "")
call Hi("StatusLineTermNC", s:gui["gray4"], s:gui["black1"], s:cterm["gray4"], s:cterm["black1"], "none", "")

" Invert selected lines in visual mode
call Hi("Visual", "none", s:gui["gray0"], "none", s:cterm["gray0"], "none", "")
call Hi("VisualNOS", s:gui["gray4"], "", s:cterm["gray4"], "", "", "")

" Command and message area
call Hi("MsgArea", s:gui["gray5"], "", s:cterm["gray5"], "", "", "")

" Messages, questions, and prompts
call Hi("ModeMsg", s:gui["gray3"], "", s:cterm["gray3"], "", "none", "")
call Hi("MoreMsg", s:gui["yellow"], "", s:cterm["yellow"], "", "none", "")
call Hi("WarningMsg", s:gui["red"], "", s:cterm["red"], "", "none", "")
call Hi("ErrorMsg", s:gui["red"], s:gui["black2"], s:cterm["red"], s:cterm["black2"], "reverse", "")
call Hi("Question", s:gui["cyan"], "", s:cterm["cyan"], "", "none", "")
call Hi("Title", s:gui["magenta"], "", s:cterm["magenta"], "", "", "")

" Completion, and other navigation functionality
call Hi("WildMenu", s:gui["yellow"], s:gui["black2"], s:cterm["yellow"], s:cterm["black2"], "", "")
call Hi("Directory", s:gui["orange"], "", s:cterm["orange"], "", "", "")

" Popup menu
call Hi("Pmenu", s:gui["gray5"], s:gui["black0"], s:cterm["gray5"], s:cterm["black0"], "", "")
call Hi("PmenuSbar", "", s:gui["gray1"], "", s:cterm["gray1"], "", "")
call Hi("PmenuSel", s:gui["yellow"], s:gui["gray0"], s:cterm["yellow"], s:cterm["gray0"], "", "")
call Hi("PmenuThumb", "", s:gui["black1"], "", s:cterm["black1"], "", "")

" Tab line
call Hi("TabLine", s:gui["gray1"], s:gui["white1"], s:cterm["gray1"], s:cterm["white1"], "underline", "")
call Hi("TabLineSel", "", "", "", "", "underline", "")
call Hi("TabLineFill", "", "", "", "", "reverse", "")

call Hi("VertSplit", s:gui["black1"], "", s:cterm["black1"], "", "none", "")

" Columns
call Hi("ColorColumn", "", s:gui["orange"], "", s:cterm["orange"], "", "")
call Hi("SignColumn", s:gui["white1"], s:gui["base"], s:cterm["white1"], s:cterm["base"], "", "")

" Folds
call Hi("Folded", s:gui["gray4"], s:gui["black0"], s:cterm["gray4"], s:cterm["black0"], "", "")
call Hi("FoldColumn", s:gui["gray5"], s:gui["gray0"], s:cterm["gray5"], s:cterm["gray0"], "", "")

"}}}
" Terminal {{{3

if has("termguicolors") && &termguicolors
  if has("nvim")
    " Neovim terminal colours
    let g:terminal_color_0 = s:gui["gray1"]
    let g:terminal_color_1 = s:gui["red"]
    let g:terminal_color_2 = s:gui["green"]
    let g:terminal_color_3 = s:gui["yellow"]
    let g:terminal_color_4 = s:gui["orange"]
    let g:terminal_color_5 = s:gui["magenta"]
    let g:terminal_color_6 = s:gui["cyan"]
    let g:terminal_color_7 = s:gui["white1"]
    let g:terminal_color_8 = s:gui["gray4"]
    let g:terminal_color_9 = s:gui["red"]
    let g:terminal_color_10 = s:gui["green"]
    let g:terminal_color_11 = s:gui["yellow"]
    let g:terminal_color_12 = s:gui["orange"]
    let g:terminal_color_13 = s:gui["magenta"]
    let g:terminal_color_14 = s:gui["cyan"]
    let g:terminal_color_15 = s:gui["white2"]
    let g:terminal_color_background = s:gui["base"]
    let g:terminal_color_foreground = s:gui["white2"]
  elseif has("terminal")
    " Vim terminal colours
    let g:terminal_ansi_colors = [
          \ s:gui["gray1"],
          \ s:gui["red"],
          \ s:gui["green"],
          \ s:gui["yellow"],
          \ s:gui["orange"],
          \ s:gui["magenta"],
          \ s:gui["cyan"],
          \ s:gui["white1"],
          \ s:gui["gray4"],
          \ s:gui["red"],
          \ s:gui["green"],
          \ s:gui["yellow"],
          \ s:gui["orange"],
          \ s:gui["magenta"],
          \ s:gui["cyan"],
          \ s:gui["white2"],
          \ ]
  endif
endif

"}}}
" Nvim {{{3

call Hi("NvimInternalError", s:gui["red"], s:gui["red"], s:cterm["red"], s:cterm["red"], "", "")

"}}}
" LSP {{{3

let s:hintcolor = "magenta"
let s:infocolor = "cyan"
let s:warncolor = "orange"
let s:errorcolor = "red"

call Hi("LspDiagnosticsDefaultHint", s:gui["magenta"], "", s:cterm["magenta"], "", "", "")
call Hi("LspDiagnosticsDefaultInformation", s:gui["cyan"], "", s:cterm["cyan"], "", "", "")
call Hi("LspDiagnosticsDefaultWarning", s:gui[s:warncolor], "", s:cterm[s:warncolor], "", "", "")
call Hi("LspDiagnosticsDefaultError", s:gui["red"], "", s:cterm["red"], "", "", "")

call Hi("LspDiagnosticsUnderlineHint", "", "", "", "", "undercurl", s:gui["magenta"])
call Hi("LspDiagnosticsUnderlineInformation", "", "", "", "", "undercurl", s:gui["cyan"])
call Hi("LspDiagnosticsUnderlineWarning", "", "", "", "", "undercurl", s:gui[s:warncolor])
call Hi("LspDiagnosticsUnderlineError", "", "", "", "", "undercurl", s:gui["red"])

highlight link LspDiagnosticsVirtualTextHint LspDiagnosticsDefaultHint
highlight link LspDiagnosticsVirtualTextInformation LspDiagnosticsDefaultInformation
highlight link LspDiagnosticsVirtualTextWarning LspDiagnosticsDefaultWarning
highlight link LspDiagnosticsVirtualTextError LspDiagnosticsDefaultError

"highlight link LspReferenceText CursorLine
call Hi("LspReferenceText", "", s:gui["gray2"], "", s:cterm["gray2"], "", "")
highlight link LspReferenceWrite LspReferenceText
highlight link LspReferenceRead LspReferenceText

unlet s:hintcolor s:infocolor s:warncolor s:errorcolor

"}}}
" indent-blankline {{{3

" Links to Whitespace by default, which links to NonText
" call Hi('IndentBlanklineChar', '', '', '', '', '', '')
" IndentBlanklineChar cterm=nocombine ctermfg=0 gui=nocombine guifg=#363537
" IndentBlanklineContextChar cterm=nocombine ctermfg=4 gui=nocombine guifg=#fd9353
" IndentBlanklineSpaceChar cterm=nocombine ctermfg=0 gui=nocombine guifg=#363537
" IndentBlanklineSpaceCharBlankline cterm=nocombine ctermfg=0 gui=nocombine guifg=#363537

"}}}
" Telescope {{{3

call Hi("TelescopeBorder", s:gui["gray5"], "", s:cterm["gray5"], "", "", "")
call Hi("TelescopePromptPrefix", s:gui["cyan"], "", s:cterm["cyan"], "", "", "")
call Hi("TelescopeSelection", "", s:gui["gray2"], "", s:cterm["gray2"], "", "")
call Hi("TelescopeSelectionCaret", s:gui["yellow"], s:gui["gray2"], s:cterm["yellow"], s:cterm["gray2"], "", "")
call Hi("TelescopeMatching", "", "", "", "", "undercurl", s:gui["magenta"])

"}}}
" Compe {{{3

" Documentation window highlight groups
"highlight link CompeDocumentation NormalFloat
"highlight link CompeDocumentationBorder CompeDocumentation

"}}}
" Clever-f {{{3

call Hi("CleverFDefaultLabel", "", "", "", "", "underline", "")

"}}}
" Lightspeed {{{3

" Minimal scheme
" Shortcuts, overlaps, etc are made to look like normal labels.
" Less visual movement, but removes shortcut functionality.

call Hi("LightspeedGreyWash", s:gui["gray4"], "", s:cterm["gray4"], "", "", "")
call Hi("LightspeedCursor", s:gui["black2"], s:gui["white1"], s:cterm["black2"], s:cterm["white1"], "", "")

call Hi("LightspeedLabel", s:gui["red"], "", s:cterm["red"], "", "underline", "")
call Hi("LightspeedLabelOverlapped", s:gui["red"], "", s:cterm["red"], "", "underline", "")
call Hi("LightspeedLabelDistant", s:gui["cyan"], "", s:cterm["cyan"], "", "underline", "")
call Hi("LightspeedLabelDistantOverlapped", s:gui["cyan"], "", s:cterm["cyan"], "", "underline", "")
call Hi("LightspeedShortcut", s:gui["red"], "", s:cterm["red"], "", "underline", "")
call Hi("LightspeedOneCharMatch", "", "", "", "", "underline", "")
call Hi("LightspeedMaskedChar", s:gui["gray4"], "", s:cterm["gray4"], "", "underline", "")
call Hi("LightspeedUnlabeledMatch", s:gui["gray4"], "", s:cterm["gray4"], "", "underline", "")
call Hi("LightspeedPendingOpArea", s:gui["red"], "", s:cterm["red"], "", "strikethrough", "")
call Hi("LightspeedPendingChangeOpArea", s:gui["orange"], "", s:cterm["orange"], "", "strikethrough", "")

"}}}
" Gitsigns {{{3

call Hi("GitSignsAdd", s:gui["green"], "", s:cterm["green"], "", "", "")
call Hi("GitSignsDelete", s:gui["red"], "", s:cterm["red"], "", "", "")
call Hi("GitSignsChange", s:gui["orange"], "", s:cterm["orange"], "", "", "")


"}}}

"}}}
"-------------------------------------------------------------------------------

"}}}
"===============================================================================
" Cleanup {{{1

" Remove functions
delfunction Hi

" Remove color dictionaries
unlet s:gui s:cterm

"}}}
"===============================================================================
" vim:foldmethod=marker
