" Plugins: {{{
call plug#begin()

" General
Plug 'jiangmiao/auto-pairs'
Plug 'lilydjwg/colorizer'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" UI
Plug 'Yggdroot/indentLine'
Plug 'junegunn/goyo.vim'

" Fuzzy Finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Linting
Plug 'w0rp/ale'

" Themes
Plug 'morhetz/gruvbox'
Plug 'pgdouyon/vim-yin-yang'

" HTML
Plug 'mattn/emmet-vim'

" Rust
Plug 'rust-lang/rust.vim'

" latex
Plug 'lervag/vimtex'

call plug#end()
" }}}
" Colors: {{{
set termguicolors   " Enable 24-bit true colour mode
set background=dark " Ensure dark background
colorscheme shiny
" }}}
" Behaviour: {{{
" Manage buffers efficiently
set hidden

" Start scrolling 3 lines before edge of viewpoint
set scrolloff=3

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" }}}
" Indentation: {{{
set softtabstop=4
set shiftwidth=4
set expandtab

" Wraps lines more logically
set linebreak
" }}}
" UI: {{{
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

let g:gruvbox_italic=1              " enable italics for gruvbox in terminals

" show absolute line number on current line and
" and relative line numbers for all other lines
set relativenumber number

set showcmd     " shows the last command entered in bottom bar
set cursorline  " highlights the current line
set lazyredraw  " redraw screen only when needed
set showmatch   " highlights matching brackets

" Marks excess whitespace
exec "set listchars=tab:\uB8\uB8,trail:\uB7,nbsp:~"
set list

" Indent wrapped lines to match line start
" then add 2 extra space
" and add unicode arrow 'U+2937' before new wrapped line
if has('linebreak')
    set breakindent
    if exists('&breakindentopt')
        set breakindentopt=shift:2
    endif

    let &showbreak='⤷'
endif

" Sane Splits
set splitbelow
set splitright
" }}}
" Search: {{{
set ignorecase  " ignore case in searches
set smartcase   " Override 'ignorecase' if the search pattern includes
                " uppercase characters

set inccommand=nosplit  " shows command results as typed
" }}}
" Mappings: {{{
let mapleader=" "

" General
nnoremap <leader>w :w<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>qq :q!<CR>
nnoremap <leader>so :source %<CR>

" fzf
nnoremap <leader>o :Files<CR>
nnoremap <leader>go :GFiles<CR>
nnoremap <leader>b :Buffers<CR>

" Vim-Fugitive
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gd :Gdiff<CR>

" Split Navigation
tnoremap <Esc> <C-\><C-n>

tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}
" Folding: {{{
autocmd FileType vim setlocal foldmethod=marker
" }}}
