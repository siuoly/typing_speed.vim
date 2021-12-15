if exists("g:typing_speed") 
  finish
endif
let g:typing_speed = 1

let s:input_count = 0.0
" fix the bug about " count - / (localtime()-localtime())" is inf 
let s:start_time = localtime()-1


function! s:Add_count()
  let s:input_count += 1
endfunction

function! GetCount_per_min()
  let s:pass_time = localtime() - s:start_time
  return printf('%5.1f', s:input_count * 60 / s:pass_time )
endfunction

augroup typing_speed
  au!
  auto InsertCharPre * call s:Add_count()
augroup END


" save your own statusline setting
if !exists("s:localstl")
  let s:localstl = &stl
endif

let &stl = s:localstl . " %{GetCount_per_min()}c/m"
