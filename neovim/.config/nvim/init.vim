" COLOURS
let $NVIM_TUI_ENABLE_TRUE_COLOR=1   " enable 24-bit colours
colorscheme byzantine   " enable the byzantine colourscheme
syntax enable           " enable syntax highlighting

" SPACES and TABS
set softtabstop=4   " number of spaces a tab is worth in insert mode
set shiftwidth=4    " number of spaces a tab is worth in normal mode
set expandtab       " tabs are now spaces
set autoindent      " very basic automatic indentation

" UI
filetype plugin indent on   " load filetype specific indent and plugin files if they exist

set relativenumber  " show relative line numbers on the left side
set number          " show absoulte line number of current line
set cursorline  " enables highlight or underline of current line depending on colour scheme
set wildmenu    " visual autocomplete for command menu
set lazyredraw  " redraw screen only when needed
set showmatch   " highlights matching brackets

call plug#begin()

" Statusline
Plug 'itchyny/lightline.vim'
let g:lightline = {'colorscheme': 'byzantine',}
call plug#end()

" SEARCH
set incsearch   " searches as characters are typed
set hlsearch    " highlights all matches

" Rust Highlighting
au BufNewFile,BufRead *.rs set filetype=rust

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
