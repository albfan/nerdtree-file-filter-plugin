""" directory ignore 

" confirm it ignores directories without matching files

NERDTree
normal O
let g:NERDTreeFileFilterRegexp = 'a$\|/and-this'
normal ff
5,$w ../test2.out
