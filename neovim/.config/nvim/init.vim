" Plugins: {{{
call plug#begin()

" General
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'

Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
"Plug 'suan/vim-instant-markdown'

" Fuzzy Finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Linting
Plug 'w0rp/ale'

" Themes
Plug 'morhetz/gruvbox'

" HTML
Plug 'mattn/emmet-vim'

call plug#end()
" }}}
" Colors: {{{
let $NVIM_TUI_ENABLE_TRUE_COLOR=1   " enable 24-bit colour
let g:gruvbox_italic=1              " enable italics for gruvbox in terminals

set background=dark " gruvbox dark mode
colorscheme gruvbox
" }}}
" General: {{{
" Manage buffers efficiently
set hidden
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

set relativenumber number   " show absolute line number on current line and
                            " and relative line numbers for all other lines

set showcmd     " shows the last command entered in bottom bar
set cursorline  " highlights the current line
set lazyredraw  " redraw screen only when needed
set showmatch   " highlights matching brackets

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
nnoremap <leader>o :Files<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>ww :w!<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>qq :q!<CR>
nnoremap <leader>so :source %<CR>

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
" Vimwiki: {{{
let g:vimwiki_ext2syntax = {'.md': 'markdown'}
let g:vimwiki_list = [{'path': '$HOME/doc/wiki',
                     \ 'syntax': 'markdown', 'ext': '.md'}]
" }}}
