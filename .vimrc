" https://medium.com/@edominguez.se/vim-101-a-comprehensive-guide-to-using-vim-like-an-ide-1-3-vimrc-d484cc41fc2
" https://realpython.com/vim-and-python-a-match-made-in-heaven/
" https://towardsdatascience.com/getting-started-with-vim-and-tmux-for-python-707ec5ff747f

syntax on

set nocompatible
set fileformat=unix
set encoding=UTF-8

colorscheme desert

highlight Pmenu ctermbg=white ctermfg=black guibg=white guifg=black
highlight PmenuSel ctermbg=darkred ctermfg=black guibg=darkred guifg=black

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'    " required
Plugin 'vim-syntastic/syntastic'
Plugin 'jpalardy/vim-slime'
Plugin 'davidhalter/jedi-vim'
Plugin 'hdima/python-syntax'
" Plugin 'jaxbot/semantic-highlight.vim'
Plugin 'T-J-Howard/semantic-highlight'
Plugin 'heavenshell/vim-pydocstring'

call vundle#end()            " required
filetype plugin indent on    " required

" pydocstring settings
let g:pydocstring_doq_path = "/home/th25/Projects/pykot/tempvenv/bin/doq"
let g:pydocstring_formatter = 'google'
nnoremap <leader>f :Pydocstring<CR>

" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
" let g:syntastic_python_checkers=['flake8']
" let g:syntastic_python_flake8_args='--ignore=E101,E111,E112,E113,E114,E115,E116,E121,E122,E123,E124,E125,E126,E127,E128,E129,E131,E133,E201,E202,E203,E211,E221,E222,E223,E224,E225,E226,E227,E228,E231,E241,E242,E251,E261,E262,E265,E266,E271,E272,E273,E274,E301,E302,E303,E304,E401,E402,E501,E502,E701,E702,E703,E704,E711,E712,E713,E714,E721,E731,E901,E902,W191,W291,W292,W293,W391,W503,W601,W602,W603,W604'
let g:syntastic_mode_map = {'mode':'passive'}
nnoremap <F8> :SyntasticCheck<CR> :SyntasticToggleMode<CR> :w<CR>

let g:syntastic_quiet_messages = {
    \ "!level":  "errors" }

" vim-slime settings
" let g:slime_target = "vimterminal"
let g:slime_target = "tmux"
nnoremap <F7> :vertical terminal<CR>

" python-syntax settings
let g:python_highlight_all = 1
let g:python_highlight_space_errors = 0

" semantic-highlight settings
" let g:semanticTermColors = [28,1,2,3,4,5,6,7,25,9,10,34,12,13,14,15,16,125,124,19]  " default colours
" let g:semanticTermColors = [28,1,2,3,5,7,25,9,10,34,12,13,14,15,16,125,124,19,126,127]  " 4 and 6 are difficult to see and desert function colours respectively
let g:semanticTermColors = [1,2,3,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22]  " alternative to the line above
nnoremap <leader>t :SemanticHighlightToggle<CR>

" remove netrw banner
let g:netrw_banner = 0

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent
set smarttab
set expandtab
set nowrap
set list
set listchars=eol:.,tab:>-,trail:~,extends:>,precedes:<

set cursorline
set number
set relativenumber
" set scrolloff=8
" set signcolumn=yes
" set showcmd
set noshowmode
set conceallevel=1
set shortmess+=c
set formatoptions-=cro

set noerrorbells visualbell t_vb=
" set noswapfile
" set nobackup
" set undodir=~/.vim/undodir
" set undofile
" set clipboard=unnamed

set ignorecase
" set smartcase
set incsearch
" set hlsearch
" nnoremap <CR> :noh<CR><CR>:<backspace>

" quick switch between splits
noremap <C-h> <C-W>h
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-l> <C-W>l

" x goes to black hole register
noremap x "_x
noremap X "_X

" \ y copies to * register
noremap <leader>y "*y<ESC>

" \ p pastes from * register
noremap <leader>p "*p<ESC>

" \ o makes new line below
nnoremap <leader>o o<ESC>k

" \ O makes new line above
nnoremap <leader>O O<ESC>j

" hash comments highlighted text
vnoremap <silent> # :s/^/#/<cr>:noh<cr>

" F10 runs current .py script in terminal
autocmd FileType python map <buffer> <F10> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" \ b add break point under current line
nnoremap <leader>b oimport ipdb;ipdb.set_trace(context=5)<ESC>

" \ c comment current line from indent
nnoremap <leader>c I# <ESC>j

" \ v comment all selected text from indent of line cursor finishes on
vnoremap <leader>v ^<C-v>I# <ESC><ESC>

" \\ clears highlights
nnoremap \\ :noh<CR>

" tab for previous buffer
nnoremap <tab> :bprev<CR>

" space for next buffer
nnoremap <space> :bnext<CR>

" backspace for last buffer
nnoremap <bs> <c-^>

