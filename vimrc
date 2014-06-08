" vim: foldmethod=marker
" general settings {{{
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

set t_Co=256

if has('mouse')
  set mouse=a
endif

let mapleader = ","
let $vim_root = expand("<sfile>:p:h")

" }}}

colors molokai

if has("win32")
    let g:launchWebBrowser=":silent ! start "
    let g:phpUnitPhar="D:/wamp/phpunit.phar"
    let g:kdbDir = "C:/kdb"
    let g:fileBrowser="explorer"
    source $VIMRUNTIME/mswin.vim
    behave mswin
elseif has("unix")

endif

" mappings {{{
map Q gq
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
nnoremap <silent> <Leader>t :TlistToggle<cr>
inoremap <expr><M-/> pumvisible() ? "\<C-n>" : "\<C-x>\<C-o>"
inoremap <S-Enter> <C-O>$<cr>
inoremap <C-L> <C-O>$
"switch single line. breaks on first/last line
inoremap <M-Up> <Esc>ddkP$a
inoremap <M-Down> <Esc>ddp$a

nnoremap <silent> <space>d "_d
nnoremap <silent> <space>t :tabe<CR>
nnoremap <silent> <space>q :q<CR>
nnoremap <silent> <Leader>ve :exe tab e g:vimrcfile
nnoremap <silent> <leader>ve :e $vim_root/vimrc<CR>
nnoremap <silent> <leader>vs :so $vim_root/vimrc<CR>
nnoremap <silent> <leader>vr 0y$:<C-r>"<CR>
nnoremap <silent> <leader>qa :qall!<cr>
nnoremap <silent> <leader>qx :q!<cr>
let g:eregex_meta_chars = '^$()[]{}.*+?\/'
let g:vregex_meta_chars = '^$|[].*\/~'
vnoremap <silent> * "vy/<C-r>=substitute(escape(@v,g:vregex_meta_chars),"\n",'\\n','g')<CR><CR>N
vnoremap <leader>sw "vy:<C-u>%s/\<<C-r>=substitute(escape(@v,g:eregex_meta_chars),"\n",'\\n','g')<CR>\>//g<Left><Left>
vnoremap <leader>sg "vy:<C-u>%s/<C-r>=substitute(escape(@v,g:eregex_meta_chars),"\n",'\\n','g')<CR>//g<Left><Left>
nnoremap <silent> <space><space> :nohl<CR>
vnoremap <silent> <leader>d "_d
"ctrlp mappings
nnoremap <silent> <Leader>bb :CtrlPBuffer<cr>
nnoremap <silent> <Leader>bm :CtrlPMRUFiles<cr>
nnoremap <silent> <Leader>bf :CtrlPFunky<cr>
nnoremap <silent> <Leader>bF :exe 'CtrlPFunky ' . expand('<cword>')<Cr>
"fugitive mappings
nnoremap <Leader>ff :Git<Space>
nnoremap <Leader>fg :GitCMD<Space>
nnoremap <Leader>fs :Gstatus<cr>
nnoremap <Leader>fa :Git add %<cr>
nnoremap <Leader>fc :Gcommit -a -m ""<Left>
nnoremap <Leader>fd :Git diff %<cr>
nnoremap <Leader>fl :GitCMD log -4<cr>
nnoremap <Leader>fp :Git push<Space>
nnoremap <Leader>pu :Phpunit<Space>
nnoremap <space>f :execute "silent !" . g:fileBrowser . " %:h"<CR>
nnoremap <silent> <leader>pm :execute g:launchWebBrowser."http://www.php.net/".expand("<cword>")<CR>
nnoremap <silent> <leader>wb :execute g:launchWebBrowser."http://www.baidu.com/s?wd=".expand("<cword>")<CR>
nnoremap <silent> <leader>wg :execute g:launchWebBrowser."https://www.google.com.hk/search?q=".expand("<cword>")<CR>
nnoremap <silent> <leader>wl :execute g:launchWebBrowser.expand("<cWORD>")<CR>
" }}}

