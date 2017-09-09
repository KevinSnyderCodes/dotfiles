" Key Bindings -----------------
let mapleader = ","

" Misc -------------------------
syntax enable       " enable syntax processing

" Indentation ------------------
set tabstop=4       " number of visual spaces per <TAB>
"set softtabstop=4   " number of spaces inserted per <TAB>
"set expandtab       " convert <TAB>s to <SPACE>s

" UI ---------------------------
set number          " show line numbers
set showcmd         " show last command in bottom bar
"set cursorline      " highlight current line
set wildmenu        " visual autocomplete for command menu
set lazyredraw      " redraw the screen only when needed
set showmatch       " highlight matching [{()}]

" Search -----------------------
set incsearch       " search as characters are entered
set hlsearch        " highlight matches
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
