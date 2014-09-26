" vim: foldmethod=marker

" general settings {{{
set nocompatible
au!

let $LANG='en'
set enc=utf-8
set guioptions-=m
set guioptions-=L
set guioptions-=T
set guioptions-=r
set nocursorline
set wildmenu
set notimeout nottimeout
set laststatus=2
set list
set listchars=tab:>-,trail:-
"set nu
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set completeopt=menuone
set scrolloff=5
set ignorecase
set lazyredraw
set noerrorbells
set novisualbell
set hidden
set nobackup
set nowritebackup
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
"set autochdir
set t_Co=256

if has('mouse')
  set mouse=a
endif

let mapleader = ","
let $vim_root = expand("<sfile>:p:h")
source $VIMRUNTIME/mswin.vim
behave mswin
colors molokai
" }}}

" os specific {{{
fun! IsPath(path)
    return !empty(glob(a:path))
endfun

if has("win32")
    let g:launchWebBrowser=":silent ! start "
    let g:kdbDir="C:/Dropbox/kdb"
    let g:fileBrowser="explorer"
    let g:wwwroot="D:/wamp/www"
    if !IsPath(g:wwwroot)
        let g:wwwroot="D:/"
        if !IsPath(g:wwwroot)
            let g:wwwroot="C:/"
        endif
    endif
elseif has("unix")
    let g:launchWebBrowser=":!/usr/bin/google-chrome "
    let g:kdbDir="~/kdb"
    let g:fileBrowser="nautilus"
    let g:wwwroot="/opt/lampp/htdocs"
    if !IsPath(g:wwwroot)
        let g:wwwroot="~"
    endif
endif

cd`=g:wwwroot`

" }}}

" mappings {{{
nmap H <C-W>h
nmap L <C-W>l
nmap J <C-W>j
nmap K <C-W>k
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
ino <C-U> <C-G>u<C-U>
nn <silent> Q :exe ":h ".expand("<cword>")<cr>
nn <silent> <leader>t :TlistToggle<cr>
nn <silent> <leader>n :NERDTreeToggle<cr>
nn <silent> <leader>e :CC<cr>:NERDTree .<cr>
nn <silent> <space>n :set nolist!<cr>
nn <silent> <space>w :exe ":NERDTree ".g:wwwroot<cr>
ino <C-L> <C-O>$
"switch single line. breaks on first/last line
ino <M-Up> <Esc>ddkP$a
ino <M-Down> <Esc>ddp$a

nn <silent> <space>d "_d
nn <silent> <space>t :tabe<CR>
nn <silent> <space>q :q<CR>
nn <space>g :Rc !grep -irl --exclude-dir=.git<space>
nn <silent> <leader>ve :tabe $vim_root/vimrc<CR>:set fdm=marker<CR>
nn <silent> <leader>vs :so $vim_root/vimrc<CR>
nn <silent> <leader>vr 0y$:<C-r>"<CR>
nn <silent> <leader>qa :qall!<cr>
nn <silent> <leader>qx :q!<cr>
let g:eregex_meta_chars = '^$()[]{}.*+?\/'
let g:vregex_meta_chars = '^$|[].*\/~'
vn <silent> * "vy/<C-r>=substitute(escape(@v,g:vregex_meta_chars),"\n",'\\n','g')<CR><CR>N
vn <leader>sw "vy:<C-u>%s/\<<C-r>=substitute(escape(@v,g:eregex_meta_chars),"\n",'\\n','g')<CR>\>//g<Left><Left>
vn <leader>sg "vy:<C-u>%s/<C-r>=substitute(escape(@v,g:eregex_meta_chars),"\n",'\\n','g')<CR>//g<Left><Left>
nn <silent> <space>h :nohl<CR>
"ctrlp mappings
nn <silent> <leader>bb :CtrlPBuffer<cr>
nn <silent> <leader>bm :CtrlPMRUFiles<cr>
nn <silent> <leader>bf :CtrlPFunky<cr>
nn <silent> <leader>bF :exe 'CtrlPFunky ' . expand('<cword>')<Cr>
"fugitive mappings
nn <leader>ff :Git<space>
nn <leader>fg :GitCMD<space>
nn <leader>fs :Gstatus<cr>
nn <leader>fa :Git add %<cr>
nn <leader>fc :Gcommit -a -m ""<Left>
nn <leader>fd :Git diff %<cr>
nn <leader>fl :GitCMD log -4<cr>
nn <leader>fp :Git push origin master

