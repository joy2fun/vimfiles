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
set scrolloff=5
set ignorecase
set lazyredraw
set noerrorbells
set vb t_vb=
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

if has("gui")
    set guitablabel=%{TabTitle()}
endif

if has('mouse')
  set mouse=a
endif

let mapleader = ","
let $vim_root = expand("<sfile>:p:h")
"source $VIMRUNTIME/mswin.vim
"behave mswin
"colors molokai
" }}}

" os specific {{{
fun! IsPath(path)
    return !empty(glob(a:path))
endfun

let g:ismac=(system("uname -s") =~ "Darwin")
let g:ismingw=(system("uname -s") =~ "MINGW")

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
    if (g:ismac)
        let g:launchWebBrowser=":silent ! open /Applications/Safari.app "
        let g:fileBrowser="open"
        let g:wwwroot="~/git"
    elseif (g:ismingw)
        let g:launchWebBrowser=":silent ! start "
        let g:fileBrowser="explorer"
        let g:wwwroot="~"
    else
        let g:launchWebBrowser=":!/usr/bin/google-chrome "
        let g:kdbDir="~/kdb"
        let g:fileBrowser="nautilus"
        let g:wwwroot="/opt/lampp/htdocs"
    endif
    if !IsPath(g:wwwroot)
        let g:wwwroot="~"
    endif
endif

cd`=g:wwwroot`

" }}}

" mappings {{{
noremap j gj
noremap k gk
nmap H <C-W>h
nmap L <C-W>l
nmap J <C-W>j
nmap K <C-W>k
map gh gT
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
ino <C-U> <C-G>u<C-U>
nn <silent> Q :exe ":h ".expand("<cword>")<cr>
nn <silent> <leader>n :NERDTreeToggle<cr>
nn <silent> <leader>e :CC<cr>:NERDTree .<cr>
nn <silent> <space>n :set nolist!<cr>
nn <silent> <space>v :windo wincmd H<cr>
nn <silent> <space>w :q<cr>
"switch single line. breaks on first/last line
ino <M-Up> <Esc>ddkP$a
ino <M-Down> <Esc>ddp$a

nn <silent> <space>t :tabe<CR>
"nn <silent> <space>q :q<CR>
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
nn <silent> <leader>bm :CtrlPMRUFiles<cr>
nn <silent> <leader>bf :CtrlPFunky<cr>
nn <silent> <leader>bF :exe 'CtrlPFunky ' . expand('<cword>')<Cr>
"fugitive mappings
nn <leader>fs :Gstatus<cr>
nn <leader>fc :Gcommit -a -m ""<Left>
nn <leader>fd :Git diff %<cr>
nn <leader>fl :GitCMD log -4<cr>

nn <Leader>m :sim ~x<cr>
nn <Leader>/ :.s/\//\\/g<cr>:nohl<cr>
nn <Leader>\ :.s/\\/\//g<cr>:nohl<cr>

nn <leader>pu :Phpunit<space>
nn <space>f :exe "silent !" . g:fileBrowser . " %:h"<CR>
nn <silent> <leader>pm :exe g:launchWebBrowser."http://www.php.net/".expand("<cword>")<CR>
nn <silent> <leader>ww :exe g:launchWebBrowser."http://cn.bing.com/search?q=".expand("<cword>")<CR>
nn <silent> <leader>wb :exe g:launchWebBrowser."http://www.baidu.com/s?wd=".expand("<cword>")<CR>
"nn <silent> <leader>wl :exe g:launchWebBrowser.substitute(expand("<cWORD>"), '^(\\|)$', '', 'g')<CR>

nn <silent> <leader>wp :set nowrap!<CR>

nn <silent> <C-T> :exe ':tabe '.expand("<cWORD>")<CR>

map <silent> sv <Esc>:update<CR>

