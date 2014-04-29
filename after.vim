set nu
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab

set completeopt=menuone

set so=5
set ignorecase
set lazyredraw
set noerrorbells
set novisualbell

set nobackup
set nowb
set noswapfile

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Enable filetype plugins
filetype plugin on
filetype indent on

set hlsearch

" Set to auto read when a file is changed from the outside
set autoread

let mapleader = ","
let g:SuperTabMappingForward = '<M-/>'
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabMappingTabLiteral = '<c-s-tab>'

let Tlist_Show_One_File = 1

let g:user_emmet_expandabbr_key = '<C-E>'

let NERDTreeMinimalUI=1
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=2
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\~$','^\.\+$','^\.\(git\|settings\|project\|buildpath\)$']
au GUIEnter * simalt ~x 

au BufEnter *.htm,*.html,*.tpl,*.phtml,*.snippets setlocal noexpandtab
au BufEnter *.htm,*.html,*.tpl,*.phtml 
    \ set ft=html.php.smarty | 
    \ setlocal ts=2 |
    \ set syntax=php

"my enter setting
imap <S-Enter> <C-O>$<cr>

"switch single line.
imap <M-Up> <Esc>ddkP$a
imap <M-Down> <Esc>ddp$a

"duplicate one line.
imap <C-M-Up> <Esc>yyP$a
imap <C-M-Down> <Esc>yyp$a

imap <C-L> <C-O>$

nmap <silent> <F3> :NERDTreeToggle<cr>
nmap <silent> <F8> :TlistToggle<cr>

"phpdoc mapping
nmap <Leader>dd :set paste<CR>:call PhpDocSingle()<CR>:set nopaste<CR>
nmap <Leader>da :set paste<CR>:%call PhpDocRange()<CR>:set nopaste<CR>

" Return to last edit position when opening files 
""autocmd BufReadPost *
""     \ if line("'\"") > 0 && line("'\"") <= line("$") |
""     \   exe "normal! g`\"" |
""     \ endif
" Remember info about open buffers on close
set viminfo^=%

set guifont=Courier_New:h10
set nobackup

syntax on
