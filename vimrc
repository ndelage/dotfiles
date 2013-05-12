" *** NEW CONFIG ***
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required for Vundle
Bundle 'gmarik/vundle'

" My Bundles here:
" original repos on github
Bundle 'mileszs/ack.vim'
Bundle 'juvenn/mustache.vim'
Bundle 'hashrocket/slurper'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'pangloss/vim-javascript'
Bundle 'tpope/vim-markdown'
Bundle 'ornicar/vim-mru'
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'git://github.com/wincent/Command-T.git'

" required for Vundle
filetype plugin indent on

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab
set bs=2

" Always display the status line
set laststatus=2

" Display incomplete commands
set showcmd

" Up the undo and history
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo

" No tmp files!:
set nobackup
set noswapfile

" Color scheme
set t_Co=256
colorscheme railscasts
" highlight NonText guibg=#060606
" highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Numbers
set number
set numberwidth=5

" Syntax Highlighting
syntax on
set hlsearch

" Display extra whitespace
set list 
set listchars=tab:>-,trail:.

" case only matters with mixed case expressions
set ignorecase
set smartcase

" Tab completion options
" (only complete to the longest unambiguous match, and show a menu)
set completeopt=longest,menu
set wildmode=list:longest,list:full

" Load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Leader + Custom Mappings
let mapleader = "\\"

" -- Quickly edit vimrc
map <Leader>qq :sp ~/.vimrc<CR><C-W>_ 

" -- Open MRU (Most Recently Used plugin)
map <Leader>m :MRU 

" -- Close current window
map <Leader>x :close<CR>

" -- Close quickfix window
map <Leader>c :cclose<CR>

let g:CommandTMaxFiles=50000
set wildignore+=.git,tmp,log,*.png,*.jpg,*.jpeg,*.gif,public/analytic,public/fonts,public/sounds,public/images,public/flash

" -- Coffee Script
map <Leader>cr :CoffeeRun<CR>
map <Leader>cc :CoffeeCompile<CR>
map <Leader>cm :CoffeeMake<CR>

" END CUSTOM LEADER COMMANDS

" Maps autocomplete to tab
" imap <Tab> <C-N>

" use ctr h & l to switch between windows, skip need to crt w + l
map <C-H> <C-W>h
map <C-L> <C-W>l
" same for j & k
map <C-J> <C-W>j
map <C-K> <C-W>k

" Local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif



"" filetype plugin indent on
"set nocompatible
"syntax on
"" set nocursorcolumn
"" set nocursorline
"" syntax sync minlines=256
"
"set nobackup
"set nowritebackup
"
"set tabstop=2
"set bs=2
"
"set cursorline
"hi CursorLine cterm=NONE ctermbg=black
"
"set shiftwidth=2
"set expandtab
"set nu
"set ruler
"set nowrap
"set autoindent
"filetype plugin indent on
"
"set showmatch
"set hlsearch
"set incsearch
"
"let Tlist_Ctags_Cmd="/usr/local/bin/ctags"
"
"" syntastic confi
"" set statusline+=%#warningmsg#
"" set statusline+=%{SyntasticStatuslineFlag()}
"" set statusline+=%*
"" let syntastic_enable_signs=1
"
"" Always display the status line
"set laststatus=2
"
"set t_Co=256
"
"colorscheme railscasts
"
"" use ctr h & l to switch between windows, skip need to crt w + l
"map <C-H> <C-W>h
"map <C-L> <C-W>l
"" same for j & k
"map <C-J> <C-W>j
"map <C-K> <C-W>k
