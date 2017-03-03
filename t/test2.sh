
# Creates a git repo with simple ignore filter

mkdir -p foo/bar/shouldnt/see/this
touch {,foo/,foo/bar/}{a,b,c,d,e}
touch {,foo/bar/shouldnt/,foo/bar/shouldnt/see/,foo/bar/shouldnt/see/this/}{i,g,n,o,r,e}
