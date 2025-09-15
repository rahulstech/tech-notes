greet() {
    # access arguments with $1 $2 etc 
    echo "hello $1"
}

greet "Rahul" # calling the function with parameters

echo "===================================="

add() {
    # compute addition of two given numbers and return the result
    # NOTE: here i can not use return to return the result of the function
    #       return is used to exit a command and limited to values from 0 to 255
    #       instead i have to use echo or printf and later capture the value
    echo $(($1 + $2)) 
}

# execute the command i.e. function add with parameters and capture the result
result=$(add 52 96)
echo $result