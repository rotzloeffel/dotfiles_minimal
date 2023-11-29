set encoding=utf-8
scriptencoding utf-8

" Activate matchit plugin
runtime! macros/matchit.vim

" Activate man page plugin
runtime! ftplugin/man.vim

" Use English as default
language en_US.utf-8

filetype plugin indent on
syntax enable

" Set height of status line
set laststatus=2

" Changing fillchars for folding, so there is no garbage charactes
set fillchars=fold:\ ,vert:\|

" Split window below/right when creating horizontal/vertical windows
set splitbelow splitright

" Time in milliseconds to wait for a mapped sequence to complete,
" see https://unix.stackexchange.com/q/36882/221410 for more info
set timeoutlen=500

" For CursorHold events
set updatetime=800

" Clipboard settings, always use clipboard for all delete, yank, change, put
" operation, see https://stackoverflow.com/q/30691466/6064933
set clipboard+=unnamed
set clipboard+=unnamedplus

" Disable creating swapfiles, see https://stackoverflow.com/q/821902/6064933
set noswapfile

" General tab settings
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " expand tab to spaces so that tabs are spaces

" Set matching pairs of characters and highlight matching brackets
set matchpairs+=<:>,「:」

" Show line number and relative line number
set number relativenumber

" Ignore case in general, but become case-sensitive when uppercase is present
set ignorecase smartcase

" File encoding settings for vim
set fileencoding=utf-8

" Break line at predefined characters
set linebreak

" Character to show before the lines that have been soft-wrapped
set showbreak=↪

" List all items and start selecting matches in cmd completion
set wildmode=list:full

" Show current line where the cursor is
set cursorline

" Set a ruler at column 80, see https://stackoverflow.com/q/2447109/6064933
" set colorcolumn=80

" Minimum lines to keep above and below cursor when scrolling
set scrolloff=3

" Do show mode on command line 
set showmode

" Fileformats to use for new files
set fileformats=unix,dos

" The mode in which cursorline text can be concealed
set concealcursor=nc

" Ask for confirmation when handling unsaved or read-only files
set confirm

" Do not use visual and error bells
set novisualbell noerrorbells

" The level we start to fold
set foldlevel=0

" The number of command and search history to keep
set history=500

" Use list mode and customized listchars
set list listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:+

" Auto-write the file based on some condition
set autowrite

" Persistent undo even after you close a file and re-open it.
" For vim, we need to set up an undodir so that $HOME is not cluttered with
" undo files.
if !has('nvim')
    if !isdirectory($HOME . '/.local/vim/undo')
        call mkdir($HOME . '/.local/vim/undo', 'p', 0700)
    endif
    set undodir=~/.local/vim/undo
endif
set undofile

" Align indent to next multiple value of shiftwidth. For its meaning,
" see http://vim.1045645.n5.nabble.com/shiftround-option-td5712100.html
set shiftround

" Virtual edit is useful for visual block edit
set virtualedit=block

" Correctly break multi-byte characters such as CJK,
" see https://stackoverflow.com/q/32669814/6064933
set formatoptions+=mM

" Tilde (~) is an operator, thus must be followed by motions like `e` or `w`.
set tildeop

" Do not add two spaces after a period when joining lines or formatting texts,
" see https://stackoverflow.com/q/4760428/6064933
set nojoinspaces

" Text after this column is not highlighted
set synmaxcol=500

" Increment search
set incsearch
set hlsearch

set wildmenu

" Do not use corsorcolumn
set nocursorcolumn

set backspace=indent,eol,start  " Use backsapce to delete

let mapleader = ' '

" Do not load netrw by default since I do not use it, see
" https://github.com/bling/dotvim/issues/4
let g:loaded_netrwPlugin = 1

" Do not load tohtml.vim
let g:loaded_2html_plugin = 1

set background=dark

set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.
set display     =lastline  " Show as much as possible of the last line.
