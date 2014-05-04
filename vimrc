set nocompatible

autocmd!

let $LANG='en'
set enc=utf-8
set guioptions-=m
set guioptions-=L
set guioptions-=T
set guioptions-=r

set cursorline
set wildmenu
set notimeout nottimeout
set laststatus=2
set list
set listchars=tab:>-,trail:-
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

set hidden
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

set backspace=indent,eol,start
set guifont=Courier_New:h10

set history=50  " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch   " do incremental searching

let mapleader = ","
let $vim_root = expand("<sfile>:p:h")

if has("gui")
    au GUIEnter * simalt ~x "maximise window
endif

if has("win32")
    let g:launchWebBrowser=":silent ! start "
    let g:phpUnitPhar="D:/wamp/phpunit.phar"
    let g:kdbDir = $VIM.'/kdb'
    let g:snippets_dir = $VIM . '/vimfiles/snippets/'
elseif has("unix")

endif

let g:globalDBkeys = {
      \ 'oxford' : '<Leader>ll',
      \ 'oxford7' : '<Leader>lk',
      \ }
let g:localDBkeys = {
      \ 'php' : ['K', '<C-K>'],
      \ }

map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

"Return to last edit position when opening files 
au BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

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

nnoremap <Leader>ve :exe tab e g:vimrcfile
nnoremap <silent> <leader>ve :e $vim_root/vimrc<CR>
nnoremap <silent> <leader>vs :so $vim_root/vimrc<CR>
nnoremap <silent> <space>q :q<CR>
nnoremap <silent> <space>t :tabe<CR>

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
nmap <Leader>fg :GitCMD<Space>
nmap <Leader>fs :Gstatus<cr>
nmap <Leader>fa :Git add %<cr>
nmap <Leader>fc :Gcommit -a -m ""<Left>
nmap <Leader>fw :Gwrite<cr>
nmap <Leader>fd :Git diff %<cr>
nmap <Leader>fl :GitCMD log -4<cr>
nmap <Leader>fp :Git push  master<C-Left><Left>
command! -nargs=* GitCMD :
    \ if exists("b:git_dir") |
    \ cd`=b:git_dir[0:-6]` |
    \   exe "call k#ReadExCmdIntoConsole('botri ','git','!git <args>')" |
    \ endif

"php mappings
autocmd FileType php 
    \ nnoremap <Leader>dd :set paste<CR>:call PhpDocSingle()<CR>:set nopaste<CR> |
    \ nnoremap <Leader>da :set paste<CR>:%call PhpDocRange()<CR>:set nopaste<CR> |
    \ nnoremap <Leader>u :Phpunit %<CR> |
    \ nnoremap <buffer> <leader>l :call k#RunMe('php -l', 'botri 10', '')<CR>

nnoremap <Leader>pu :Phpunit<Space>
command! -nargs=* Phpunit :exe "!php ".g:phpUnitPhar." <args>"

"lookup in php manual 
nnoremap <silent> <leader>pm :execute g:launchWebBrowser."http://www.php.net/".expand("<cword>")<CR>

"launch browser mappings
nnoremap <silent> <leader>wb :execute g:launchWebBrowser."http://www.baidu.com/s?wd=".expand("<cword>")<CR>
nnoremap <silent> <leader>wg :execute g:launchWebBrowser."https://www.google.com.hk/search?q=".expand("<cword>")<CR>
nnoremap <silent> <leader>wl :execute g:launchWebBrowser.expand("<cWORD>")<CR>

"xdebug settings
let g:dbgPavimPort = 9009
let g:dbgPavimBreakAtEntry = 0

filetype off
let g:vundle_lazy_load=1
set rtp+=$VIM/vimfiles/bundle/Vundle.vim/
let path=$VIM.'/vimfiles/bundle'
call vundle#rc(path)

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-surround'
"Plugin 'ervandew/supertab'
Plugin 'msanders/snipmate.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'brookhong/DBGPavim'
Plugin 'brookhong/k.vim'
"Plugin 'Shougo/neocomplcache'
"Plugin 'brookhong/neco-php'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'file:///'.$VIM.'/vimfiles/bundle/php_doc' 
Plugin 'file:///'.$VIM.'/vimfiles/bundle/bufexplorer-7.4.2' 