" custom commands {{{
com! -nargs=* GitCMD :
    \ if exists("b:git_dir") |
    \ cd`=b:git_dir[0:-6]` |
    \   exe "call k#ReadExCmdIntoConsole('botri ','git','!git <args>')" |
    \ endif

com! -nargs=1 S let @/='\<'.<f-args>.'\>' | normal n
com! -nargs=? CC cd %:h
com! -nargs=? PHPTag !ctags --language-force=php <args>
com! -nargs=0 -bar Dos2Unix :%s/\r//g|set ff=unix
com! -nargs=0 -bar FmtXML :%s/>\s*</>\r</ge|set ft=xml|normal ggVG=
com! -nargs=0 -bar FmtJSON :%s/,"/,\r"/ge|%s/{"/{\r"/ge|%s/\(\S\)}/\1\r}/ge|set ft=javascript|normal ggVG=
com! -nargs=0 -bar RmTrailingBlanks :%s/\s\+$//g
com! -nargs=* Phpunit :exe "!php ".g:phpUnitPhar." <args>"
com! -nargs=? XD :exe g:launchWebBrowser."http://localhost/<args>?XDEBUG_SESSION_START=1"
" }}}

" auto commands {{{
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
    \ setlocal nolist |
    \ set syntax=php

autocmd FileType php call PHPFileSettings()

if has("gui")
    au GUIEnter * simalt ~x "maximise window
endif
" }}}

" misc {{{
"xdebug settings
let g:dbgPavimPort = 9009
let g:dbgPavimBreakAtEntry = 0

"kdb settings
let g:globalDBkeys = {
      \ 'oxford' : '<Leader>ll',
      \ 'oxford7' : '<Leader>lk',
      \ }
let g:localDBkeys = {
      \ 'php' : ['K', '<C-K>'],
      \ }

let g:snippets_dir = $vim_root . '/snippets/'
"emmet settings
let g:user_emmet_expandabbr_key = '<C-E>'
"taglist settings
let Tlist_Show_One_File = 1
"nerdtree settings
let NERDTreeMinimalUI=1
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=0
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\~$','^\.\+$','^\.\(git\|svn\|settings\|project\|metadata\|buildpath\)$']
nnoremap <Leader>n :NERDTreeToggle<cr>

"supertab settings
"let g:SuperTabCrMapping = 0
"let g:SuperTabMappingForward = '<c-j>'
"let g:SuperTabMappingBackward = '<c-k>'
"let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"let g:SuperTabMappingTabLiteral = '<c-s-tab>'