nn <Leader>m :sim ~x<cr>
nn <Leader>/ :.s/\//\\/g<cr>:nohl<cr>
nn <Leader>\ :.s/\\/\//g<cr>:nohl<cr>

nn <leader>pu :Phpunit<space>
nn <space>f :exe "silent !" . g:fileBrowser . " %:h"<CR>
nn <silent> <leader>pm :exe g:launchWebBrowser."http://www.php.net/".expand("<cword>")<CR>
nn <silent> <leader>ww :exe g:launchWebBrowser."http://cn.bing.com/search?q=".expand("<cword>")<CR>
nn <silent> <leader>we :exe g:launchWebBrowser."http://translate.google.cn/\\#en/zh-CN/".expand("<cword>")<CR>
nn <silent> <leader>wb :exe g:launchWebBrowser."http://www.baidu.com/s?wd=".expand("<cword>")<CR>
nn <silent> <leader>wg :exe g:launchWebBrowser."https://www.google.com.hk/search?q=".expand("<cword>")<CR>
nn <silent> <leader>wl :exe g:launchWebBrowser.substitute(expand("<cWORD>"), '^(\\|)$', '', 'g')<CR>

nn <silent> <leader>wp :set nowrap!<CR>
nn <silent> gl g;g,

vn <silent> <space>ya "ay
vn <silent> <space>yb "by
vn <silent> <space>yc "cy
vn <silent> <space>yd "dy
vn <silent> <space>ye "ey
vn <silent> <space>yf "fy
vn <silent> <space>yg "gy

nn <silent> <space>pp "0p
nn <silent> <space>PP "0P
nn <silent> <space>pa "ap
nn <silent> <space>pb "bp
nn <silent> <space>pc "cp
nn <silent> <space>pd "dp
nn <silent> <space>pe "ep
nn <silent> <space>pf "fp
nn <silent> <space>pg "gp

vmap s <Plug>(easymotion-prefix)
nmap s <Plug>(easymotion-prefix)
nmap <leader><leader> <Plug>(easymotion-prefix)

nn <leader>df :vertical diffsplit<Space>

" }}}

" custom commands {{{
com! -nargs=* GitCMD :
    \ if exists("b:git_dir") |
    \ cd`=b:git_dir[0:-6]` |
    \   exe "call k#ReadExCmdIntoConsole('botri ','git','!git <args>')" |
    \ endif

com! -nargs=1 S let @/='\<'.<f-args>.'\>' | normal n
com! -nargs=? CC cd %:h
com! -nargs=? PHPTag !ctags --fields=+aimS --languages=php <args>
com! -nargs=0 -bar Dos2Unix :%s/\r//g|set ff=unix
com! -nargs=0 -bar FmtXML :%s/>\s*</>\r</ge|set ft=xml|normal ggVG=
com! -nargs=0 -bar FmtJSON :%s/,"/,\r"/ge|%s/{"/{\r"/ge|%s/\(\S\)}/\1\r}/ge|set ft=javascript|normal ggVG=
com! -nargs=0 -bar RmTrailingBlanks :%s/\s\+$//g
com! -nargs=* Phpunit :exe "!phpunit <args>"
com! -nargs=? XD :exe g:launchWebBrowser."http://localhost/<args>?XDEBUG_SESSION_START=1"
com! -nargs=* -complete=command -bar R call k#ReadExCmdIntoConsole("10sv", "", <q-args>)
com! -nargs=1 Snip call LoadSnippets(<f-args>, &ft)
com! -nargs=1 Phpdict :let g:neco_php_default_sources=<q-args>
com! -nargs=0 Col :%s/\s.*//g
" }}}

" auto commands {{{
"Return to last edit position when opening files
au BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

au BufEnter *.htm,*.html,*.tpl,*.phtml,*.css,*.snippets setlocal noexpandtab
au BufEnter *.htm,*.html,*.tpl,*.phtml
    \ setlocal ts=2 |
    \ setlocal sts=2 |
    \ setlocal sw=2 |
    \ setlocal nolist |
    \ set syntax=php

