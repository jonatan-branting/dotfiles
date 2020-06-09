" Theme
"
syntax enable
let g:challenger_deep_termcolors = 16
colorscheme challenger_deep

hi Normal guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE  ctermbg=NONE

" Fix challenger_deep color scheme
hi LineNr guibg=NONE  ctermbg=NONE
hi pythonString gui=italic guifg=#ffe9aa
hi CursorLineNr guifg=#565575 guibg=None gui=NONE
hi Pmenu guibg=#363555

hi StatusLine guibg=#363555 guifg=#ffffff 
hi StatusLineNormal guibg=#363555 guifg=#ffffff 
hi PathColor guibg=#363555 guifg=#999999
hi StatusLineNC guibg=NONE guifg=NONE
hi StatusLineNC guibg=#363555 guifg=#ffffff 
hi SA guibg=#363555 guifg=#ffffff
hi SAred guibg=#363555 guifg=#ffffff
hi DiagnosticWarning guibg=#363555 guifg=#ffa500
hi DiagnosticError guibg=#363555 guifg=#ff3333
hi SAline guibg=#4a4b6a guifg=#8685a5
hi VertSplit ctermbg=NONE guibg=None guifg=#363555
hi BufTabLineFill ctermbg=NONE guibg=None
hi BufTabLineActive ctermbg=NONE guibg=None gui=italic
hi BufTabLineCurrent ctermbg=NONE guibg=None gui=bold
hi BufTabLineHidden ctermbg=NONE guibg=None
highlight SignatureMarkText guifg=White ctermfg=White

