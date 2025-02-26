
if exists("b:current_syntax")
  finish
endif

" logo
" syn match todoLogo /^[ *\|\/\\-_]*$/
syn match todoLogo /^[^[\]:]\+$/

" labels + todo box
syn match todoTodo /^\s*\[.\] .*$/
syn match todoLabel /^.*:\s*$/
syn match todoDone /^\s*\[[xX]\] .*$/

" Set highlights
highlight default link todoLabel       Label
highlight default link todoDone        Comment
highlight default link todoTodo        Normal
highlight default link todoLogo        Constant

let b:current_syntax = "todo"

