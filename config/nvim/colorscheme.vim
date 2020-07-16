syntax enable
set termguicolors
colorscheme challenger_deep

" Fix challenger_deep color scheme
hi Normal guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE  ctermbg=NONE
hi LineNr guibg=NONE  ctermbg=NONE
hi pythonString gui=italic guifg=#ffe9aa
hi CursorLineNr guifg=#565575 guibg=None gui=NONE
hi Pmenu guibg=#363555

" StatusLine
hi StatusLine guibg=#363555 guifg=#ffffff
hi StatusLineNC guibg=#363555 guifg=#aaaaaa

hi stlPathInfo guibg=#363555 guifg=#999999 gui=bold
hi stlColumnInfo guibg=#4a4b6a guifg=#8685a5
hi stlFileFlags guibg=#363555 guifg=#999999
hi stlErrorInfo guifg=#df1010 guibg=#363555
hi stlWarningInfo guifg=#ffa500 guibg=#363555

hi DiagnosticWarning guibg=#363555 guifg=#ffa500
hi DiagnosticError guibg=#363555 guifg=#ff3333

hi VertSplit ctermbg=NONE guibg=None guifg=#363555

" Minimalistic bufTabLine
hi BufTabLineFill ctermbg=NONE guibg=None
hi BufTabLineActive ctermbg=NONE guibg=None gui=italic
hi BufTabLineCurrent ctermbg=NONE guibg=None gui=bold
hi BufTabLineHidden ctermbg=NONE guibg=None

" Fix CocList highlighting
hi CursorLine guibg=#4a4b6a

