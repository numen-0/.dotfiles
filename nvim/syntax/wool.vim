" Usage:
" put this file into your vim/nvim config home in the syntax dir:
"   e.g.:   ~/.vim/syntax/wool.vim  ~/.config/nvim/syntax/wool.vim
" [vim]: add to your .vimrc:
" autocmd BufRead,BufNewFile *.porth set filetype=porth
" [nvim]: add to your init.lua:
" vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
"     group = vim.api.nvim_create_augroup('Woolft', { clear = true }),
"     desc = 'Set filetype for wool files',
"     pattern = { '*.wool' },
"     callback = function()
"         vim.cmd('set filetype=wool')
"     end,
" })

if exists("b:current_syntax")
  finish
endif

" keywords
syn case ignore
syn keyword sheepKeyword nop mov cmp eq ne lt gt ge le band bor bxor not
            \ land lor lxor inc dec add sub mul div mod shl shr rol ror jnz
            \ jz jns js jmp vmcall exit
syn case match

" normal
syn match sheepNormal /[a-zA-Z_][a-zA-Z_0-9]*/

" comment tags
" syntax keyword sheepTodos contained TODO XXX FIXME NOTE HACK

" comments
syntax region sheepComment start=";" end="$"   contains=sheepTodos

" labels
syn match sheepLabel /[a-zA-Z_][a-zA-Z_0-9]*:/

" escape literals: \n, \r, \\, \', \0
syntax match sheepEscapes display contained "\\[0nr\']"

" char literals
syntax region sheepChar start=/'/ skip=/\\\./ end=/'/ contains=sheepEscapes

" number literals
syn match sheepNumber /[0-9]\+/
syn match sheepNumber /0x[0-9a-fA-F]\+/
syn match sheepNumber /0o[0-7]\+/
syn match sheepNumber /0b[01]\+/

" modifiers
syn match sheepReference /&/
syn match sheepPointer   /\^/

" Set highlights
highlight default link sheepChar        Character
highlight default link sheepComment     Comment
highlight default link sheepEscapes     SpecialChar
highlight default link sheepKeyword     Keyword
highlight default link sheepLabel       Label
highlight default link sheepNormal      Normal
highlight default link sheepNumber      Number
highlight default link sheepPointer     Constant
highlight default link sheepReference   Constant
highlight default link sheepTodos       Todo

let b:current_syntax = "sheep"

