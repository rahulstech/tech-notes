declare -A dic # to use array as dictionary i need to declare it first, for plain array i don't need this
dic=( [key1]="val1" [key2]="val2" [key3]="val3")
dic+=([Key4]="val4")

# main difference between, note the double quote
# "${dic[*]}": returns all values in a single string
# "${dic[@]}": returns all values separately
# how to check that?
#
# for v in "${dic[*]}""
# do 
#     echo $v
# done
#
# prints all values in a single string
# "val1 val2 val3 val4"
#
# for v in "${dic[@]}""
# do 
#     echo $v
# done
#
# prints all values in seperate lines
# val1
# val2
# val3
# val4

# print only values

echo "printing the values in dictionary"

for v in ${dic[@]}
do 
    echo $v
done 

# print only keys

echo "printing the keys in dictionary"

for k in ${!dic[@]}
do
    echo $k
done

# value by key
echo "key1=${dic[key1]}"

# change the value by key
dic+=( [key2]="val2 updated" ) # or dic[key2]="val2 udpated"
echo "new valueof key2=${dic[key2]}"