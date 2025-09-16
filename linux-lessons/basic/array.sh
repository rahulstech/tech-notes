nums=() # initialize an empty array; it is not mandatory
nums+=(5) # appending a single element
nums+=(7 8 9 10 11 12 13 14 15 16 17 18 19) # appending multiple elements

echo "size of the array ${#nums[@]}" # returns the size of array ; Note the use of [@]

for n in ${nums[@]} # accessing array values with nums[@]
do
echo $n
done

nums[1]=20 # update array element by index
echo ${nums[1]} # access array element by index

# creating sub array ; arrayvar[@]:start_index:length
# note the use of nums[@] not nums. if we don't use nums[@] then it will create the substring of nums
subnums=${nums[@]:3:6}  
echo ${subnums[*]} # subnums[*] returns all the values as a single string

echo ${!nums[*]} # returns all the indices as string ; use !nums[@] to get the indices separately