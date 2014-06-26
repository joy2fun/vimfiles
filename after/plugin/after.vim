if exists("g:loaded_fugitive")
    set statusline=%<%f\ %h%m%r%{fugitive#statusline()}[%{&ff}][%{&fenc}]\ %=%-10.(%l,%c%V%)\ %P
else
    set statusline=%<%f\ %h%m%r[%{&ff}][%{&fenc}]\ %=%-10.(%l,%c%V%)\ %P
endif
