set laststatus=2

set statusline=%!statusline#active()
augroup vimrc_statusline
  autocmd!
  " WinLeave = Before we change focused buffer/window
  autocmd WinLeave * if &filetype != "list" | setlocal statusline=%!statusline#inactive()

  " On WinEnter, set statusLine to the active version
  autocmd WinEnter,BufEnter * if &filetype != "list" | setlocal statusline=%!statusline#active()
augroup END

function! statusline#active() abort
  try
    let statuslinetext = ""
    let statuslinetext .= statusline#columninfo(1)
    let statuslinetext .= statusline#fileinfo(1)
    let statuslinetext .= '%='
    let statuslinetext .= statusline#temporary()
    let statuslinetext .= statusline#warnings()
    let statuslinetext .= statusline#errors()
    let statuslinetext .= statusline#gitinfo()

    return statuslinetext
  catch
    echom "catch"
    return ""
  endtry
endfunction

function! statusline#inactive() abort
  try
    let statuslinetext = ""
    let statuslinetext .= statusline#columninfo(0)
    let statuslinetext .= statusline#fileinfo(0)
    let statuslinetext .= '%='
    let statuslinetext .= statusline#temporary()
    let statuslinetext .= statusline#gitinfo()
    return statuslinetext
  catch
    return ""
  endtry
endfunction

function! statusline#columninfo(active) abort
  let text = "%#stlColumnInfo#"
  " let text .= statusline#colpadding()
  "
  let l:num_with = max([&numberwidth, strlen(line('$')) + 1])
  if a:active
    let text .= "%{repeat(' ', max([&numberwidth, strlen(line('$')) + 1]) - strlen(col('.')) + 1) . col('.') . ' '}"
  else
    let text .= "%{'  ' . repeat('-', max([&numberwidth, strlen(line('$')) + 1]) - 1) . ' '}"
  endif
  let text .= '%*'
  return text
endfunction

function! statusline#modified()
  let color = "%#stlFileFlags#"

  let infos = ["%m", "%r", "%w", "%h"]

  return color  . join(infos, "") . "%*"

endfunction

function! statusline#colpadding()
  let l:pad = ""
  while len(l:pad) <= len(line('$')) - len(col('.'))
    let l:pad .= " "
  endwhile
  return l:pad
endfunction

function! statusline#plugins(active) abort
  if exists('g:loaded_obsession')
    return ObsessionStatus()
  endif
endfunction

function! statusline#temporary() abort
  let expr = get(g:, 'stl#tmp', '')
  return !empty(expr) ? eval(expr) . ' ' : ''
endfunction

function! statusline#errors() abort
  if !exists('b:statusline_coc_errors')
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info) | return '' | endif
    let msgs = ['%#stlErrorInfo#']
    if get(info, 'error', 0)
      call add(msgs, '•' . info['error'])
    endif

    let b:statusline_coc_errors = empty(msgs) ? '' : join(msgs, ' ') . ' '
  endif
  return b:statusline_coc_errors
endfunction

function! statusline#warnings() abort
  if !exists('b:statusline_coc_warnings')
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info) | return '' | endif
    let msgs = ['%#stlWarningInfo#']
    if get(info, 'warning', 0)
      call add(msgs, '•' . info['warning'])
    endif
    let b:statusline_coc_warnings = empty(msgs) ? '' : join(msgs, ' ') . ' '
  endif
  return b:statusline_coc_warnings
endfunction

function! statusline#gitinfo() abort
  let l:color = '%#stlColumnInfo# '
  return l:color . "%{((exists('g:loaded_fugitive') && &modifiable) ? fugitive#head() : 'source') . ' '}"
endfunction

function! statusline#fileinfo(active) abort
  let text = ""
  if a:active
    let text .= " ›› "
  else
    let text .= " ‹‹ "
  endif

  let text .= "%f"

  if a:active
    let text .= " ‹‹ "
  else
    let text .= " ›› "
  endif

  let text .= statusline#modified()
  return text
endfunction