map ss <Plug>(easymotion-s)
map sw <Plug>(easymotion-w)
map sb <Plug>(easymotion-b)
map sj <Plug>(easymotion-bd-jk)
map sk <Plug>(easymotion-bd-jk)
map mv <Plug>(easymotion-s)$
map mg <Plug>(easymotion-s)>
map ml <Plug>(easymotion-s)<
map me <Plug>(easymotion-s)=
map mq <Plug>(easymotion-s)"
map mb <Plug>(easymotion-s)(
map mc <Plug>(easymotion-s){

map <silent> gk :exe "normal "+(line('w0')+&scrolloff)+"G"<CR>
map <silent> gj :exe "normal "+(line('w$')-&scrolloff)+"G"<CR>

nn <leader>df :vertical diffsplit<Space>
nn ' `

omap aq a"
vmap aq a"
omap iq i"
vmap iq i"

nn <Leader>fa vib:Tabularize /=><CR>
vn <Leader>fa :Tabularize /=><CR>
nn <Leader>fe vib:Tabularize /=<CR>
vn <Leader>fe :Tabularize /=<CR>

vmap <silent> <Tab> <Esc>:call search('\w\+', 'w')<CR>viw
nmap <silent> <S-Tab> <Esc>b:call search('\w\+', 'b')<CR>viw
vmap <silent> <S-Tab> <Esc>b:call search('\w\+', 'b')<CR>viw

nmap <silent> <C-F><C-N> :call search('\([''"]\)\s*\1', 'w')<CR>
nmap <silent> <C-F><C-M> :call search('\([''"]\)\s*\1', 'wb')<CR>
nmap <silent> <C-F><C-J> :call search('>\s*</', 'w')<CR>
nmap <silent> <C-F><C-K> :call search('>\s*</', 'wb')<CR>

imap <silent> <C-F><C-N> <Esc><C-F><C-N>a
imap <silent> <C-F><C-M> <Esc><C-F><C-M>a
imap <silent> <C-F><C-J> <Esc><C-F><C-J>a
imap <silent> <C-F><C-K> <Esc><C-F><C-K>a

nmap <silent> <C-F><C-F> <Plug>(easymotion-bd-w)
imap <silent> <C-F><C-F> <Esc><Plug>(easymotion-bd-w)

imap <silent> <C-G><C-H> <C-O>^
imap <silent> <C-G><C-L> <C-O>$

cmap w!! %!sudo tee > /dev/null %

nn <space>1 :exe "call k#RunMe('man 1 ".expand('<cword>')."', '', '')"<cr>
nn <space>2 :exe "call k#RunMe('man 2 ".expand('<cword>')."', '', '')"<cr>
nn <space>3 :exe "call k#RunMe('man 3 ".expand('<cword>')."', '', '')"<cr>
nn <space>g :call CscopeFindInteractive(expand('<cword>'))<CR>
nn <space>l :call ToggleLocationList()<CR>
nn <leader>gs :call CscopeFind('s', expand('<cword>'))<CR>
nn <leader>gg :call CscopeFind('g', expand('<cword>'))<CR>
nn <leader>gd :call CscopeFind('d', expand('<cword>'))<CR>
nn <leader>gc :call CscopeFind('c', expand('<cword>'))<CR>
nn <leader>gt :call CscopeFind('t', expand('<cword>'))<CR>
nn <leader>ge :call CscopeFind('e', expand('<cword>'))<CR>
nn <leader>gf :call CscopeFind('f', expand('<cword>'))<CR>
nn <leader>gi :call CscopeFind('i', expand('<cword>'))<CR>
nn <leader>gj :call CscopeFind('g', '<C-R>"')<CR>
nn <leader>gh :call CscopeFind('s', '<C-R>"')<CR>
nn <leader>gk :call CscopeFind('c', '<C-R>"')<CR>

nn <space>cr :exe "!gcc -std=c99 -Wall -Wextra % -o ".expand("%:p").".out && ".expand("%:p").".out"<CR>
nn <space>cg :exe "!gcc % -g -o ".expand("%:p").".out && lldb ".expand("%:p").".out"<CR>
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
com! -nargs=0 -bar Df :difft|normal L|:difft<CR>
" }}}

" auto commands {{{
"Return to last edit position when opening files
au BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

au BufEnter *.conf setlocal ft=nginx
au BufEnter *.md setlocal ft=markdown | Snip mkd
au BufEnter *.htm,*.html,*.tpl,*.phtml,*.css,*.snippets setlocal noexpandtab
au BufEnter *.vue,*.js 
    \ setlocal ts=2 |
    \ setlocal sts=2 |
    \ setlocal sw=2 |
    \ setlocal nolist |
    \ setlocal expandtab
au BufEnter *.htm,*.html,*.tpl,*.phtml,*.phpt
    \ setlocal ts=2 |
    \ setlocal sts=2 |
    \ setlocal sw=2 |
    \ setlocal nolist |
    \ set syntax=php

au FileType nerdtree nmap <buffer> l <Plug>(easymotion-bd-jk)
au FileType php call PHPFileSettings()

if (exists("+imdisable"))
    au InsertEnter *
        \ set nocursorline |
        \ set noimdisable
    au CursorMoved *
        \ set cursorline |
        \ set imdisable
else
    au InsertEnter *
        \ set nocursorline
    au CursorMoved *
        \ set cursorline
endif

if (g:ismac)
    "au InsertLeave * !im-select com.apple.keylayout.ABC
endif

" }}}

" misc {{{

" neocomplcache settings {{{
let g:neco_php_default_sources='phpunit'
"toggle neocomplcache
nmap <C-Y><C-Y> :let g:neocomplcache_disable_auto_complete = !g:neocomplcache_disable_auto_complete<cr>
imap <C-Y><C-Y> <Esc>:let g:neocomplcache_disable_auto_complete = !g:neocomplcache_disable_auto_complete<cr>a
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_disable_auto_complete = 0
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

" gist
let g:gist_open_browser_after_post = 1
if !has('win32')
    let g:gist_browser_command = g:launchWebBrowser . ' %URL%'
endif
let g:gist_show_privates = 1
let g:gist_post_private = 1
let g:gist_update_on_write = 2

" airline
let g:airline_power_fonts=1
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ }

" surrounds
let g:surround_{char2nr("S")} = "['\r']"
let g:surround_{char2nr("t")} = "<\1tag: \1>\r</\1\1>"
let g:surround_{char2nr("i")} = "if () {\n    \r\n}"
let g:surround_{char2nr("e")} = "try {\n    \r\n} catch (\Exception $e) {\n}"

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
let NERDTreeIgnore=['\~$','^\.\+$','^\.\(git\|svn\|settings\|project\|metadata\|buildpath\|DS_Store\)$']

"let g:vim_markdown_folding_disabled=1
let g:vim_markdown_initial_foldlevel=1

" ctrlp setup {{{
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 25
let g:ctrlp_mruf_exclude = 'dbgpavim_cli.*'
let g:ctrlp_custom_ignore = {
      \ 'dir': '\.git$\|\.hg$\|\.svn$',
      \ 'file': '\.DS\|\.3dm$\|\.3g2$\|\.3gp$\|\.7z$\|\.a$\|\.a.out$\|\.accdb$\|\.ai$\|\.aif$\|\.aiff$\|\.app$\|\.arj$\|\.asf$\|\.asx$\|\.au$\|\.avi$\|\.bak$\|\.bin$\|\.bmp$\|\.bz2$\|\.cab$\|\.cer$\|\.cfm$\|\.cgi$\|\.com$\|\.cpl$\|\.csr$\|\.csv$\|\.cue$\|\.cur$\|\.dat$\|\.db$\|\.dbf$\|\.dbx$\|\.dds$\|\.deb$\|\.dem$\|\.dll$\|\.dmg$\|\.dmp$\|\.dng$\|\.doc$\|\.docx$\|\.drv$\|\.dwg$\|\.dxf$\|\.ear$\|\.efx$\|\.eps$\|\.epub$\|\.exe$\|\.fla$\|\.flv$\|\.fnt$\|\.fon$\|\.gadget$\|\.gam$\|\.gbr$\|\.ged$\|\.gif$\|\.gpx$\|\.gz$\|\.hqx$\|\.ibooks$\|\.icns$\|\.ico$\|\.ics$\|\.iff$\|\.img$\|\.indd$\|\.iso$\|\.jar$\|\.jpeg$\|\.jpg$\|\.key$\|\.keychain$\|\.kml$\|\.lnk$\|\.lz$\|\.m3u$\|\.m4a$\|\.max$\|\.mdb$\|\.mid$\|\.mim$\|\.moov$\|\.mov$\|\.movie$\|\.mp2$\|\.mp3$\|\.mp4$\|\.mpa$\|\.mpeg$\|\.mpg$\|\.msg$\|\.msi$\|\.nes$\|\.o$\|\.obj$\|\.ocx$\|\.odt$\|\.otf$\|\.pages$\|\.part$\|\.pct$\|\.pdb$\|\.pdf$\|\.pif$\|\.pkg$\|\.plugin$\|\.png$\|\.pps$\|\.ppt$\|\.pptx$\|\.prf$\|\.ps$\|\.psd$\|\.pspimage$\|\.qt$\|\.ra$\|\.rar$\|\.rm$\|\.rom$\|\.rpm$\|\.rtf$\|\.sav$\|\.scr$\|\.sdf$\|\.sea$\|\.sit$\|\.sitx$\|\.sln$\|\.smi$\|\.so$\|\.svg$\|\.swf$\|\.swp$\|\.sys$\|\.tar$\|\.tar.gz$\|\.tax2010$\|\.tga$\|\.thm$\|\.tif$\|\.tiff$\|\.tlb$\|\.tmp$\|\.toast$\|\.torrent$\|\.ttc$\|\.ttf$\|\.uu$\|\.uue$\|\.vb$\|\.vcd$\|\.vcf$\|\.vcxproj$\|\.vob$\|\.war$\|\.wav$\|\.wma$\|\.wmv$\|\.wpd$\|\.wps$\|\.xll$\|\.xlr$\|\.xls$\|\.xlsx$\|\.xpi$\|\.yuv$\|\.Z$\|\.zip$\|\.zipx$\|\.lib$\|\.res$\|\.rc$\|\.out$',
      \ }
let g:ctrlp_extensions = ['funky']
let g:ctrlp_prompt_mappings = {
    \ 'PrtDeleteEnt()':       ['<F7>', '<c-g>'],
    \ 'PrtExit()':            ['<esc>', '<c-c>'],
    \ }
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
Plugin 'bling/vim-airline'
"Plugin 'brookhong/cscope.vim'
Plugin 'joy2fun/k.vim'
Plugin 'joy2fun/neocomplcache.vim'
Plugin 'joy2fun/neco-php'
Plugin 'joy2fun/nginx.vim'
Plugin '2072/PHP-Indenting-for-VIm'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'posva/vim-vue'
Plugin 'octol/vim-cpp-enhanced-highlight'

" disable taglist
let loaded_taglist = 'no'

call vundle#end()
filetype plugin indent on
syntax on
" }}}

"Functions {{{
fun! PHPFileSettings()
    "php mappings
    nn <buffer> <leader>dd :set paste<CR>:call PhpDocSingle()<CR>:set nopaste<CR>
    nn <buffer> <leader>da :set paste<CR>:%call PhpDocRange()<CR>:set nopaste<CR>
    nn <buffer> <space>l :call k#RunMe('php -l', 'botri 10', '')<CR>
    nn <buffer> <space>r :call k#RunMe('php ', 'botri 10', '')<CR>
    nn <buffer> <space>g :Rc !grep -irl --include=*.php  *<Left><Left>
endfun

fun! LoadSnippets(p, ft)
    call ResetSnippets(a:ft)
    let snips = split('_,'.a:p, ',')
    for name in snips
        call ExtractSnipsFile(g:snippets_dir . name . '.snippets', a:ft)
    endfor
endfun

fun! s:setcwd()
    let cph = expand('%:p:h', 1)
    if cph =~ '^.\+://' | retu | en
    for mkr in ['project.txt', '.git/', '.hg/', '.svn/', '.bzr/', '_darcs/', '.vimprojects']
      let wd = call('find'.(mkr =~ '/$' ? 'dir' : 'file'), [mkr, cph.';'])
      if wd != '' | let &acd = 0 | brea | en
    endfo
    let cph = fnameescape(wd == '' ? cph : substitute(wd, mkr.'$', '.', ''))
    if !empty(glob(cph))
        exe 'lc!' . cph
    endif
endfun
autocmd BufEnter * call s:setcwd()

fun! TabTitle()
    let label = ''
    let bufnrlist = tabpagebuflist(v:lnum)
    for bufnr in bufnrlist
        if getbufvar(bufnr, "&modified")
            let label = '+ '
            break
        endif
    endfor
    return label . substitute(expand('%:p'), '\(.:\?\)[^\\/]*\([\\/]\)', '\1\2', 'g')
    return label . expand('%:t') " tail part only
endfun

" }}}

"Colors {{{
hi Search cterm=NONE ctermfg=DarkGrey ctermbg=LightYellow
" }}}
