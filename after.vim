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

if has("win32")
    let g:launchWebBrowser=":silent ! start "
elseif has("unix")

endif

"supertab mapping
"let g:SuperTabCrMapping = 0
"let g:SuperTabMappingForward = '<c-j>'
"let g:SuperTabMappingBackward = '<c-k>'
"let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"let g:SuperTabMappingTabLiteral = '<c-s-tab>'

let Tlist_Show_One_File = 1

let g:user_emmet_expandabbr_key = '<C-E>'

let NERDTreeMinimalUI=1
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=0
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\~$','^\.\+$','^\.\(git\|svn\|settings\|project\|metadata\|buildpath\)$']

"au GUIEnter * simalt ~x 

au BufEnter *.htm,*.html,*.tpl,*.phtml,*.css,*.snippets setlocal noexpandtab
au BufEnter *.htm,*.html,*.tpl,*.phtml 
    \ set ft=html.php.smarty | 
    \ setlocal ts=2 | 
    \ setlocal sts=2 | 
    \ setlocal sw=2 |
    \ set syntax=php

"my enter setting
inoremap <S-Enter> <C-O>$<cr>

"switch single line.
inoremap <M-Up> <Esc>ddkP$a
inoremap <M-Down> <Esc>ddp$a

"duplicate one line.
inoremap <C-M-Up> <Esc>yyP$a
inoremap <C-M-Down> <Esc>yyp$a

inoremap <C-L> <C-O>$

imap <expr><M-/> pumvisible() ? "\<C-n>" : "\<C-x>\<C-o>"

nmap <silent> <Leader>n :NERDTreeToggle<cr>
nmap <silent> <Leader>t :TlistToggle<cr>

"ctrlp mappings
nmap <Leader>bb :CtrlPBuffer<cr>
nmap <Leader>bm :CtrlPMRUFiles<cr>

"fugitive mappings
nmap <Leader>ff :Git<Space>
nmap <Leader>fs :Gstatus<cr>
nmap <Leader>fa :Git add %<cr>
nmap <Leader>fc :Gcommit -a -m ""<Left>
nmap <Leader>fw :Gwrite<cr>
nmap <Leader>fd :Git diff %<cr>
nmap <Leader>fl :Git log -5<cr>

"phpdoc mapping
nmap <Leader>dd :set paste<CR>:call PhpDocSingle()<CR>:set nopaste<CR>
nmap <Leader>da :set paste<CR>:%call PhpDocRange()<CR>:set nopaste<CR>

"php command mapping
nmap <Leader>pp :!php<Space>%<cr>
nmap <Leader>pu :!php<Space>phpunit.phar<C-Left>
"save current file and then run php lint
nmap <Leader>pl :update<cr>:!php -l %<cr>

"launch browser mappings
nnoremap <silent> <leader>wb :execute g:launchWebBrowser."http://www.baidu.com/s?wd=".expand("<cword>")<CR>
nnoremap <silent> <leader>wg :execute g:launchWebBrowser."https://www.google.com.hk/search?q=".expand("<cword>")<CR>
nnoremap <silent> <leader>wl :execute g:launchWebBrowser.expand("<cWORD>")<CR>

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
