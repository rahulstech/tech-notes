# read -p "how many iteration you want: " it

# count=0

# while (( count < it ))
# do
#     echo "step $count"
#     ((count++))
# done


# arr=( 1 2 5 3 4 9 7 3)
# for x in ${arr[*]}
# do
#     echo $x
# done

echo "This script will filter even numbers from array of numbers"

read -p "how many numbers want to enter: " nnum

count=0
numbers=()

while ((count++ < nnum))
do
    read -p "enter next number: " x
    numbers+=($x)
done

evennumbers=()
for x in ${numbers[*]}
do
    if (( x%2 == 0 ))
    then
        evennumbers+=($x)
    fi
done

if (( ${#evennumbers[*]} == 0 )) 
then
    echo "no even number found"
else
    echo "even numbers are: "
    for y in ${evennumbers[*]}
    do
        echo $y
    done
fi

# read -p "enter number: " x
# if (( x%2 == 0 ))
# then
#     echo "$x is even"
# else 
#     echo "$x is odd"
# fi