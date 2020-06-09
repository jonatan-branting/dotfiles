
function! Modified()
  return &modified ? " +" : ""
endfunction

function! StatuslineGit()
  let line = fugitive#head()
  return strlen(line) > 0 ? line : "source"
endfunction

function! ColPadding()
  let l:pad = ""
  while len(l:pad) <= len(line('$')) - len(col('.')) + 1
    let l:pad .= " " 
  endwhile
  return l:pad
endfunction

function! StatusDiagnosticErrors() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, '·' . info['error'])

  endif
  if empty(msgs)
    return ''
  endif
  return join(msgs, ' '). ' '
  return get(g:, 'coc_status', '')
endfunction

function! StatusDiagnosticWarnings() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'warning', 0)
    call add(msgs, '·' . info['warning'])
  endif
  if empty(msgs)
    return ''
  endif
  return join(msgs, ' '). ' '
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

" Left
set statusline=%#SAline#
set statusline+=%{ColPadding()}
set statusline+=%{col('.')}\ 
set statusline+=%#StatusLineNormal#
set statusline+=\ ››\ 
set statusline+=%f 

" Modified-flag
set statusline+=%{Modified()}
set statusline+=\ ‹‹\ 
set statusline+=%#PathColor#

" Split
set statusline+=%= 

" Right
set statusline+=%#DiagnosticWarning#
set statusline+=%{StatusDiagnosticWarnings()}
set statusline+=\ 
set statusline+=%#DiagnosticError#
set statusline+=%{StatusDiagnosticErrors()}
set statusline+=%#SAline#
set statusline+=\ %{StatuslineGit()}
set statusline+=\ 

set laststatus=2
