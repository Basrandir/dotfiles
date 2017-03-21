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
Plug 'pgdouyon/vim-yin-yang'
Plug 'fneu/breezy'

" HTML
Plug 'mattn/emmet-vim'

" Rust
Plug 'rust-lang/rust.vim'

call plug#end()
" }}}
" Colors: {{{
let g:gruvbox_italic=1              " enable italics for gruvbox in terminals

set termguicolors   " Enable 24-bit true colour mode
set background=dark " Ensure dark background
colorscheme breezy
" }}}
" General: {{{
" Manage buffers efficiently
set hidden

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

set relativenumber number   " show absolute line number on current line and
                            " and relative line numbers for all other lines

set showcmd     " shows the last command entered in bottom bar
set cursorline  " highlights the current line
set lazyredraw  " redraw screen only when needed
set showmatch   " highlights matching brackets

" Marks excess whitespace
exec "set listchars=tab:\uB8\uB8,trail:\uB7,nbsp:~"
set list

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
" Vimwiki: {{{
let g:vimwiki_ext2syntax = {'.md': 'markdown'}
let g:vimwiki_list = [{'path': '$HOME/doc/wiki',
                     \ 'syntax': 'markdown', 'ext': '.md'}]
" }}}
