" *** NEW CONFIG ***
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible               " be iMproved
filetype off                   " required!

" Provide a working path to the ack command for the ack plugin:
let g:ackprg = "ack -s -H --nocolor --nogroup --column"

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

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

au BufNewFile,BufRead *.ejs set filetype=html


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

set textwidth=80

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

" Maps autocomplete to tab
" imap <Tab> <C-N>

" use ctr h & l to switch between windows, skip need to crt w + l
map <C-H> <C-W>h
map <C-L> <C-W>l
" same for j & k
map <C-J> <C-W>j
map <C-K> <C-W>k

map ss <C-W>s
map vv <C-W>v

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

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>f :call SelectaCommand("find * -type f", "", ":e")<cr>

