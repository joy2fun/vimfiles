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

set viminfo^=% " Remember info about open buffers on close
set hlsearch
set autoread " Set to auto read when a file is changed from the outside
set nobackup

set guifont=Courier_New:h10

" Enable filetype plugins
filetype plugin on
filetype indent on
syntax on

"Return to last edit position when opening files 
"autocmd BufReadPost *
"     \ if line("'\"") > 0 && line("'\"") <= line("$") |
"     \   exe "normal! g`\"" |
"     \ endif

let mapleader = ","

if has("gui")
    au GUIEnter * simalt ~x "maximise window
endif

if has("win32")
    let g:launchWebBrowser=":silent ! start "
    let g:phpUnitPhar="D:/wamp/phpunit.phar"
elseif has("unix")

endif

au BufEnter *.htm,*.html,*.tpl,*.phtml,*.css,*.snippets setlocal noexpandtab
au BufEnter *.htm,*.html,*.tpl,*.phtml 
    \ set ft=html.php.smarty | 
    \ setlocal ts=2 | 
    \ setlocal sts=2 | 
    \ setlocal sw=2 |
    \ set syntax=php

"supertab settings
"let g:SuperTabCrMapping = 0
"let g:SuperTabMappingForward = '<c-j>'
"let g:SuperTabMappingBackward = '<c-k>'
"let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"let g:SuperTabMappingTabLiteral = '<c-s-tab>'

"emmet settings
let g:user_emmet_expandabbr_key = '<C-E>'

"nerdtree settings
let NERDTreeMinimalUI=1
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=0
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\~$','^\.\+$','^\.\(git\|svn\|settings\|project\|metadata\|buildpath\)$']
nmap <silent> <Leader>n :NERDTreeToggle<cr>

"taglist settings
let Tlist_Show_One_File = 1
nmap <silent> <Leader>t :TlistToggle<cr>

inoremap <S-Enter> <C-O>$<cr>
inoremap <C-L> <C-O>$
imap <expr><M-/> pumvisible() ? "\<C-n>" : "\<C-x>\<C-o>"

"switch single line. breaks on first/last line 
inoremap <M-Up> <Esc>ddkP$a
inoremap <M-Down> <Esc>ddp$a

"duplicate one line.
inoremap <C-M-Up> <Esc>yyP$a
inoremap <C-M-Down> <Esc>yyp$a

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

"phpdoc mappings
nmap <Leader>dd :set paste<CR>:call PhpDocSingle()<CR>:set nopaste<CR>
nmap <Leader>da :set paste<CR>:%call PhpDocRange()<CR>:set nopaste<CR>

"php command mappings
nmap <Leader>pp :!php<Space>%<cr>
nmap <Leader>pu :exe "!php ".g:phpUnitPhar
"save current file and then run php lint
nmap <Leader>pl :update<cr>:!php -l %<cr>
"lookup in php manual 
nnoremap <silent> <leader>pm :execute g:launchWebBrowser."http://www.php.net/".expand("<cword>")<CR>

"launch browser mappings
nnoremap <silent> <leader>wb :execute g:launchWebBrowser."http://www.baidu.com/s?wd=".expand("<cword>")<CR>
nnoremap <silent> <leader>wg :execute g:launchWebBrowser."https://www.google.com.hk/search?q=".expand("<cword>")<CR>
nnoremap <silent> <leader>wl :execute g:launchWebBrowser.expand("<cWORD>")<CR>
