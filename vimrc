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
Bundle 'kien/ctrlp.vim'

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
" set number
" set numberwidth=5

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

" All splits should be at least 30 lines tall (auto resizing focused split)
" And splits should be a minimum of 5 lines tall
" set winheight=30
" set winminheight=5

" Leader + Custom Mappings
let mapleader = "\\"

" -- Quickly edit vimrc
map <Leader>qq :sp ~/.vimrc<CR><C-W>_ 

" -- Open MRU (Most Recently Used plugin)
map <Leader>r :MRU 

" -- Close current window
map <Leader>x :close<CR>

" -- Close quickfix window
map <Leader>c :cclose<CR>

" Paste to end of line with ,
nmap , $p

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

" Test helpers from Gary Bernhardt's screen cast:
" https://www.destroyallsoftware.com/screencasts/catalog/file-navigation-in-vim
" https://www.destroyallsoftware.com/file-navigation-in-vim.html
function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo
    exec ":!clear; time rspec " . a:filename
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_spec_file = match(expand("%"), '_spec.rb$') != -1
    if in_spec_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

" Run this file
map <leader>m :call RunTestFile()<cr>
" Run only the example under the cursor
map <leader>. :call RunNearestTest()<cr>
" Run all test files
map <leader>a :call RunTests('spec')<cr>
