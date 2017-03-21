if version > 580
    highlight clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name = "prodigy"
set background=dark

" Colors: {{{
let s:prodigy = {}

let s:prodigy.grey = '#737373'
" }}}

function! s:hl(group, gui, fg, bg)
    execute "hi " . a:group . " gui=" . a:gui . " guifg=" . a:fg . " guibg=" . a:bg
endfunction

call s:hl("Comment", "italic", s:prodigy.grey, "NONE")
call s:hl("CursorLineNr", "NONE", s:prodigy.grey, "NONE")

highlight Boolean          gui=NONE        guifg=#808080   guibg=NONE
highlight ColorColumn      gui=NONE        guifg=NONE      guibg=#1a1a1a
highlight Conceal          gui=NONE        guifg=#808080   guibg=NONE
highlight Conditional      gui=NONE        guifg=#a22f2f   guibg=NONE
highlight Constant         gui=NONE        guifg=#808080   guibg=NONE
highlight Cursor           gui=reverse     guifg=NONE      guibg=NONE
highlight CursorColumn     gui=NONE        guifg=NONE      guibg=#1a1a1a
highlight CursorLine       gui=NONE        guifg=NONE      guibg=#27211b
highlight DiffAdd          gui=NONE        guifg=NONE      guibg=#082608
highlight DiffChange       gui=NONE        guifg=NONE      guibg=#1a1a1a
highlight DiffDelete       gui=NONE        guifg=NONE      guibg=#260808
highlight DiffText         gui=NONE        guifg=NONE      guibg=#333333
highlight Directory        gui=NONE        guifg=#8f8f8f   guibg=NONE
highlight Error            gui=NONE        guifg=NONE      guibg=#260808
highlight ErrorMsg         gui=NONE        guifg=NONE      guibg=#260808
highlight FoldColumn       gui=NONE        guifg=#616161   guibg=NONE
highlight Folded           gui=italic      guifg=#737373   guibg=#27211b
highlight Ignore           gui=NONE        guifg=NONE      guibg=NONE
highlight IncSearch        gui=NONE        guifg=NONE      guibg=#333333
highlight LineNr           gui=NONE        guifg=#616161   guibg=NONE
highlight MatchParen       gui=NONE        guifg=NONE      guibg=#333333
highlight ModeMsg          gui=NONE        guifg=NONE      guibg=NONE
highlight MoreMsg          gui=NONE        guifg=NONE      guibg=NONE
highlight NonText          gui=NONE        guifg=#616161   guibg=NONE
highlight Normal           gui=NONE        guifg=#cac8af   guibg=#110e0e
highlight Number           gui=NONE        guifg=#7f7666   guibg=NONE
highlight Pmenu            gui=NONE        guifg=NONE      guibg=#1a1a1a
highlight PmenuSbar        gui=NONE        guifg=NONE      guibg=#262626
highlight PmenuSel         gui=NONE        guifg=NONE      guibg=#333333
highlight PmenuThumb       gui=NONE        guifg=NONE      guibg=#424242
highlight Question         gui=NONE        guifg=NONE      guibg=NONE
highlight Search           gui=NONE        guifg=NONE      guibg=#262626
highlight SignColumn       gui=NONE        guifg=#616161   guibg=NONE
highlight Special          gui=NONE        guifg=#808080   guibg=NONE
highlight SpecialKey       gui=NONE        guifg=#616161   guibg=NONE
highlight SpellBad         gui=undercurl   guifg=NONE      guibg=#260808
highlight SpellCap         gui=undercurl   guifg=NONE      guibg=NONE
highlight SpellLocal       gui=undercurl   guifg=NONE      guibg=#082608
highlight SpellRare        gui=undercurl   guifg=NONE      guibg=#262626
highlight Statement        gui=NONE        guifg=#ff6347   guibg=NONE
highlight StatusLine       gui=NONE        guifg=#9e9e9e   guibg=#262626
highlight StatusLineNC     gui=NONE        guifg=#737373   guibg=#262626
highlight StorageClass     gui=bold        guifg=#e3e5c8   guibg=NONE
highlight String           gui=NONE        guifg=#795d79   guibg=NONE
highlight TabLine          gui=NONE        guifg=#737373   guibg=#262626
highlight TabLineFill      gui=NONE        guifg=NONE      guibg=#262626
highlight TabLineSel       gui=NONE        guifg=#9e9e9e   guibg=#262626
highlight Title            gui=NONE        guifg=#808080   guibg=NONE
highlight Todo             gui=standout    guifg=NONE      guibg=NONE
highlight Type             gui=NONE        guifg=#9a4f42   guibg=NONE
highlight Underlined       gui=NONE        guifg=NONE      guibg=NONE
highlight VertSplit        gui=NONE        guifg=#333333   guibg=NONE
highlight Visual           gui=NONE        guifg=NONE      guibg=#333333
highlight VisualNOS        gui=NONE        guifg=NONE      guibg=NONE
highlight WarningMsg       gui=NONE        guifg=NONE      guibg=#260808
highlight WildMenu         gui=NONE        guifg=NONE      guibg=#525252
highlight lCursor          gui=NONE        guifg=NONE      guibg=NONE
highlight Identifier       gui=NONE        guifg=NONE      guibg=NONE
highlight PreProc          gui=NONE        guifg=NONE      guibg=NONE
highlight Include          gui=NONE        guifg=#a3483a   guibg=NONE

" Language Specific
" Vim: {{{
highlight vimCommentTitle   gui=bold,italic guifg=#584b4d   guibg=NONE
" }}}
" Python: {{{
highlight pythonDecorator   gui=NONE        guifg=#708c7c   guibg=NONE
highlight pythonAttribute   gui=NONE        guifg=#7f7666   guibg=NONE
" }}}