" ctrlp setup {{{
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 25
let g:ctrlp_mruf_exclude = 'dbgpavim_cli.*'
let g:ctrlp_custom_ignore = {
      \ 'dir': '\.git$\|\.hg$\|\.svn$',
      \ 'file': '\.3dm$\|\.3g2$\|\.3gp$\|\.7z$\|\.a$\|\.a.out$\|\.accdb$\|\.ai$\|\.aif$\|\.aiff$\|\.app$\|\.arj$\|\.asf$\|\.asx$\|\.au$\|\.avi$\|\.bak$\|\.bin$\|\.bmp$\|\.bz2$\|\.cab$\|\.cer$\|\.cfm$\|\.cgi$\|\.com$\|\.cpl$\|\.csr$\|\.csv$\|\.cue$\|\.cur$\|\.dat$\|\.db$\|\.dbf$\|\.dbx$\|\.dds$\|\.deb$\|\.dem$\|\.dll$\|\.dmg$\|\.dmp$\|\.dng$\|\.doc$\|\.docx$\|\.drv$\|\.dwg$\|\.dxf$\|\.ear$\|\.efx$\|\.eps$\|\.epub$\|\.exe$\|\.fla$\|\.flv$\|\.fnt$\|\.fon$\|\.gadget$\|\.gam$\|\.gbr$\|\.ged$\|\.gif$\|\.gpx$\|\.gz$\|\.hqx$\|\.ibooks$\|\.icns$\|\.ico$\|\.ics$\|\.iff$\|\.img$\|\.indd$\|\.iso$\|\.jar$\|\.jpeg$\|\.jpg$\|\.key$\|\.keychain$\|\.kml$\|\.lnk$\|\.lz$\|\.m3u$\|\.m4a$\|\.max$\|\.mdb$\|\.mid$\|\.mim$\|\.moov$\|\.mov$\|\.movie$\|\.mp2$\|\.mp3$\|\.mp4$\|\.mpa$\|\.mpeg$\|\.mpg$\|\.msg$\|\.msi$\|\.nes$\|\.o$\|\.obj$\|\.ocx$\|\.odt$\|\.otf$\|\.pages$\|\.part$\|\.pct$\|\.pdb$\|\.pdf$\|\.pif$\|\.pkg$\|\.plugin$\|\.png$\|\.pps$\|\.ppt$\|\.pptx$\|\.prf$\|\.ps$\|\.psd$\|\.pspimage$\|\.qt$\|\.ra$\|\.rar$\|\.rm$\|\.rom$\|\.rpm$\|\.rtf$\|\.sav$\|\.scr$\|\.sdf$\|\.sea$\|\.sit$\|\.sitx$\|\.sln$\|\.smi$\|\.so$\|\.svg$\|\.swf$\|\.swp$\|\.sys$\|\.tar$\|\.tar.gz$\|\.tax2010$\|\.tga$\|\.thm$\|\.tif$\|\.tiff$\|\.tlb$\|\.tmp$\|\.toast$\|\.torrent$\|\.ttc$\|\.ttf$\|\.uu$\|\.uue$\|\.vb$\|\.vcd$\|\.vcf$\|\.vcxproj$\|\.vob$\|\.war$\|\.wav$\|\.wma$\|\.wmv$\|\.wpd$\|\.wps$\|\.xll$\|\.xlr$\|\.xls$\|\.xlsx$\|\.xpi$\|\.yuv$\|\.Z$\|\.zip$\|\.zipx$\|\.lib$\|\.res$\|\.rc$\|\.out$',
      \ }
let g:ctrlp_extensions = ['funky']
" }}}

" }}}

" Plugins {{{
filetype off
let g:vundle_lazy_load=1
set rtp+=$vim_root/bundle/Vundle.vim/
call vundle#rc($vim_root.'/bundle')

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-surround'
"Plugin 'ervandew/supertab'
Plugin 'msanders/snipmate.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'brookhong/DBGPavim'
Plugin 'brookhong/k.vim'
"Plugin 'Shougo/neocomplcache'
"Plugin 'brookhong/neco-php'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'file:///'.$vim_root.'/bundle/php_doc'
Plugin 'file:///'.$vim_root.'/bundle/bufexplorer-7.4.2'

call vundle#end()
filetype plugin indent on
syntax on
" }}}

"Functions {{{
fun! PHPFileSettings()
    "php mappings
    nnoremap <Leader>dd :set paste<CR>:call PhpDocSingle()<CR>:set nopaste<CR>
    nnoremap <Leader>da :set paste<CR>:%call PhpDocRange()<CR>:set nopaste<CR>
    nnoremap <Leader>u :Phpunit %<CR>
    nnoremap <buffer> <space>l :call k#RunMe('php -l', 'botri 10', '')<CR>
    nnoremap <silent> <Tab> :call WrapMoveToCharInLine('$')<CR>
endfun

fun! WrapMoveToCharInLine(char)
    let l:current_col = col('.')
    exe "normal! f".a:char
    if l:current_col == col('.')
        exe "normal! 0f".a:char
    endif
endfun
" }}}

