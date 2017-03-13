""" file ignore

" check for simple file filter

NERDTree
normal O
let g:NERDTreeFileFilterRegexp = 'a$'
normal ff
5,$w ../test1.out
