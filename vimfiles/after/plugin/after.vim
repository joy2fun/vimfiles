
if exists("g:loaded_fugitive")
    set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
endif

"neocomplcache settings
if exists("g:loaded_neocomplcache")
    source $VIM/neoco.vim
endif
