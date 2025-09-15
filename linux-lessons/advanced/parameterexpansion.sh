path="path/to/directory/target.ext1.ext2"

# 1. remove everything after first / and return :  path
echo ${path%%/*}

# 2. remove everything after last / and return : path/to/directory
echo ${path%/*} 

# 3.  remove everything before first / , including /, and return : to/directory/target.ext1.ext2
echo ${path#*/} #

# 4. remove everythig before last /, including /, and return : target.ext1.ext2
echo ${path##*/}

# 5. remove everything before first . (period), include . (period), and return : ext1.ext2
echo ${path#*.}

# 6. remove everything before last . (period), including . (period), and return : ext2
echo ${path##*.}

# NOTE: 6 can be used to get last extension name
#       4 can be used to get last path segment or basename