au FileType php call PHPFileSettings()
au InsertEnter * set cul
au InsertLeave * set nocul
" }}}

" misc {{{

" neocomplcache settings {{{
let g:neco_php_default_sources='phpunit'
"toggle neocomplcache
nmap <C-Y><C-Y> :let g:neocomplcache_disable_auto_complete = !g:neocomplcache_disable_auto_complete<cr>
imap <C-Y><C-Y> <Esc>:let g:neocomplcache_disable_auto_complete = !g:neocomplcache_disable_auto_complete<cr>a
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_disable_auto_complete = 1
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
        \ }
" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

ino <expr><C-j> pumvisible() ? "\<C-n>" : neocomplcache#start_manual_complete()
ino <expr><C-k> neocomplcache#undo_completion()

" Recommended key-mappings.
" <CR>: close popup and save indent.
"ino <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction

" completion
ino <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "\<CR>"
ino <expr><SPACE>  pumvisible() ? neocomplcache#close_popup() : "\<Space>"
" <C-h>, <BS>: close popup and delete backword char.
"ino <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"ino <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"ino <expr><C-e>  neocomplcache#cancel_popup()

" For cursor moving in insert mode(Not recommended)
"ino <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"ino <expr><Right> neocomplcache#close_popup() . "\<Right>"
"ino <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"ino <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"ino <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
"au FileType css setlocal omnifunc=csscomplete#CompleteCSS
"au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
"let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
" }}}

" surrounds
let g:surround_{char2nr("%")} = "{% \r %}"

"xdebug settings
let g:dbgPavimPort = 9009
let g:dbgPavimBreakAtEntry = 0

"kdb settings
let g:globalDBkeys = {
      \ 'oxford7' : '<leader>ll',
      \ }
let g:localDBkeys = {
      \ 'php' : ['Q', '<C-8>'],
      \ }

let g:snippets_dir = $vim_root . '/snippets/'
"emmet settings
let g:user_emmet_expandabbr_key = '<C-E>'
"taglist settings
let Tlist_Show_One_File = 1
"nerdtree settings
let NERDTreeMinimalUI=1
let NERDTreeChDirMode=2
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\~$','^\.\+$','^\.\(git\|svn\|settings\|project\|metadata\|buildpath\)$']

"let g:vim_markdown_folding_disabled=1
let g:vim_markdown_initial_foldlevel=1

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
set rtp+=$vim_root/bundle/Vundle.vim
call vundle#begin($vim_root."/bundle")
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'msanders/snipmate.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'brookhong/DBGPavim'
Plugin 'brookhong/k.vim'
Plugin 'Shougo/neocomplcache'
Plugin 'joy2fun/neco-php'
Plugin '2072/PHP-Indenting-for-VIm'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'plasticboy/vim-markdown'
call vundle#end()
filetype plugin indent on
syntax on
" }}}

"Functions {{{
fun! PHPFileSettings()
    "php mappings
    nn <buffer> <leader>dd :set paste<CR>:call PhpDocSingle()<CR>:set nopaste<CR>
    nn <buffer> <leader>da :set paste<CR>:%call PhpDocRange()<CR>:set nopaste<CR>
    nn <buffer> <leader>u :Phpunit %<CR>
    nn <buffer> <space>l :call k#RunMe('php -l', 'botri 10', '')<CR>
    nn <buffer> <space>r :call k#RunMe('php ', 'botri 10', '')<CR>
    nn <buffer> <space><space> :call WrapMoveToCharInLine('$')<CR>
    nn <buffer> <space>g :Rc !grep -irl --include=*.php<space>
endfun

fun! WrapMoveToCharInLine(char)
    let l:old_col = col('.')
    let l:current_col = l:old_col
    exe "normal! f".a:char
    if l:current_col == col('.')
        exe "normal! 0f".a:char
        if l:old_col != 1 && 1 == col('.')
            exe "normal " . l:old_col . "l"
        endif
    endif
endfun

fun! LoadSnippets(p, ft)
    call ResetSnippets(a:ft)
    let snips = split('_,'.a:p, ',')
    for name in snips
        call ExtractSnipsFile(g:snippets_dir . name . '.snippets', a:ft)
    endfor
endfun
" }}}
