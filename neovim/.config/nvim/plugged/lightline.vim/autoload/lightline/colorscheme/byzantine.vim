" =============================================================================
" Filename: autoload/lightline/colorscheme/Tomorrow.vim
" Author: itchyny
" License: MIT License
" Last Change: 2013/09/07 12:22:37.
" =============================================================================
let s:base03 = '#efa085'
let s:base1 = '#3d0a2e'
let s:base01 = '#7a0131'
let s:base02 = '#fd7d4b'
let s:base00 = '#850223'
let s:base0 = '#ad193d'
let s:base023 = '#fedbc5'
let s:base2 = '#940e35'
let s:base3 = '#fd6c40'
let s:red = '#c7283e'
let s:orange = '#d24047'
let s:yellow = '#820133'
let s:green = '#fd583e'
let s:cyan = '#ed443a'
let s:blue = '#2e112d'
let s:magenta = '#530131'

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:base02, s:blue ], [ s:base3, s:base01 ] ]
let s:p.normal.right = [ [ s:base02, s:magenta ], [ s:base1, s:base0 ] ]
let s:p.inactive.right = [ [ s:base02, s:base00 ], [ s:base00, s:base02 ] ]
let s:p.inactive.left =  [ [ s:base0, s:base02 ], [ s:base00, s:base03 ] ]
let s:p.insert.left = [ [ s:base03, s:red ], [ s:base3, s:base01 ] ]
let s:p.replace.left = [ [ s:base02, s:orange ], [ s:base3, s:base01 ] ]
let s:p.visual.left = [ [ s:base02, s:magenta ], [ s:base3, s:base01 ] ]
let s:p.normal.middle = [ [ s:base1, s:base02 ] ]
let s:p.inactive.middle = [ [ s:base0, s:base02 ] ]
let s:p.tabline.left = [ [ s:base2, s:base01 ] ]
let s:p.tabline.tabsel = [ [ s:base2, s:base023 ] ]
let s:p.tabline.middle = [ [ s:base01, s:base00 ] ]
let s:p.tabline.right = copy(s:p.normal.right)
let s:p.normal.error = [ [ s:red, s:base01 ] ]
let s:p.normal.warning = [ [ s:yellow, s:base0 ] ]

let g:lightline#colorscheme#byzantine#palette = lightline#colorscheme#fill(s:p)
