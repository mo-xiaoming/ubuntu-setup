" Vim syntax for daScript

if exists("b:current_syntax")
  finish
endif

" keywords
syn keyword hKeywords struct class enum const let def null while if static_if else for elif static_elif recover true false new delete typeinfo type in is as array return break try expect finally options table require operator deref aka typedef with cast override abstract upcast iterator var addr continue where pass reinterpret module public label goto implicit shared private smart_ptr generator yield unsafe assume explicit sealed

" type
syn keyword hKeywords bool void string auto int int2 int3 int4 uint bitfield uint2 uint3 uint4 float float2 float3 float4 range urange block int64 uint64 double function lambda int8 uint8 int16 uint16 tuple variant


" comments
syn match hComment '//.*$'
syn region hBlockComment start='/\*' end='\*/'

" color highlighting
let b:current_syntax = "daScript"

hi Danger ctermfg=218 guifg=#ffafd7

hi def link hComment      Comment
hi def link hBlockComment Comment
hi def link hString       String
hi def link hNum          Constant
hi def link hChar         Constant
hi def link hByte         Constant
hi def link hBytes        Constant
hi def link hKeywords     Keyword
hi def link hAssign       Danger

