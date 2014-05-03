set nocompatible  

let $LANG='en'
set enc=utf-8
set guioptions-=m
set guioptions-=L
set guioptions-=T
set guioptions-=r

let g:vundle_lazy_load=1
set rtp+=$VIM/vimfiles/bundle/Vundle.vim/
let path='$VIM/vimfiles/bundle'
call vundle#rc(path)

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-surround'

"Plugin 'ervandew/supertab'

"garbas snipmate
"Plugin 'MarcWeber/vim-addon-mw-utils'
"Plugin 'tomtom/tlib_vim'
"Plugin 'garbas/vim-snipmate'

Plugin 'msanders/snipmate.vim'
let g:snippets_dir = '$VIM/vimfiles/snippets/'

Plugin 'kien/ctrlp.vim'
Plugin 'brookhong/DBGPavim'
Plugin 'brookhong/k.vim'

"Plugin 'Shougo/neocomplcache'
"Plugin 'brookhong/neco-php'
"source $VIM/neoco.vim 

Plugin 'shawncplus/phpcomplete.vim'

Plugin 'Lokaltog/vim-easymotion'

Plugin 'file:///'.$VIM.'/vimfiles/bundle/php_doc' 
Plugin 'file:///'.$VIM.'/vimfiles/bundle/bufexplorer-7.4.2' 

call vundle#end()

set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

let g:dbgPavimPort = 9009
let g:dbgPavimBreakAtEntry = 0
