declare -A dictionary

for ext in png txt svg jpg 
do 
    # i used ${ext}_file. if i did $ext_file then it will expect a variable named ext_file, which is not the case
    vname="${ext}_file"

    # with declare -n ref, ref stores the reference to the variable
    # for example: if vname = txt_files then ref stores the reference to the variable txt_file. 
    # therefore, when i set value to ref it actually changes the value of the variable it points to
    # in the above exampe it changes the value of txt_files variable.
    # i can choose any name instread of ref here

    declare -n ref="${vname}" 
    ref="the extension is $ext"

    # adding a value with key as the value in ext, and value is the name of a variable
    dictionary[$ext]=$vname
    echo "$vname"
done 

for ext in ${!dictionary[@]}
do
    echo "dictionary key: $ext value: ${dictionary[$ext]}"
    declare -n ref=${dictionary[$ext]} # referencing the variable
    echo "reference value: $ref" # printing the value of the referenced variable
    echo ""
done 