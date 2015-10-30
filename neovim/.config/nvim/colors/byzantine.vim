set background=dark
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

let g:colors_name = "byzantine"

"hi IncSearch -- no settings --
"hi WildMenu -- no settings --
"hi SignColumn -- no settings --
"hi Title -- no settings --
"hi Folded -- no settings --
"hi TabLineSel -- no settings --
"hi StatusLineNC -- no settings --
"hi CTagsMember -- no settings --
"hi NonText -- no settings --
"hi CTagsGlobalConstant -- no settings --
"hi DiffText -- no settings --
"hi ErrorMsg -- no settings --
"hi Ignore -- no settings --
hi Normal guifg=#fedac4 guibg=#1a0a1a guisp=#1a0a1a gui=NONE ctermfg=223 ctermbg=234 cterm=NONE
"hi CTagsImport -- no settings --
"hi CTagsGlobalVariable -- no settings --
"hi SpellRare -- no settings --
"hi EnumerationValue -- no settings --
"hi Float -- no settings --
hi CursorLine guibg=#3e092e
hi CursorLineNr guifg=#f39a7a
"hi Union -- no settings --
"hi TabLineFill -- no settings --
"hi Question -- no settings --
"hi WarningMsg -- no settings --
"hi VisualNOS -- no settings --
"hi DiffDelete -- no settings --
"hi ModeMsg -- no settings --
"hi CursorColumn -- no settings --
"hi FoldColumn -- no settings --
"hi EnumerationName -- no settings --
"hi Visual -- no settings --
"hi MoreMsg -- no settings --
"hi SpellCap -- no settings --
"hi VertSplit -- no settings --
"hi DiffChange -- no settings --
"hi Cursor -- no settings --
"hi SpellLocal -- no settings --
"hi SpecialKey -- no settings --
"hi DefinedName -- no settings --
"hi MatchParen -- no settings --
"hi LocalVariable -- no settings --
"hi SpellBad -- no settings --
"hi CTagsClass -- no settings --
"hi Underlined -- no settings --
"hi DiffAdd -- no settings --
"hi TabLine -- no settings --
"hi clear -- no settings --
hi SpecialComment guifg=#0000ff guibg=NONE guisp=NONE gui=NONE ctermfg=21 ctermbg=NONE cterm=NONE
hi Typedef guifg=#00c000 guibg=NONE guisp=NONE gui=NONE ctermfg=34 ctermbg=NONE cterm=NONE
hi PreCondit guifg=#fc3e21 guibg=NONE guisp=NONE gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
hi Include guifg=#00ff00 guibg=NONE guisp=NONE gui=NONE ctermfg=10 ctermbg=NONE cterm=NONE
hi Debug guifg=#0000ff guibg=NONE guisp=NONE gui=NONE ctermfg=21 ctermbg=NONE cterm=NONE
hi PMenuSbar guifg=NONE guibg=#848688 guisp=#848688 gui=NONE ctermfg=NONE ctermbg=102 cterm=NONE
hi Identifier guifg=#a5606f guibg=NONE guisp=NONE gui=NONE ctermfg=131 ctermbg=NONE cterm=NONE
hi SpecialChar guifg=#0000ff guibg=NONE guisp=NONE gui=NONE ctermfg=21 ctermbg=NONE cterm=NONE
hi Conditional guifg=#c4262e guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi StorageClass guifg=#e609d7 guibg=NONE guisp=NONE gui=NONE ctermfg=164 ctermbg=NONE cterm=NONE
hi Todo guifg=#fedbc5 guibg=#b5073e guisp=#b5073e gui=NONE ctermfg=223 ctermbg=125 cterm=NONE
hi Special guifg=#c8283d guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi LineNr guifg=#fedbc5 guibg=NONE guisp=NONE gui=NONE ctermfg=223 ctermbg=NONE cterm=NONE
hi StatusLine guifg=#f3a88d guibg=#2f112d guisp=#2f112d gui=NONE ctermfg=216 ctermbg=236 cterm=NONE
hi Label guifg=#00c000 guibg=NONE guisp=NONE gui=NONE ctermfg=34 ctermbg=NONE cterm=NONE
hi PMenuSel guifg=#f3a88d guibg=#2f112d guisp=#2f112d gui=NONE ctermfg=216 ctermbg=236 cterm=NONE
hi Search guifg=#fedbc5 guibg=#b5073e guisp=#b5073e gui=NONE ctermfg=223 ctermbg=125 cterm=NONE
hi Delimiter guifg=#0000ff guibg=NONE guisp=NONE gui=NONE ctermfg=21 ctermbg=NONE cterm=NONE
hi Statement guifg=#fd7d4a guibg=NONE guisp=NONE gui=bold ctermfg=209 ctermbg=NONE cterm=bold
hi Comment guifg=#cf2167 guibg=NONE guisp=NONE gui=NONE ctermfg=161 ctermbg=NONE cterm=NONE
hi Character guifg=#00ffff guibg=NONE guisp=NONE gui=NONE ctermfg=14 ctermbg=NONE cterm=NONE
hi Number guifg=#ffffff guibg=NONE guisp=NONE gui=NONE ctermfg=15 ctermbg=NONE cterm=NONE
hi Boolean guifg=#c0c000 guibg=NONE guisp=NONE gui=bold ctermfg=1 ctermbg=NONE cterm=bold
hi Operator guifg=#d60427 guibg=NONE guisp=NONE gui=NONE ctermfg=160 ctermbg=NONE cterm=NONE
hi Define guifg=#00ff00 guibg=NONE guisp=NONE gui=NONE ctermfg=10 ctermbg=NONE cterm=NONE
hi Function guifg=#99113a guibg=NONE guisp=NONE gui=NONE ctermfg=88 ctermbg=NONE cterm=NONE
hi PreProc guifg=#572f47 guibg=NONE guisp=NONE gui=NONE ctermfg=240 ctermbg=NONE cterm=NONE
hi Exception guifg=#cc142d guibg=NONE guisp=NONE gui=NONE ctermfg=160 ctermbg=NONE cterm=NONE
hi Keyword guifg=#ff0033 guibg=NONE guisp=NONE gui=NONE ctermfg=197 ctermbg=NONE cterm=NONE
hi Type guifg=#e05170 guibg=NONE guisp=NONE gui=NONE ctermfg=168 ctermbg=NONE cterm=NONE
hi Error guifg=NONE guibg=#ff0000 guisp=#ff0000 gui=NONE ctermfg=NONE ctermbg=196 cterm=NONE
hi PMenu guifg=#fd7d4a guibg=#810031 guisp=#810031 gui=NONE ctermfg=209 ctermbg=89 cterm=NONE
hi Constant guifg=#820027 guibg=NONE guisp=NONE gui=NONE ctermfg=88 ctermbg=NONE cterm=NONE
hi Tag guifg=#0000ff guibg=NONE guisp=NONE gui=NONE ctermfg=21 ctermbg=NONE cterm=NONE
hi String guifg=#f27f5f guibg=NONE guisp=NONE gui=NONE ctermfg=209 ctermbg=NONE cterm=NONE
hi PMenuThumb guifg=NONE guibg=#a4a6a8 guisp=#a4a6a8 gui=NONE ctermfg=NONE ctermbg=248 cterm=NONE
hi Repeat guifg=#4d3839 guibg=NONE guisp=NONE gui=NONE ctermfg=239 ctermbg=NONE cterm=NONE
hi Directory guifg=#00c000 guibg=NONE guisp=NONE gui=NONE ctermfg=34 ctermbg=NONE cterm=NONE
hi Structure guifg=#00c000 guibg=NONE guisp=NONE gui=NONE ctermfg=34 ctermbg=NONE cterm=NONE
hi Macro guifg=#00ff00 guibg=NONE guisp=NONE gui=NONE ctermfg=10 ctermbg=NONE cterm=NONE
hi cursorim guifg=#192224 guibg=#536991 guisp=#536991 gui=NONE ctermfg=235 ctermbg=60 cterm=NONE

hi xdefaultsDefine      guifg=#a53031
hi vimParenSep          guifg=#c04741
hi pythonInclude        guifg=#f7594b
hi pythonExceptions     guifg=#890837               gui=bold
