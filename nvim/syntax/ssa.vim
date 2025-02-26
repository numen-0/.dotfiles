
if exists("b:current_syntax")
  finish
endif

" keywords
syn keyword ssaKeyword function data type

" instructions
syn keyword ssaInstruction
            \ add and div mul neg or rem sar shl shr sub udiv urem xor
            \
            \ alloc16 alloc4 alloc8 blit loadd loadl loads loadsb loadsh
            \ loadsw loadub loaduh loaduw loadw storeb stored storeh storel
            \ stores storew
            \
            \ ceqd ceql ceqs ceqw cged cges cgtd cgts cled cles cltd clts
            \ cned cnel cnes cnew cod cos csgel csgew csgtl csgtw cslel cslew
            \ csltl csltw cugel cugew cugtl cugtw culel culew cultl cultw
            \
            \ cuod cuos dtosi dtoui exts extsb extsh extsw extub extuh extuw
            \ sltof ultof stosi stoui swtof uwtof truncd
            \
            \ cast copy
            \
            \ call
            \
            \ vastart vaarg
            \
            \ phi
            \
            \ hlt jmp jnz ret

" normal
syn match ssaNormal /[a-zA-Z_][a-zA-Z_0-9]*/

" comment tags
" syntax keyword ssaTodos contained TODO XXX FIXME NOTE HACK

" comments
syntax region ssaComment start="#" end="$"   contains=ssaTodos

" escape literals: \n, \r, \\, \', \0
syntax match ssaEscapes display contained "\\[0nr\']"

" char literals
syntax region ssaString start=/"/ skip=/\\\./ end=/"/ contains=ssaEscapes

" number literals
syn match ssaNumber /-\?[0-9]\+/

" sigils
syn keyword ssaType           w l s d b h
syn match   ssaLabel          /@[.a-zA-Z_][.a-zA-Z_0-9]*/
syn match   ssaAggregateType  /:[.a-zA-Z_][.a-zA-Z_0-9]*/
syn match   ssaGlobal         /\$[.a-zA-Z_][.a-zA-Z_0-9]*/
syn match   ssaTemp           /%[.a-zA-Z_][.a-zA-Z_0-9]*/

" vaarg
syn match ssaVaarg /[.]\{3}/


" set highlights
highlight default link ssaAggregateType     Type
highlight default link ssaComment           Comment
highlight default link ssaEscapes           SpecialChar
highlight default link ssaGlobal            Constant
highlight default link ssaInstruction       Keyword
highlight default link ssaKeyword           Keyword
highlight default link ssaLabel             Label
highlight default link ssaNormal            Normal
highlight default link ssaNumber            Number
highlight default link ssaString            String
highlight default link ssaTemp              Identifier
highlight default link ssaTodos             Todo
highlight default link ssaType              Type
highlight default link ssaVaarg             Keyword

let b:current_syntax = "ssa"

