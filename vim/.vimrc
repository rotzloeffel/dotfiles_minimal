" ---| compatibility |--- "
set nocompatible                        " disable vi compatibility mode
set mouse=a                             " enable mouse for all modes (e.g. with tmux)
set mousefocus                          " window focus follows mouse
set mousehide                           " hide mouse pointer when characters are typed

" ---| general config |--- "
filetype plugin indent on               " load plugins according to detected filetype.
set autoread                            " reload files changed outside vim
set autowrite                           " auto-write the file based on some condition
set backspace=indent,eol,start          " use backsapce to delete
set confirm                             " ask for confirmation when handling unsaved or read-only files
set hidden                              " needed to keep multiple buffers open
set history=500                         " the number of command and search history to keep
set laststatus=2                        " set height of status line
set lazyredraw                          " only redraw when necessary.
set linebreak                           " break line at predefined characters
set noswapfile                          " disable creating swapfiles
set novisualbell noerrorbells           " do not use visual and error bells
set shortmess+=I                        " no intro message when starting vim
set showcmd                             " show already typed keys when more are expected.
set textwidth=80
set timeoutlen=500                      " time in milliseconds to wait for a mapped sequence to complete,
set ttyfast                             " faster redrawing.
set updatetime=800                      " for cursorHold events
set virtualedit=block                   " virtual edit is useful for visual block edit
set wildmenu                            " extended autocompletion for commands
set wildcharm=<TAB>                     " autocmpletion hotkey
set nocursorline
set nocursorcolumn
set conceallevel=0                      " do not hide markdown
set gdefault                            " add the g flag to search/replace by default
set nowrap                              " don't wrap lines

" ---| encoding |--- "
set fileencoding=utf-8
set encoding=utf-8
set fileformats=unix,dos

" ---| color and style |--- "
syntax on                               " enable syntax highlighting.
set background=dark                     " set terminal background for better readability
colorscheme default                     " set colorscheme
set scrolloff=3                         " minimum lines to keep above and below cursor when scrolling
set sidescrolloff=3                     " minimum lines to keep right and left from cursor when scrolling
set synmaxcol=300                       " text after this column is not highlighted
set title                               " title: turn on (for tmux and terminal apps tab title)

" ---| display line numbers |--- "
set number relativenumber               " show line number and relative line number

" ---| searching criteria |--- "
set ignorecase                          " ignore case in search patterns
set smartcase                           " override ignorecase if search pattern has capital letters
set wildmode=longest,list               " list all matches
set showmatch                           " highlight matching parentheses/brackets
set matchpairs+=<:>                     " make < and > match as well
set hlsearch                            " highlight search results
set incsearch                           " show matches while typing pattern

" ---| indent whitespace characters |--- "
set list
set listchars=tab:»\ ,trail:·,extends:>,precedes:<

" --- indentation --- "
set tabstop=4                           " number of visual spaces per TAB
set softtabstop=4                       " number of spaces in tab when editing
set shiftwidth=4                        " number of spaces to use for autoindent
set expandtab                           " expand tab to spaces so that tabs are spaces
set shiftround                          " align indent to next multiple value of shiftwidth. For its meaning,
set autoindent                          " copy indent from previous line
set smartindent                         " enable smart indent. It add additional indents when necessary"
set smarttab                            " when you hit tab at start of line, indent added according to shiftwidth value

" ---| scrolling and mouse control |--- "
set scrolloff=10                        " keep at least x lines above/below cursor if possible
set whichwrap+=<,>,[,],h,l              " <Left>, <Right>, h, and l wrap around line breaks
set nostartofline                       " don't reset cursor to start of line when moving around

" ---| folding |--- "
set nofoldenable                        " fold level: when starting, let all the folds be open
set foldopen+=jump                      " when jumping to line, folds on the line should be opened
set fillchars=fold:\ ,vert:\|           " changing fillchars for folding, so there is no garbage charactes
set foldmethod=indent                   " fold based on indent
set foldnestmax=3                       " deepest fold is 3 levels

" ---| clipboard |--- "
set clipboard+=unnamed
set clipboard+=unnamedplus

" ---| splits |--- "
set splitbelow                          " split window below when creating horizontal/vertical windows
set splitright                          " split window right when creating horizontal/vertical windows

" ---| backup |--- "
set nobackup " disable backups files
set nowritebackup

" ---| persistent undo | --- "
if !has('nvim')
    if !isdirectory($HOME . '/.vim/undo')
        call mkdir($HOME . '/.vim/undo', 'p', 0700)
    endif
    set undodir=~/.vim/undo
endif
set undofile

" ---| colors |--- "
highlight ColorColumn ctermbg=darkGrey " set highlighting for colorcolum

" ---| keymappings |--- "

" leader key <Space>
:noremap <Space> <Nop>
let mapleader  = "\<Space>"
let localleader= "\<Space>"

" map "<leader> q" to quit vim
nnoremap <leader>q :q<cr>

" map "<leader> w" to save
nnoremap <leader>w :w<cr>

" map "<leader> x" to close buffer
nnoremap <leader>x :bd<cr>

" map "<leader> bn" next buffer
nnoremap <leader>bn :bnext<cr>

" map "<leader> bp" previous buffer
nnoremap <leader>bp :bprevious<cr>

" map "<leader> t" new tab
nnoremap <leader>t :tabnew<cr>

" map "<leader> tn" next tab
nnoremap <leader>tn :tabnext<cr>

" map "<leader> tp" previous tab
nnoremap <leader>tp :tabprev<cr>

" map "<leader> v" split vertical
nnoremap <leader>v :vsplit<cr>

" map "<leader> h" split horizontal
nnoremap <leader>h :split<cr>

" removes search highlighting
nnoremap <silent> <leader><leader> :nohl<CR><C-l>

" shiftTab DeIndents:
" for command mode
nnoremap <S-Tab> <<
" for insert mode
inoremap <S-Tab> <C-d>

" easy Code Block Movement: move selection with > and <
vnoremap < <gv
vnoremap > >gv

" o without insert: exit insert mode after creating a new line above or below the current line.
nnoremap o o<esc>
nnoremap O O<esc>

" insert and remove comments in visual and normal mode
vmap <leader>c :s/^/#/g<CR>:let @/ = ""<CR>
map  <leader>c :s/^/#/g<CR>:let @/ = ""<CR>
vmap <leader>rc :s/^#//g<CR>:let @/ = ""<CR>
map  <leader>rc :s/^#//g<CR>:let @/ = ""<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" disable the recording macro
map q <Nop>

" search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" jump to the last position when reopening a file
if has('autocmd')
  let s:last_position_disable_filetypes = ['gitcommit']
  au BufReadPost * if index(s:last_position_disable_filetypes, &ft) < 0 && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"zz" | endif
endif

" reload .vimrc if changed
autocmd! bufwritepost :source ~/.vimrc

" set correct indentation for yaml files
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 et ai

" disable auto comment on new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
