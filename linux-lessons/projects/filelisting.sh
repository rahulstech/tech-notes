# don't use ls. because ls in loop splits the paths by whitespaces and special charaters.
# therefore file or directory names with whitespace and special charaters will be considred two entries
# for example: consider the file name "file name.txt". if i use ls in loop it will give "file" and "name.txt"
# 
# solution is "/path/to/directory"/* : returns entries inside the directory "/path/to/directory". NOTE: the trailing /*


##############################################################################################
#                                                                                            #
# when working with file path always wrap the path in "" (double quote),                     #
# otherwise whitespaces and special charater may cause problem and produce unwanted results  #
#                                                                                            #
##############################################################################################

get_file_extension() {
	file_name=$1
	ext=${file_name##*.}
	echo "$ext"
}

if (($# != 2)) # if no. of command line argument is not 2 then it's an error and exit
then
	echo "CORRECT USAGE: filelisting.sh TARGET DESTINATION"
	exit 1
fi

declare -A extensions

# access command line arguments with $1 $2 etc. outside any function. inside a function these will give the function arguments

target=$(realpath "$1")
destination=$(realpath "$2")

for entry in "$target"/* 
do 
	if [[ -f "$entry" ]] # use path in "" (double quote), otherwise whitespaces and special characters may produce unexpected results
	then
		ext=$(get_file_extension "$entry")
		vname="${ext}_files"
		declare -n ref="$vname"
		extensions["$ext"]="$vname"
		ref+=( "$entry" )
	fi
done

# create the destination directory if not exists
if [[ ! -d "$destination" ]]
then
	mkdir "$destination"
fi


for ext in ${!extensions[@]}
do
	uext=${ext^^} # change extention name to uppercase

	dir="$destination/$uext" # name of directory where all files with $ext extentions will be copies

	mkdir -p "$dir" # create the diretory for $ext extention files. -p ignores dir creation if already exists

	declare -n ref=${extensions[$ext]} # store the reference to the array containing files names with the extentions $ext

	# i can not use for loop because in for loop path containing whitespaces behaves abnormally
	# so i am using while loop and getting the path by index
	len=${#ref[@]}
	while ((--len >= 0))
	do 
		path="${ref[$len]}"
		cp "$path" "$dir" # copy file to destination
	done 
done 

# example: bash filelisting.sh '/path/to/target/dir' '/path/to/destination/dir'