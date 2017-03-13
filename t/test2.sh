mkdir -p shouldnt/see/this
touch shouldnt/see/this/ignore

mkdir -p ignore/empty/directory/matching

mkdir -p should/see/this/
touch {should/,should/see/,should/see/this/}{matching1,matching2,matching3}
