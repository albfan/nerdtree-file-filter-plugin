# multiple non matching files
mkdir -p foo/bar/shouldnt/see/this
touch {,foo/,foo/bar/}{a,b,c,d,e}

# no match
mkdir -p foo/bar/shouldnt/see/this
touch foo/bar/shouldnt/see/this/ignore

# matching directory but not file
mkdir -p  foo/see-this/and-this/
touch  foo/see-this/and-this/ignore-this
