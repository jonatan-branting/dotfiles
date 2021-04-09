syntax enable
set termguicolors
let g:gruvbox_italic = 1
let g:gruvbox_underline = 1
let g:gruvbox_bold = 0
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_italicize_comments = 1
set bg=dark
colorscheme gruvbox

" Fix challenger_deep color scheme
" hi Normal guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE  ctermbg=NONE
hi LineNr guibg=NONE  ctermbg=NONE
hi pythonString gui=italic guifg=#ffe9aa
" hi CursorLineNr guifg=#565575 guibg=None gui=NONE
" hi Pmenu guibg=#363555
"
" StatusLine
" hi StatusLine guibg=#363555 guifg=#ffffff
" hi StatusLineNC guibg=#363555 guifg=#aaaaaa

hi stlPathInfo guibg=#363555 guifg=#999999 gui=bold
hi stlColumnInfo guibg=#4a4b6a guifg=#8685a5
hi stlColumnInfo guibg=#a89984 guifg=#504945
hi stlFileFlags guibg=#363555 guifg=#999999
hi stlFileFlags guibg=#504945 guifg=fg
hi stlErrorInfo guifg=#df1010 guibg=#363555
hi stlWarningInfo guifg=#ffa500 guibg=#363555

hi DiagnosticWarning guibg=#363555 guifg=#ffa500
hi DiagnosticError guibg=#363555 guifg=#ff3333

" hi VertSplit ctermbg=NONE guibg=None guifg=#363555
" hi VertSplit ctermbg=NONE guibg=None guifg=#bdae93

" Minimalistic bufTabLine
hi BufTabLineFill ctermbg=NONE guibg=None
hi BufTabLineActive ctermbg=NONE guibg=None gui=italic
hi BufTabLineCurrent ctermbg=NONE guibg=None gui=bold
hi BufTabLineHidden ctermbg=NONE guibg=None

" Fix CocList highlighting
" hi CursorLine guibg=#4a4b6a
hi PreviewBg guibg=#282a36
hi PreviewBg guibg=#1f1f1f

hi ALEErrorSign gui=NONE guibg=red guifg=NONE
hi ALEVirtualTextWarning guifg=grey guibg=NONE gui=italic
hi ALEVirtualTextError guifg=grey guibg=NONE gui=italic
hi ALEError guibg=red gui=NONE
hi ALEWarningSign gui=NONE guibg=orange guifg=NONE
hi ALEWarning guibg=NONE gui=NONE

hi ALEWarning gui=underline
hi ALEError gui=underline

hi ALESignColumnWithoutErrors guibg=NONE
hi SignColumn guibg=NONE
hi ALESignColumnWithErrors guibg=NONE

