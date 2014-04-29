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
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-surround'

Plugin 'ervandew/supertab'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'

Plugin 'kien/ctrlp.vim'
Plugin 'brookhong/DBGPavim'

Plugin 'StanAngeloff/php.vim'

Plugin 'Lokaltog/vim-easymotion'

Plugin 'file:///'.$VIM.'/vimfiles/bundle/php_doc' 
Plugin 'file:///'.$VIM.'/vimfiles/bundle/bufexplorer-7.4.2' 

call vundle#end()

imap <C-J> <Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger

let g:dbgPavimPort = 9009
let g:dbgPavimBreakAtEntry = 0