call vundle#end()
filetype plugin indent on
syntax on

source $VIMRUNTIME/mswin.vim
behave mswin

" ctrlp setup
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 25
let g:ctrlp_mruf_exclude = 'dbgpavim_cli.*'
let g:ctrlp_custom_ignore = {
      \ 'dir': '\.git$\|\.hg$\|\.svn$',
      \ 'file': '\.3dm$\|\.3g2$\|\.3gp$\|\.7z$\|\.a$\|\.a.out$\|\.accdb$\|\.ai$\|\.aif$\|\.aiff$\|\.app$\|\.arj$\|\.asf$\|\.asx$\|\.au$\|\.avi$\|\.bak$\|\.bin$\|\.bmp$\|\.bz2$\|\.cab$\|\.cer$\|\.cfm$\|\.cgi$\|\.com$\|\.cpl$\|\.csr$\|\.csv$\|\.cue$\|\.cur$\|\.dat$\|\.db$\|\.dbf$\|\.dbx$\|\.dds$\|\.deb$\|\.dem$\|\.dll$\|\.dmg$\|\.dmp$\|\.dng$\|\.doc$\|\.docx$\|\.drv$\|\.dwg$\|\.dxf$\|\.ear$\|\.efx$\|\.eps$\|\.epub$\|\.exe$\|\.fla$\|\.flv$\|\.fnt$\|\.fon$\|\.gadget$\|\.gam$\|\.gbr$\|\.ged$\|\.gif$\|\.gpx$\|\.gz$\|\.hqx$\|\.ibooks$\|\.icns$\|\.ico$\|\.ics$\|\.iff$\|\.img$\|\.indd$\|\.iso$\|\.jar$\|\.jpeg$\|\.jpg$\|\.key$\|\.keychain$\|\.kml$\|\.lnk$\|\.lz$\|\.m3u$\|\.m4a$\|\.max$\|\.mdb$\|\.mid$\|\.mim$\|\.moov$\|\.mov$\|\.movie$\|\.mp2$\|\.mp3$\|\.mp4$\|\.mpa$\|\.mpeg$\|\.mpg$\|\.msg$\|\.msi$\|\.nes$\|\.o$\|\.obj$\|\.ocx$\|\.odt$\|\.otf$\|\.pages$\|\.part$\|\.pct$\|\.pdb$\|\.pdf$\|\.pif$\|\.pkg$\|\.plugin$\|\.png$\|\.pps$\|\.ppt$\|\.pptx$\|\.prf$\|\.ps$\|\.psd$\|\.pspimage$\|\.qt$\|\.ra$\|\.rar$\|\.rm$\|\.rom$\|\.rpm$\|\.rtf$\|\.sav$\|\.scr$\|\.sdf$\|\.sea$\|\.sit$\|\.sitx$\|\.sln$\|\.smi$\|\.so$\|\.svg$\|\.swf$\|\.swp$\|\.sys$\|\.tar$\|\.tar.gz$\|\.tax2010$\|\.tga$\|\.thm$\|\.tif$\|\.tiff$\|\.tlb$\|\.tmp$\|\.toast$\|\.torrent$\|\.ttc$\|\.ttf$\|\.uu$\|\.uue$\|\.vb$\|\.vcd$\|\.vcf$\|\.vcxproj$\|\.vob$\|\.war$\|\.wav$\|\.wma$\|\.wmv$\|\.wpd$\|\.wps$\|\.xll$\|\.xlr$\|\.xls$\|\.xlsx$\|\.xpi$\|\.yuv$\|\.Z$\|\.zip$\|\.zipx$\|\.lib$\|\.res$\|\.rc$\|\.out$',
      \ }
let g:ctrlp_extensions = ['funky']
